//
//  AppDelegate.m
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/4/18.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import "AppDelegate.h"
#import "Tabbar/TabbarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.window.backgroundColor = [UIColor blackColor];
    [self setupController];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)setupController {
    TabbarViewController *tabbarVC = [[TabbarViewController alloc] init];
    self.window.rootViewController = tabbarVC;
}


@end
