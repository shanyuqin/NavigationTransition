//
//  TabbarViewController.m
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/4/19.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import "TabbarViewController.h"
#import "Home/HomeViewController.h"
#import "User/UserViewController.h"
#import "BaseNavigationViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UserViewController *user = [[UserViewController alloc] init];
    user.title = @"user";
    BaseNavigationViewController *na1 = [[BaseNavigationViewController alloc] initWithRootViewController:user];
    
    [self addChildViewController:na1];

    HomeViewController *home = [[HomeViewController alloc] init];
    home.title = @"home";
    BaseNavigationViewController *na2 = [[BaseNavigationViewController alloc] initWithRootViewController:home];
    
    [self addChildViewController:na2];
    
    
    
    
}


@end
