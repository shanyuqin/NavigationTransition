//
//  InteractiveTransition.m
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/5/7.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import "InteractiveTransition.h"

@implementation InteractiveTransition{
    __weak UIViewController                             *_viewController;
    __weak id<UIViewControllerContextTransitioning>     _transitionContext;
    
    InteractiveTransitionType         _type;
    InteractiveTransitionDirection    _direction;
}

+ (InteractiveTransition *)interactiveTransitionType:(InteractiveTransitionType)type direction:(InteractiveTransitionDirection)direction{
    return [[InteractiveTransition alloc] initWithInteractiveTransitionType:type direction:direction];
}

- (instancetype)initWithInteractiveTransitionType:(InteractiveTransitionType)type direction:(InteractiveTransitionDirection)direction{
    if (self = [super init]) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureFromViewController:(UIViewController *)viewController{
    _viewController = viewController;
    [_viewController.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)]];
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    [super startInteractiveTransition:transitionContext];
    _transitionContext = transitionContext;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)sender{
    CGFloat percent = 0;
    switch (_direction) {
        case InteractiveTransitionDirectionLeft:
        {
            CGFloat translationY = -[sender translationInView:sender.view].x;
            percent = translationY / sender.view.frame.size.width;
        }
            break;
        case InteractiveTransitionDirectionRight:
        {
            CGFloat translationY = [sender translationInView:sender.view].x;
            percent = translationY / sender.view.frame.size.width;
        }
            break;
        case InteractiveTransitionDirectionTop:
        {
            UIView *toView = [_transitionContext viewForKey:UITransitionContextToViewKey];
            CGFloat translationY = -[sender translationInView:sender.view].y;
            percent = translationY / toView.frame.size.height;
        }
            break;
        case InteractiveTransitionDirectionDown:
        {
            CGFloat translationY = [sender translationInView:sender.view].y;
            percent = translationY / sender.view.frame.size.height;
        }
            break;
        default:
            break;
    }
    
    //大于等于1时，置为0.99，避免完成过渡会回弹一次
    percent = percent >= 1 ? 0.99 : percent;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _beganInteration = YES;
            [self startTranslition:percent];
            break;
        case UIGestureRecognizerStateChanged:
            if (percent > 0) {
                [self updateInteractiveTransition:percent];
            }
            break;
        case UIGestureRecognizerStateEnded:
            _beganInteration = NO;
            if (percent >= 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
            break;
        case UIGestureRecognizerStateCancelled:
            _beganInteration = NO;
            [self cancelInteractiveTransition];
            break;
        default:
            break;
    }
}

- (void)startTranslition:(CGFloat)percent{
    if (percent < 0) {
        return;
    }
    switch (_type) {
        case InteractiveTransitionTypePresent:
            !_startPresentCallback ?: _startPresentCallback();
            break;
        case InteractiveTransitionTypeDismiss:
            [_viewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case InteractiveTransitionTypePush:
            !_startPushCallback ?: _startPushCallback();
            break;
        case InteractiveTransitionTypePop:
            if ([_viewController isKindOfClass:[UINavigationController class]]) {
                [(UINavigationController *)_viewController popViewControllerAnimated:YES];
            }else{
                [_viewController.navigationController popViewControllerAnimated:YES];
            }
            break;
        default:
            break;
    }
}

@end
