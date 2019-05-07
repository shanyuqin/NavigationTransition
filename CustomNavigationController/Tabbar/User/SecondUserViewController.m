//
//  SecondUserViewController.m
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/4/26.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import "SecondUserViewController.h"
#import "ThirdUserViewController.h"
@interface SecondUserViewController ()

@end

@implementation SecondUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"二级user";
}
- (IBAction)go:(id)sender {
    ThirdUserViewController *vc = [[ThirdUserViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
