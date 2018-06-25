//
//  TwoViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/12.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "TwoViewController.h"


@interface TwoViewController ()


@end

@implementation TwoViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
   
}



@end
