//
//  UserViewController.m
//  CustomNavigationController
//
//  Created by shanyuqin on 2019/4/19.
//  Copyright © 2019 ShanYuQin. All rights reserved.
//

#import "UserViewController.h"
#import "SecondUserViewController.h"
@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)pushViewCon:(id)sender {
    SecondUserViewController *vc = [[SecondUserViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
