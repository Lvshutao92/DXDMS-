//
//  XiTongManagerTableViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/2.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "XiTongManagerTableViewController.h"
#import "PermissionsViewController.h"
#import "RoleViewController.h"
#import "UserViewController.h"
@interface XiTongManagerTableViewController ()
@property(nonatomic,strong)NSMutableArray *arr;
@end

@implementation XiTongManagerTableViewController

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
    
    self.arr = [@[@"权限定义",@"角色定义",@"用户管理"]mutableCopy];
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
        if ([cell.labText.text isEqualToString:@"权限定义"]) {
            PermissionsViewController *jituan = [[PermissionsViewController alloc]init];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
            jituan.navigationItem.title = @"权限定义";
            [self presentViewController:navi animated:YES completion:nil];
        }
        if ([cell.labText.text isEqualToString:@"角色定义"]) {
            RoleViewController *jituan = [[RoleViewController alloc]init];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
            jituan.navigationItem.title = @"角色定义";
            [self presentViewController:navi animated:YES completion:nil];
        }
        if ([cell.labText.text isEqualToString:@"用户管理"]) {
            UserViewController *jituan = [[UserViewController alloc]init];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
            jituan.navigationItem.title = @"用户管理";
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
