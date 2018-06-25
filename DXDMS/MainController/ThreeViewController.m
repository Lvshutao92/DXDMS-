//
//  ThreeViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/12.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveText)];
//    self.navigationItem.rightBarButtonItem = save;
    
}




@end
