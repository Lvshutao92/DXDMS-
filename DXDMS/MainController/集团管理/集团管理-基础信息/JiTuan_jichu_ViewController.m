//
//  JiTuan_jichu_ViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/15.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "JiTuan_jichu_ViewController.h"
#import "CompanyAddEditViewController.h"
#import "SelecQuanXianViewController.h"
@interface JiTuan_jichu_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSInteger page;
    NSInteger totalnum;
    
    UIView *bgSearchView;
    UIScrollView *scrollview;
    UIView *bgTableview1;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    
    NSString *string5;
    NSString *string6;
    
    NSString *string7;
    NSString *string8;
}
@property (nonatomic, weak) HWCalendar *calendar;
@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr;



@property(nonatomic,strong)NSMutableArray *statusArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation JiTuan_jichu_ViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)clickadd{
    CompanyAddEditViewController *add = [[CompanyAddEditViewController alloc]init];
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
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text3]) {
        [self testregis];
        bgTableview1.hidden = NO;
        [self.tableview1 reloadData];
        return NO;
    }
    if ([textField isEqual:text4]) {
        [self testregis];
        XYTimeViewController *VC = [[XYTimeViewController alloc]initWithNibName:@"XYTimeViewController" bundle:nil];
        VC.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        __weak JiTuan_jichu_ViewController *weekSelf = self;
        VC.selectTime = ^(NSDate *startDate, NSDate *endDate) {
            text4.text = [NSString stringWithFormat:@"%@ ~ %@",[weekSelf dateString:startDate format:@"yyyy-MM-dd"],[weekSelf dateString:endDate format:@"yyyy-MM-dd"]];
            string5 = [weekSelf dateString:startDate format:@"yyyy-MM-dd"];
            string6 = [weekSelf dateString:endDate format:@"yyyy-MM-dd"];
        };
        [self addChildViewController:VC];
        [self.view addSubview:VC.view];
        [VC shuaxin:NO];
        return NO;
    }
    if ([textField isEqual:text5]) {
        [self testregis];
        XYTimeViewController *VC = [[XYTimeViewController alloc]initWithNibName:@"XYTimeViewController" bundle:nil];
        VC.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        __weak JiTuan_jichu_ViewController *weekSelf = self;
        VC.selectTime = ^(NSDate *startDate, NSDate *endDate) {
            text5.text = [NSString stringWithFormat:@"%@ ~ %@",[weekSelf dateString:startDate format:@"yyyy-MM-dd"],[weekSelf dateString:endDate format:@"yyyy-MM-dd"]];
            string7 = [weekSelf dateString:startDate format:@"yyyy-MM-dd"];
            string8 = [weekSelf dateString:endDate format:@"yyyy-MM-dd"];
        };
        [self addChildViewController:VC];
        [self.view addSubview:VC.view];
        [VC shuaxin:NO];
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
    scrollview.contentSize = CGSizeMake(0, 500);
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
    lab1.text = @"集团编号:";
    [scrollview addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 20)];
    lab2.text = @"集团名称:";
    [scrollview addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 190, SCREEN_WIDTH-20, 20)];
    lab3.text = @"状态:";
    [scrollview addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 220, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 280, SCREEN_WIDTH-20, 20)];
    lab4.text = @"创建开始结束日期:";
    [scrollview addSubview:lab4];
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 370, SCREEN_WIDTH-20, 20)];
    lab5.text = @"到期开始结束日期:";
    [scrollview addSubview:lab5];
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(10, 400, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text5];
    
    
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
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
    string5 = @"";
    string6 = @"";
    string8 = @"";
    string7 = @"";
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 7, 30, 30);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = bar;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationItem.title = @"集团信息";
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
    [self lodStatus];
    
    [self setUpSearchView];
    [self setUpTableview1];
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jituan:) name:@"jituan" object:nil];
}
- (void)jituan:(NSNotification *)text{
    [self setUpReflash];
}

