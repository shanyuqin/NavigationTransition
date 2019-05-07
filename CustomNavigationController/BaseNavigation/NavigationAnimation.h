//
//  NavigationAnimation.h
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/5/6.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NavigationAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign)UINavigationControllerOperation  navigationOperation;
@property (nonatomic, weak)UINavigationController * navigationController;
@property (nonatomic, assign)NSInteger  removeCount;

- (void)removeScreenShotWhenPopToRoot;

@end

NS_ASSUME_NONNULL_END
