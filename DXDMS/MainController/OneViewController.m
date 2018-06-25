//
//  OneViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/2.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "OneViewController.h"
#import "IrregularLabel.h"
@interface OneViewController ()
@property(nonatomic,strong)IrregularLabel *label;
@end

@implementation OneViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.label = [[IrregularLabel alloc] initWithFrame:CGRectMake(90, 200, 200, 40)];
    [self.view addSubview:self.label];
    self.label.text = @"这是一个不规则label";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor orangeColor];
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:self.label];
   
}





@end