- (void)lodStatus{
    __weak typeof (self) weakSelf = self;
    [Manager requestPOSTWithURLStr:KURLNSString(@"group/groupbase/query/useStatus") paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"----%@",diction);
        NSMutableArray *arr = (NSMutableArray *)diction;
        for (NSDictionary *dicc in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
            [weakSelf.statusArray addObject:model];
        }
    } enError:^(NSError *error) {
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 50;
    }
    return 285;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.statusArray.count;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ModelOne *model = [self.statusArray objectAtIndex:indexPath.row];
        cell.textLabel.text = model.value;
        //判断是否选中（选中单元格尾部打勾）
        if ([self.arr containsObject:model.key]) {
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
    cell.quanxianBtn.hidden = NO;
    cell.switchs.hidden = NO;
    LRViewBorderRadius(cell.quanxianBtn, 7, 1, [UIColor blackColor]);
    
    ModelOne *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"集团名称：%@",model.groupName];
    cell.lab2.text = [NSString stringWithFormat:@"集团编号：%@",model.groupCode];
    
    cell.lab3.text = [NSString stringWithFormat:@"创建日期：%@",[model.createTime substringToIndex:10]];
    cell.lab4.text = [NSString stringWithFormat:@"到期日期：%@",[model.expireTime substringToIndex:10]];
    
    for (ModelOne *modelstatus in self.statusArray) {
        if ([modelstatus.key isEqualToString:model.useStatus]) {
            cell.lab6.text = [NSString stringWithFormat:@"状态：%@",modelstatus.value];
        }
    }
    cell.lab5.text = [NSString stringWithFormat:@"允许创建最大公司数量：%@",model.companyCount];
    
    
    if ([model.useStatus isEqualToString:@"normal"]) {
        cell.switchs.on = YES;
    }else{
        cell.switchs.on = NO;
    }
    
    if ([model.useStatus isEqualToString:@"newly"]) {
        cell.delebtnwidth.constant = 60;
        cell.deleEditJuLi.constant = 20;
    }else{
        cell.delebtnwidth.constant = 0;
        cell.deleEditJuLi.constant = 0;
    }
    
    
    [cell.switchs addTarget:self action:@selector(clickswitch:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delebtn addTarget:self action:@selector(clickdelebtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editbtn addTarget:self action:@selector(clickeditbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.quanxianBtn addTarget:self action:@selector(clickequanxian:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        ModelOne *model = [self.statusArray objectAtIndex:indexPath.row];
        
        if ([self.arr containsObject:model.key]) {
            [self.arr removeObject:model.key];
        }else{
            [self.arr addObject:model.key];
        }
        
        if ([self.arr2 containsObject:model.value]) {
            [self.arr2 removeObject:model.value];
        }else{
            [self.arr2 addObject:model.value];
        }
        
        text3.text = [self.arr2 componentsJoinedByString:@" "];
        [self.tableview1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (void)clickswitch:(UISwitch *)sender{
    
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    __weak typeof (self) weakSelf = self;
    NSString *string = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"group/groupbase/audit"),model.id];
    [Manager requestPOSTWithURLStr:string paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
         //NSLog(@"-------=====%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            [weakSelf setUpReflash];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[diction objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    } enError:^(NSError *error) {
        //NSLog(@"=====%@",error);
    }];
}

- (void)clickequanxian:(UIButton *)sender{
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    
    SelecQuanXianViewController *quanxian = [[SelecQuanXianViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:quanxian];
    quanxian.navigationItem.title = @"权限管理";
    quanxian.idstr = model.id;
    [Manager sharedManager].isOrNoRole = @"jituan";
    [[Manager sharedManager].qxArray removeAllObjects];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)clickeditbtn:(UIButton *)sender{
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    
    CompanyAddEditViewController *edit = [[CompanyAddEditViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:edit];
    edit.navigationItem.title = @"编辑";
    edit.idstr = model.id;
    [self presentViewController:navi animated:YES completion:nil];
}


- (void)clickdelebtn:(UIButton *)sender{
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"group/groupbase/delete"),model.id];
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
            //NSLog(@"=====%@",error);
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
    NSDictionary *dic = @{@"likeGroupCode":text1.text,
                          @"likeGroupName":text2.text,
                          @"searchCreateTimeEnd":string6,
                          @"searchCreateTimeStart":string5,
                          
                          @"searchExpireTimeEnd":string8,
                          @"searchExpireTimeStart":string7,
                          @"searchUseStatus":self.arr,
                          };
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=1&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"group/groupbase/page")];
    [Manager requestPOSTWithURLStr:str paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray removeAllObjects];
        totalnum = [[diction objectForKey:@"totalRows"] integerValue];
        if ([Manager judgeWhetherIsEmptyAnyObject:[diction objectForKey:@"rows"]] == YES) {
            NSMutableArray *arr = [diction objectForKey:@"rows"];
            for (NSDictionary *dicc in arr) {
                ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
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
    NSDictionary *dic = @{@"likeGroupCode":text1.text,
                          @"likeGroupName":text2.text,
                          @"searchCreateTimeEnd":string6,
                          @"searchCreateTimeStart":string5,
                          
                          @"searchExpireTimeEnd":string8,
                          @"searchExpireTimeStart":string7,
                          @"searchUseStatus":self.arr,
                          };
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=%ld&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"group/groupbase/page"),page];
    [Manager requestPOSTWithURLStr:str paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        if ([Manager judgeWhetherIsEmptyAnyObject:[diction objectForKey:@"rows"]] == YES) {
            NSMutableArray *arr = [diction objectForKey:@"rows"];
            for (NSDictionary *dicc in arr) {
                ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
        }
        //NSLog(@"******%@",diction);
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
- (NSMutableArray *)statusArray {
    if (_statusArray == nil) {
        self.statusArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _statusArray;
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
@end
