//
//  ForthViewController.m
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/5/6.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import "ForthViewController.h"

@interface ForthViewController ()

@end

@implementation ForthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"四级user";
}

- (IBAction)pop2:(id)sender {
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 3] animated:YES];
}


@end
