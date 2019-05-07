//
//  NavigationAnimation.m
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/5/6.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import "NavigationAnimation.h"
#import "AppDelegate.h"
#import "TabbarViewController.h"

@interface NavigationAnimation()

@property(nonatomic,strong)NSMutableArray * screenShotArray;
@property (nonatomic, strong) UIImageView * screenShotImageView;
@property (nonatomic, strong) UIView * coverView;

@end



@implementation NavigationAnimation


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return .4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {

    if (self.navigationOperation == UINavigationControllerOperationPush) {
        [self animationForPush:transitionContext];
    }else if (self.navigationOperation == UINavigationControllerOperationPop) {
        [self animationForPop:transitionContext];
    }
}

- (void)animationForPush:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    UIImage * screenImg = [self screenShot];
    self.screenShotImageView.image = screenImg;
    [self.screenShotArray addObject:screenImg];
    UIView * containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    [self.navigationController.view.window insertSubview:self.screenShotImageView atIndex:0];
    [self.navigationController.view.window insertSubview:self.coverView atIndex:1];
    
    
    self.navigationController.view.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
    self.screenShotImageView.transform = CGAffineTransformMakeScale(1, 1);
    self.coverView.alpha = 0;
    
    TabbarViewController *tabbar = (TabbarViewController *)self.navigationController.view.window.rootViewController;
    tabbar.tabBar.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        self.screenShotImageView.transform = CGAffineTransformMakeScale(0.98, 0.98);
        self.coverView.alpha = 0.75;
    } completion:^(BOOL finished) {
        tabbar.tabBar.hidden = NO;
        [self.coverView removeFromSuperview];
        [self.screenShotImageView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];

    
}

- (void)animationForPop:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    if (_removeCount > 0) {
        for (NSInteger i = 0; i < _removeCount; i ++) {
            if (i == _removeCount - 1) {
                self.screenShotImageView.image = [self.screenShotArray lastObject];
                _removeCount = 0;
                break;
            } else {
                [self.screenShotArray removeLastObject];
            }
        }
    } else {
        self.screenShotImageView.image = [self.screenShotArray lastObject];
    }
    
    UIView * containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    [self.navigationController.view.window insertSubview:self.screenShotImageView atIndex:0];
    [self.navigationController.view.window insertSubview:self.coverView atIndex:1];
    
    UIImageView * screentImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    UIImage * screenImg = [self screenShot];
    screentImgView.image =screenImg;
    [self.navigationController.view addSubview:screentImgView];
    
    
    self.screenShotImageView.transform = CGAffineTransformMakeScale(0.98, 0.98);
    self.coverView.alpha = 0.75;
    TabbarViewController *tabbar = (TabbarViewController *)self.navigationController.view.window.rootViewController;
    tabbar.tabBar.hidden = YES;
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeTranslation(ScreenWidth, 0);
        self.screenShotImageView.transform = CGAffineTransformMakeScale(1, 1);
        self.coverView.alpha = 0;
    } completion:^(BOOL finished) {
        [screentImgView removeFromSuperview];
        [self.screenShotImageView removeFromSuperview];
        [self.coverView removeFromSuperview];
        [self.screenShotArray removeLastObject];
        self.navigationController.view.transform = CGAffineTransformMakeTranslation(0, 0);
        tabbar.tabBar.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
    
    
    
}


- (void)removeScreenShotWhenPopToRoot {
    if (self.screenShotArray.count > 0) {
        UIImage *img = [self.screenShotArray firstObject];
        [self.screenShotArray removeAllObjects];
        [self.screenShotArray addObject:img];
    }
}

- (UIImage *)screenShot {
    
    UIGraphicsBeginImageContextWithOptions([UIScreen mainScreen].bounds.size, YES, 0);
    [self.navigationController.view.window drawViewHierarchyInRect:[UIScreen mainScreen].bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (UIImageView *)screenShotImageView {
    if (!_screenShotImageView) {
        _screenShotImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _screenShotImageView;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0;
    }
    return _coverView;
}

- (NSMutableArray *)screenShotArray {
    if (!_screenShotArray) {
        _screenShotArray = [[NSMutableArray alloc] init];
    }
    return _screenShotArray;
}
@end
