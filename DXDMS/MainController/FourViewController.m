//
//  FourViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/14.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "FourViewController.h"
#import "UserEditViewController.h"




#import "XiTongManagerTableViewController.h"
#import "ChanPinManagerTableViewController.h"
#import "JiTuanManagerTableViewController.h"
#import "KeHuManagerTableViewController.h"
#import "GonggaoListViewController.h"
@interface FourViewController ()
@property(nonatomic,strong)NSMutableArray *titArr;
@property(nonatomic,strong)NSMutableArray *imgArr;
@end

@implementation FourViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}


- (void)edit{
    UserEditViewController *edit = [[UserEditViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:edit];
    edit.navigationItem.title = @"设置";
    [self presentViewController:navi animated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    img.image = [UIImage imageNamed:@"bg1.jpg"];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 60)];
    vv.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [img addSubview:vv];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH-50, 30, 30, 30);
    [btn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [img addSubview:btn];

    UIImageView *userImg = [[UIImageView alloc]initWithFrame:CGRectMake(20,80, 100, 100)];
    userImg.image = [UIImage imageNamed:@"logo"];
    userImg.userInteractionEnabled = YES;
    LRViewBorderRadius(userImg, 50, 0, [UIColor clearColor]);
    [img addSubview:userImg];
    
    [img bringSubviewToFront:userImg];
    UILabel *userlab = [[UILabel alloc]initWithFrame:CGRectMake(120, 0, SCREEN_WIDTH-130, 60)];
    userlab.font = [UIFont systemFontOfSize:16];
    userlab.text = [NSString stringWithFormat:@"%@  %@",[Manager redingwenjianming:@"user.text"],[Manager redingwenjianming:@"phone.text"]];
    userlab.textColor = [UIColor whiteColor];
    [vv addSubview:userlab];
    self.titArr = [@[@"产品管理",@"集团管理",@"系统管理",@"客户管理",@"公告"]mutableCopy];
    self.imgArr = [@[@"产品管理",@"集团管理",@"系统管理",@"客户管理",@"公告管理"]mutableCopy];
    [self setbutton];
}





- (void)setbutton {
    int b = 0;
    int hangshu;
    if (self.titArr.count % 3 == 0 ) {
        hangshu = (int )self.titArr.count / 3;
    } else {
        hangshu = (int )self.titArr.count / 3 + 1;
    }
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 3; j++) {
            CustomButton *btn = [CustomButton buttonWithType:UIButtonTypeCustom];
            if ( b  < self.titArr.count) {
                btn.frame = CGRectMake((0  + j * SCREEN_WIDTH/3), (190+i * 120*SCALE_HEIGHT) ,SCREEN_WIDTH/3, 120*SCALE_HEIGHT);
                btn.backgroundColor = [UIColor whiteColor];
                btn.tag = b;
                [btn setTitle:self.titArr[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                height = i * 120*SCALE_HEIGHT + 200*SCALE_HEIGHT;
//                [self.scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, height)];
                UIImage *image = [UIImage imageNamed:self.imgArr[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(caidan:) forControlEvents:UIControlEventTouchUpInside];
                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                [btn.layer setBorderWidth:0.5f];
                [btn.layer setMasksToBounds:YES];
                [self.view addSubview:btn];
                if (b > self.titArr.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
}
- (void)caidan:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"产品管理"]) {
        ChanPinManagerTableViewController *jituan = [[ChanPinManagerTableViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"产品管理";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([sender.titleLabel.text isEqualToString:@"系统管理"]) {
        XiTongManagerTableViewController *jituan = [[XiTongManagerTableViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"系统管理";
        [self presentViewController:navi animated:YES completion:nil];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"集团管理"]) {
        JiTuanManagerTableViewController *jituan = [[JiTuanManagerTableViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"集团管理";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([sender.titleLabel.text isEqualToString:@"客户管理"]) {
        KeHuManagerTableViewController *jituan = [[KeHuManagerTableViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"客户管理";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([sender.titleLabel.text isEqualToString:@"公告"]) {
        GonggaoListViewController *jituan = [[GonggaoListViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"公告管理";
        [self presentViewController:navi animated:YES completion:nil];
    }
   
}











@end
