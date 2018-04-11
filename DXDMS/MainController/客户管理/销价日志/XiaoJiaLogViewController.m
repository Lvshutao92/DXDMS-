//
//  XiaoJiaLogViewController.m
//  DXDMS
//
//  Created by 吕书涛 on 2018/4/11.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "XiaoJiaLogViewController.h"

@interface XiaoJiaLogViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSMutableArray *statusArray;
@property(nonatomic,strong)NSMutableArray *jiTuanArray;

@end

@implementation XiaoJiaLogViewController


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)clickadd{
//    XiaoJia_addedit_ViewController *add = [[XiaoJia_addedit_ViewController alloc]init];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:add];
//    add.navigationItem.title = @"新增";
//    //    add.arr = self.jiTuanArray;
//    [self presentViewController:navi animated:YES completion:nil];
}
- (void)clicksearch{
    
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
    
    //    [self lodStatus];
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(khlb:) name:@"xjrz" object:nil];
}
- (void)khlb:(NSNotification *)text{
    [self setUpReflash];
}
//- (void)lodStatus{
//    __weak typeof (self) weakSelf = self;
//    [Manager requestPOSTWithURLStr:KURLNSString(@"partner/partnerinfo/statusEnums") paramDic:nil token:nil finish:^(id responseObject) {
//        NSDictionary *diction = [Manager returndictiondata:responseObject];
//        //NSLog(@"-------%@",diction);
//        NSMutableArray *arr = (NSMutableArray *)diction;
//        for (NSDictionary *dicc in arr) {
//            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
//            [weakSelf.statusArray addObject:model];
//        }
//    } enError:^(NSError *error) {
//    }];
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 410;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    OneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[OneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LRViewBorderRadius(cell.editbtn, 7, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.delebtn, 7, 1, [UIColor blackColor]);
    cell.lab7.hidden = NO;
    cell.lab8.hidden = NO;
    cell.lab9.hidden = NO;
    cell.switchs.hidden = YES;
    cell.editbtn.hidden = YES;
    cell.delebtn.hidden = YES;
    cell.line.hidden = YES;
    ModelOne *model = [self.dataArray objectAtIndex:indexPath.row];
    //    cell.lab1.text = [NSString stringWithFormat:@"客户名称：%@",model.partnerName];
    //    cell.lab2.text = [NSString stringWithFormat:@"店铺名称：%@",model.shopName];
    //    cell.lab3.text = [NSString stringWithFormat:@"店铺地址：%@",model.shopAddr];
    //    cell.lab4.text = [NSString stringWithFormat:@"详细地址：%@ %@ %@ %@",model.province,model.city,model.district,model.addr];
    //    cell.lab5.text = [NSString stringWithFormat:@"邮箱：%@",model.email];
    //    cell.lab6.text = [NSString stringWithFormat:@"手机：%@",model.phone];
    //    cell.lab7.text = [NSString stringWithFormat:@"电话：%@",model.mobile];
    //    cell.lab8.text = [NSString stringWithFormat:@"QQ：%@",model.qq];
    //
    //    for (ModelOne *statuModel in self.statusArray) {
    //        if ([statuModel.key isEqualToString:model.status]) {
    //            cell.lab9.text = [NSString stringWithFormat:@"状态：%@",statuModel.value];
    //            cell.lab9.textColor = [Manager hexStringToColor:statuModel.color];
    //        }
    //    }
    
    
    
//    [cell.delebtn addTarget:self action:@selector(clickdelebtn:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.editbtn addTarget:self action:@selector(clickeditbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)clickeditbtn:(UIButton *)sender{
//    OneCell *cell = (OneCell *)[[sender superview] superview];
//    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
//    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
//
//    XiaoJia_addedit_ViewController *edit = [[XiaoJia_addedit_ViewController alloc]init];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:edit];
//    edit.navigationItem.title = @"编辑";
//    edit.idstr = model.id;
//
//    [self presentViewController:navi animated:YES completion:nil];
}





- (void)clickdelebtn:(UIButton *)sender{
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnersku/delete"),model.id];
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
            // NSLog(@"=====%@",error);
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
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *arr3 = [NSMutableArray arrayWithCapacity:1];
    NSDictionary *dic = @{@"companyId":@"",
                          @"searchSalePriceBegin":@"",
                          @"searchSalePriceEnd":@"",
                          
                          @"searchId":arr1,
                          @"searchPartnerInfoId":arr2,
                          @"searchSkuId":arr3,
                          };
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=1&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"partner/partnersku/page")];
    
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
        NSLog(@"---------%@",diction);
        page = 2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } enError:^(NSError *error) {
        //NSLog(@"------%@",error);
    }];
}




- (void)loddeSLList{
    [self.tableview.mj_header endRefreshing];
    __weak typeof(self) weakSelf = self;
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *arr3 = [NSMutableArray arrayWithCapacity:1];
    NSDictionary *dic = @{@"companyId":@"",
                          @"searchSalePriceBegin":@"",
                          @"searchSalePriceEnd":@"",
                          
                          @"searchId":arr1,
                          @"searchPartnerInfoId":arr2,
                          @"searchSkuId":arr3,
                          };
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=%ld&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"partner/partnersku/page"),page];
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
        //NSLog(@"------%@",error);
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
- (NSMutableArray *)jiTuanArray {
    if (_jiTuanArray == nil) {
        self.jiTuanArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _jiTuanArray;
}
@end
