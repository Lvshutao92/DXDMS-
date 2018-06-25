//
//  UserViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/16.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "UserViewController.h"
#import "UserAddEditViewController.h"
@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSInteger page;
    NSInteger totalnum;
    CGFloat cellHeight;
    
    UIView *bgSearchView;
    UIScrollView *scrollview;
    UIView *bgTableview1;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    
  
}
@property (nonatomic, weak) HWCalendar *calendar;
@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr;


@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSMutableArray *jiTuanArray;

@end

@implementation UserViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)clickadd{
    UserAddEditViewController *add = [[UserAddEditViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:add];
    add.navigationItem.title = @"新增";
    [self presentViewController:navi animated:YES completion:nil];
}
- (void)clicksearch{
    if (bgSearchView.hidden == NO) {
        bgSearchView.hidden = YES;
    }else{
        bgSearchView.hidden = NO;
    }
}
- (void)clickCancel{
    bgSearchView.hidden = YES;
}
- (void)clickSure{
    bgSearchView.hidden = YES;
    [self setUpReflash];
}
- (void)testregis{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [self testregis];
        bgTableview1.hidden = NO;
        [self.tableview1 reloadData];
        return NO;
    }
    return YES;
}
#pragma mark - 时间转换字符串
- (NSString *) dateString:(NSDate*)date format:(NSString *)format {
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];//格式化
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

- (void)setUpSearchView{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"] || [[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone Simulator"]) {
        height = 88;
    }else{
        height = 64;
    }
    bgSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0+height, SCREEN_WIDTH, SCREEN_HEIGHT-height)];
    bgSearchView.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    bgSearchView.hidden = YES;
    [self.view addSubview:bgSearchView];
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
    scrollview.backgroundColor = [UIColor whiteColor];
    scrollview.contentSize = CGSizeMake(0, 300);
    [bgSearchView addSubview:scrollview];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, 349, SCREEN_WIDTH/2, 45);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [cancel addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    [bgSearchView addSubview:cancel];
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(SCREEN_WIDTH/2, 349, SCREEN_WIDTH/2, 45);
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    sure.backgroundColor = [UIColor redColor];
    [sure addTarget:self action:@selector(clickSure) forControlEvents:UIControlEventTouchUpInside];
    [bgSearchView addSubview:sure];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
    lab1.text = @"集团:";
    [scrollview addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 20)];
    lab2.text = @"真是姓名:";
    [scrollview addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 190, SCREEN_WIDTH-20, 20)];
    lab3.text = @"用户名:";
    [scrollview addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 220, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text3];
    
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    
}
- (void)clickbtn1{
    bgTableview1.hidden = YES;
}
- (void)setUpTableview1{
    bgTableview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgTableview1.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    bgTableview1.hidden = YES;
    [self.view addSubview:bgTableview1];
    
    
    UIButton *btn1  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [btn1 setTitle:@"确定" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(clickbtn1) forControlEvents:UIControlEventTouchUpInside];
    [bgTableview1 addSubview:btn1];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-450, SCREEN_WIDTH, 400)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.backgroundColor = [UIColor whiteColor];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [bgTableview1 addSubview:self.tableview1];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview1.tableFooterView = v;
    [self.view bringSubviewToFront:self.tableview1];
}






- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 7, 30, 30);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = bar;
   
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickadd)];
    UIBarButtonItem *bar2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItems = @[bar1,bar2];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"OneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = v;
    
    [self lodSuoShuJiTuan];
    
    [self setUpSearchView];
    [self setUpTableview1];
    
    [self setUpReflash];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yh:) name:@"yha" object:nil];
}
- (void)yh:(NSNotification *)text{
    [self setUpReflash];
}
- (void)lodSuoShuJiTuan{
    __weak typeof (self) weakSelf = self;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    NSDictionary *dic = @{@"likeGroupCode":@"",
                          @"likeGroupName":@"",
                          @"searchCreateTimeEnd":@"",
                          @"searchCreateTimeStart":@"",
                          
                          @"searchExpireTimeEnd":@"",
                          @"searchExpireTimeStart":@"",
                          @"searchUseStatus":arr,
                          };
    [Manager requestPOSTWithURLStr:KURLNSString(@"group/groupbase/list") paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"========%@",diction);
        NSMutableArray *arr = (NSMutableArray *)diction;
        for (NSDictionary *dicc in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
            [weakSelf.jiTuanArray addObject:model];
        }
    } enError:^(NSError *error) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 50;
    }
    return 370+cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.jiTuanArray.count;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]){
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ModelOne *model = [self.jiTuanArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.groupName;
        //判断是否选中（选中单元格尾部打勾）
        if ([self.arr containsObject:model.id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    
    static NSString *identifierCell = @"cell";
    OneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[OneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LRViewBorderRadius(cell.editbtn, 7, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.delebtn, 7, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.quanxianBtn, 7, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.passwordBtn, 7, 1, [UIColor blackColor]);
    cell.quanxianBtn.hidden = NO;
    cell.passwordBtn.hidden = NO;
    [cell.quanxianBtn setTitle:@"解锁" forState:UIControlStateNormal];
    
    cell.lab7.hidden = NO;
    cell.lab8.hidden = NO;
    ModelOne *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"用户名 ：%@",model.userName];
    cell.lab2.text = [NSString stringWithFormat:@"真实姓名：%@",model.realName];
    if ([Manager judgeWhetherIsEmptyAnyObject:model.createTime] == YES) {
        cell.lab7.text = [NSString stringWithFormat:@"创建日期：%@",model.createTime];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"创建日期：%@",@""];
    }
    cell.lab3.text = [NSString stringWithFormat:@"手机：%@",model.mobilePhone];
    
    cell.lab4.text = [NSString stringWithFormat:@"所属集团：%@",model.groupBaseModel.groupName];
    
    if ([model.userStatus isEqualToString:@"Y"]) {
        cell.lab8.text = @"状态：正常";
    }else{
        cell.lab8.text = @"状态：停用";
    }
 
    NSString *str1 = @"";
    for (NSDictionary *dic1 in model.groupCompanys) {
        ModelTwo *model1 = [ModelTwo mj_objectWithKeyValues:dic1];
        str1 = [NSString stringWithFormat:@"%@、%@",str1,model1.companyName];
    }
    cell.lab5.text = [NSString stringWithFormat:@"所属公司：%@",[str1 substringFromIndex:1]];

    NSString *str2 = @"";
    for (NSDictionary *dic2 in model.systemRoleList) {
        ModelTwo *model2 = [ModelTwo mj_objectWithKeyValues:dic2];
        str2 = [NSString stringWithFormat:@"%@、%@",str2,model2.roleName];
    }
    cell.lab6.text = [NSString stringWithFormat:@"角色名称：%@", [str2 substringFromIndex:1]];
    
    cell.lab6right.constant = 10;
    
    cell.lab5.numberOfLines = 0;
    cell.lab5.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size1 = [cell.lab5 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab5height.constant = size1.height;
    
    cell.lab6.numberOfLines = 0;
    cell.lab6.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size2 = [cell.lab6 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab6height.constant = size2.height;

    cellHeight =  size1.height + size2.height-40;
    
    
    [cell.delebtn addTarget:self action:@selector(clickdelebtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editbtn addTarget:self action:@selector(clickeditbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.quanxianBtn addTarget:self action:@selector(clickQuanxianbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.passwordBtn addTarget:self action:@selector(clickpasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        ModelOne *model = [self.jiTuanArray objectAtIndex:indexPath.row];
        if ([self.arr containsObject:model.id]) {
            [self.arr removeObject:model.id];
        }else{
            [self.arr addObject:model.id];
        }
        if ([self.arr2 containsObject:model.groupName]) {
            [self.arr2 removeObject:model.groupName];
        }else{
            [self.arr2 addObject:model.groupName];
        }
        text1.text = [self.arr2 componentsJoinedByString:@" "];
        [self.tableview1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



- (void)clickpasswordBtn:(UIButton *)sender{
    __weak typeof (self) weakSelf = self;
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"system/systemuser/restpassword"),model.id];
    [Manager requestPOSTWithURLStr:urlstr paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重置密码成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[diction objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } enError:^(NSError *error) {
        NSLog(@"-------%@",error);
    }];
    
}




- (void)clickQuanxianbtn:(UIButton *)sender{
    __weak typeof (self) weakSelf = self;
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"system/systemuser/unlock"),model.id];
    [Manager requestPOSTWithURLStr:urlstr paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"解锁成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[diction objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } enError:^(NSError *error) {
        NSLog(@"-------%@",error);
    }];
    
}

- (void)clickeditbtn:(UIButton *)sender{
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UserAddEditViewController *edit = [[UserAddEditViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:edit];
    edit.navigationItem.title = @"编辑";
    edit.idstr = model.id;
    
    edit.str1   = model.groupBaseModel.groupName;
    edit.str1ID = model.groupBaseModel.id;
    
    for (NSDictionary *dic1 in model.groupCompanys) {
        ModelOne *model1 = [ModelOne mj_objectWithKeyValues:dic1];
        [edit.companyTitleArr addObject:model1.companyName];
        [edit.companyIDArr addObject:model1.id];
    }
    for (NSDictionary *dic2 in model.systemRoleList) {
        ModelOne *model2 = [ModelOne mj_objectWithKeyValues:dic2];
        [edit.roleTitleArr addObject:model2.roleName];
        [edit.roleIDArr addObject:model2.id];
    }
    
    edit.str4 = model.userName;
    edit.str5 = model.password;
    edit.str6 = model.realName;
    edit.str7 = model.mobilePhone;
    
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)clickdelebtn:(UIButton *)sender{
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"system/systemuser/delete"),model.id];
    __weak typeof (self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认删除？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [Manager requestPOSTWithURLStr:urlStr paramDic:nil token:nil finish:^(id responseObject) {
            NSDictionary *diction = [Manager returndictiondata:responseObject];
            if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                [weakSelf.tableview deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:[diction objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } enError:^(NSError *error) {
            NSLog(@"=====%@",error);
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:sure];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}




//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}
- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{@"likeMobilePhone":@"",
                          @"likeRealName":text2.text,
                          @"likeUserName":text3.text,
                          @"userStatus":@"",
                          @"searchGroupId":self.arr,
                          };
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=1&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"system/systemuser/page")];
    
    [Manager requestPOSTWithURLStr:str paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray removeAllObjects];
        totalnum = [[diction objectForKey:@"totalRows"] integerValue];
        if ([Manager judgeWhetherIsEmptyAnyObject:[diction objectForKey:@"rows"]] == YES) {
            [ModelOne mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"groupCompanys" : [ModelTwo class],
                         };
            }];
            [ModelOne mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"systemRoleList" : [ModelTwo class],
                         };
            }];
            NSMutableArray *arr = [diction objectForKey:@"rows"];
            for (NSDictionary *dicc in arr) {
                ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
                
                
                ModelTwo *model1 = [ModelTwo mj_objectWithKeyValues:model.groupBase];
                model.groupBaseModel = model1;
                
                
                [weakSelf.dataArray addObject:model];
            }
        }
        //NSLog(@"******%@",diction);
        page = 2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } enError:^(NSError *error) {
        NSLog(@"------%@",error);
    }];
}




- (void)loddeSLList{
    [self.tableview.mj_header endRefreshing];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = @{@"likeMobilePhone":@"",
                          @"likeRealName":text2.text,
                          @"likeUserName":text3.text,
                          @"userStatus":@"",
                          @"searchGroupId":self.arr,
                          };
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=%ld&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"system/systemuser/page"),page];
    
    [Manager requestPOSTWithURLStr:str paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        if ([Manager judgeWhetherIsEmptyAnyObject:[diction objectForKey:@"rows"]] == YES) {
            [ModelOne mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"groupCompanys" : [ModelTwo class],
                         };
            }];
            [ModelOne mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"systemRoleList" : [ModelTwo class],
                         };
            }];
            NSMutableArray *arr = [diction objectForKey:@"rows"];
            for (NSDictionary *dicc in arr) {
                ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
                
                
                ModelTwo *model1 = [ModelTwo mj_objectWithKeyValues:model.groupBase];
                model.groupBaseModel = model1;
                
                
                [weakSelf.dataArray addObject:model];
            }
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } enError:^(NSError *error) {
        NSLog(@"------%@",error);
    }];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)arr2 {
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)jiTuanArray {
    if (_jiTuanArray == nil) {
        self.jiTuanArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _jiTuanArray;
}
@end
