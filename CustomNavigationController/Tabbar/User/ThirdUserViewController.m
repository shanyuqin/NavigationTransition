//
//  ThirdUserViewController.m
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/5/6.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import "ThirdUserViewController.h"
#import "ForthViewController.h"

@interface ThirdUserViewController ()

@end

@implementation ThirdUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"三级user";
}

- (IBAction)pop:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)push:(id)sender {
    ForthViewController *vc = [[ForthViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
