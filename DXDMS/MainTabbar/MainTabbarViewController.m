//
//  MainTabbarViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/14.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (instancetype)init {
    if (self = [super init]) {
        OneViewController *oneVc = [[OneViewController alloc]init];
        UINavigationController *mainoneVC = [[UINavigationController alloc]initWithRootViewController:oneVc];
        oneVc.title = @"首页";
        mainoneVC.tabBarItem.image = [UIImage imageNamed:@"1"];
        mainoneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"01"];

        TwoViewController *twoVc = [[TwoViewController alloc]init];
        UINavigationController *maintwoVc = [[UINavigationController alloc]initWithRootViewController:twoVc];
        twoVc.title = @"购物车";
        maintwoVc.tabBarItem.image = [UIImage imageNamed:@"2"];
        maintwoVc.tabBarItem.selectedImage = [UIImage imageNamed:@"02"];

        ThreeViewController *threeVc = [[ThreeViewController alloc]init];
        UINavigationController *mainthreeVC = [[UINavigationController alloc]initWithRootViewController:threeVc];
        threeVc.title = @"订单";
        mainthreeVC.tabBarItem.image = [UIImage imageNamed:@"3"];
        mainthreeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"03"];

        FourViewController *fourVc = [[FourViewController alloc]init];
        fourVc.title = @"我的";
        fourVc.tabBarItem.image = [UIImage imageNamed:@"4"];
        fourVc.tabBarItem.selectedImage = [UIImage imageNamed:@"04"];
        
        self.tabBar.tintColor = [UIColor redColor];
        self.viewControllers = @[mainoneVC,maintwoVc,mainthreeVC,fourVc];
    }
    return self;
}





@end
