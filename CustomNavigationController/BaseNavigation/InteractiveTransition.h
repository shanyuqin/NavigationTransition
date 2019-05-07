//
//  InteractiveTransition.h
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/5/7.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM (NSInteger, InteractiveTransitionType) {
    InteractiveTransitionTypePresent = 0,
    InteractiveTransitionTypeDismiss,
    InteractiveTransitionTypePush,
    InteractiveTransitionTypePop
};

typedef NS_ENUM(NSInteger, InteractiveTransitionDirection) {
    InteractiveTransitionDirectionLeft = 0,
    InteractiveTransitionDirectionRight,
    InteractiveTransitionDirectionTop,
    InteractiveTransitionDirectionDown
};

@interface InteractiveTransition : UIPercentDrivenInteractiveTransition


@property (copy, nonatomic  ) void (^startPresentCallback)(void);//如果需要通过手势进行模态视图的present在这个block中实现跳转
@property (copy, nonatomic  ) void (^startPushCallback)(void);//如果需要通过手势进行push在这个block中实现跳转
@property (assign, nonatomic) BOOL beganInteration;

+ (InteractiveTransition *)interactiveTransitionType:(InteractiveTransitionType)type
                                              direction:(InteractiveTransitionDirection)direction;

- (instancetype)initWithInteractiveTransitionType:(InteractiveTransitionType)type
                                        direction:(InteractiveTransitionDirection)direction;

- (void)addPanGestureFromViewController:(UIViewController *)viewController;


@end

NS_ASSUME_NONNULL_END
