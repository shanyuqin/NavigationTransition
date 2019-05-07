//
//  BaseNavigationViewController.m
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/5/6.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import "BaseNavigationViewController.h"
#import "NavigationAnimation.h"
#import "InteractiveTransition.h"

@interface BaseNavigationViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) NavigationAnimation * navAnimation;
@property (strong, nonatomic) InteractiveTransition *interactivePop;

@end

@implementation BaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navAnimation = [[NavigationAnimation alloc] init];
    self.navAnimation.navigationController = self;
    self.delegate = self;
    
    _interactivePop = [InteractiveTransition interactiveTransitionType:InteractiveTransitionTypePop direction:InteractiveTransitionDirectionRight];
    [_interactivePop addPanGestureFromViewController:self];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSInteger removeCount = 0;
    for (NSInteger i = self.viewControllers.count - 1; i > 0; i--) {
        if (viewController == self.viewControllers[i]) {
            break;
        }
        removeCount ++;
        
    }
    self.navAnimation.removeCount = removeCount;
    return [super popToViewController:viewController animated:animated];

}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    [self.navAnimation removeScreenShotWhenPopToRoot];
    return [super popToRootViewControllerAnimated:animated];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    self.navAnimation.navigationOperation = operation;
    return self.navAnimation;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return _interactivePop.beganInteration ? _interactivePop : nil;
}


@end
