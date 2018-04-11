//
//  KeHuManagerTableViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/2.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "KeHuManagerTableViewController.h"

#import "CZLB_ViewController.h"
#import "FPXX_ViewController.h"
#import "FKZH_ViewController.h"
#import "ZJLS_ViewController.h"
#import "ZJYE_ViewController.h"
#import "KHLB_ViewController.h"
#import "XiaoShouList_ViewController.h"
#import "XiaoJiaLogViewController.h"
@interface KeHuManagerTableViewController ()
@property(nonatomic,strong)NSMutableArray *arr;
@end

@implementation KeHuManagerTableViewController

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0,7, 30, 30);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = bar;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.arr = [@[@"客户列表",@"发票信息",@"付款账户",@"资金余额",@"资金流水",@"充值列表",@"销价列表",@"销价日志"]mutableCopy];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ImgCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = v;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"cell";
    ImgCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[ImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    cell.labText.text = [self.arr objectAtIndex:indexPath.row];
    cell.img.hidden = YES;
    LRViewBorderRadius(cell.labNum, 15, 0, [UIColor colorWithWhite:.8 alpha:.5]);
    cell.labNum.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    cell.labNum.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ImgCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell.labText.text isEqualToString:@"客户列表"]) {
        KHLB_ViewController *jituan = [[KHLB_ViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"客户列表";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([cell.labText.text isEqualToString:@"发票信息"]) {
        FPXX_ViewController *jituan = [[FPXX_ViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"发票信息";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([cell.labText.text isEqualToString:@"付款账户"]) {
        FKZH_ViewController *jituan = [[FKZH_ViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"付款账户";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([cell.labText.text isEqualToString:@"资金余额"]) {
        ZJYE_ViewController *jituan = [[ZJYE_ViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"资金余额";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([cell.labText.text isEqualToString:@"资金流水"]) {
        ZJLS_ViewController *jituan = [[ZJLS_ViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"资金流水";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([cell.labText.text isEqualToString:@"充值列表"]) {
        CZLB_ViewController *jituan = [[CZLB_ViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"充值列表";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([cell.labText.text isEqualToString:@"销价列表"]) {
        XiaoShouList_ViewController *jituan = [[XiaoShouList_ViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"销价列表";
        [self presentViewController:navi animated:YES completion:nil];
    }
    if ([cell.labText.text isEqualToString:@"销价日志"]) {
        XiaoJiaLogViewController *jituan = [[XiaoJiaLogViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
        jituan.navigationItem.title = @"销价日志";
        [self presentViewController:navi animated:YES completion:nil];
    }
}


- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}

@end
