//
//  UserEditViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/27.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "UserEditViewController.h"

@interface UserEditViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *bgview;
    UIButton *btn;
}



@property(nonatomic,strong)UITableView *tableview;


@end

@implementation UserEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 7, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = bar;
    self.companyTitle.text = [Manager redingwenjianming:@"companyTitle.text"];
    
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    bgview.hidden = YES;
    [self.view addSubview:bgview];
    
    btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(clickbtn) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:btn];
    
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"] || [[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone Simulator"]) {
        height = 88;
        self.viewtop.constant = 88;
    }else{
        height = 64;
        self.viewtop.constant = 64;
    }
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-450, SCREEN_WIDTH, 400)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [bgview addSubview:self.tableview];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = v;
    
    [self.view bringSubviewToFront:self.tableview];
    
    
    
}
- (void)clickbtn{
    bgview.hidden = YES;
}
- (IBAction)clickCompanyList:(id)sender {
    bgview.hidden = NO;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [Manager sharedManager].companyArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ModelOne *model = [[Manager sharedManager].companyArray objectAtIndex:indexPath.row];
    cell.textLabel.text =  model.companyName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ModelOne *model = [[Manager sharedManager].companyArray objectAtIndex:indexPath.row];
    cell.textLabel.text =  model.companyName;
    [Manager writewenjianming:@"companyTitle.text" content: model.companyName];
    [Manager writewenjianming:@"companyID.text" content: [NSString stringWithFormat:@"%@",model.id]];
    self.companyTitle.text = [Manager redingwenjianming:@"companyTitle.text"];
    bgview.hidden = YES;
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    NSNotification *notification =[NSNotification notificationWithName:@"qiehuanGS" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}



- (IBAction)clickLogOut:(id)sender {
    [Manager requestPOSTWithURLStr:KURLNSString(@"system/user/logout") paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"-----%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]]isEqualToString:@"200"]) {
            LoginViewController *login = [[LoginViewController alloc]init];
            login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:login animated:YES completion:nil];
            [Manager writewenjianming:@"token.text" content:[diction objectForKey:@"message"]];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[diction objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } enError:^(NSError *error) {
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
