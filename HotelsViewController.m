//
//  HotelsViewController.m
//  Week6-HotelManager
//
//  Created by Joey Nessif on 9/7/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "HotelsViewController.h"

@interface HotelsViewController ()

@end

@implementation HotelsViewController


- (void)loadView {
  UIView *rootView = [[UIView alloc] init];
  rootView.backgroundColor = [UIColor purpleColor];
  self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"Hotels";
//  UINavigationItem *navItem = [[UINavigationItem alloc] init];
//  navItem.title = @"Hotels";
//    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
