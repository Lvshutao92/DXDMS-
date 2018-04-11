//
//  CZLB_ViewController.m
//  DXDMS
//
//  Created by 吕书涛 on 2018/4/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "CZLB_ViewController.h"
#import "CZLB_add_edit_ViewController.h"
@interface CZLB_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSMutableArray *czTypeArray;
@property(nonatomic,strong)NSMutableArray *czStatusArray;
@property(nonatomic,strong)NSMutableArray *kehuarr;
@property(nonatomic,strong)NSMutableArray *statusArray;
@end

@implementation CZLB_ViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)clickadd{
    CZLB_add_edit_ViewController *add = [[CZLB_add_edit_ViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:add];
    add.navigationItem.title = @"新增";
    add.arr1 = self.kehuarr;
    add.arr2 = self.statusArray;
    add.arr3 = self.czTypeArray;
    [self presentViewController:navi animated:YES completion:nil];
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
    
    [self lodczType];
    [self lodczStatus];
    [self lodkehuname];
    [self lodStatus];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"DMS_TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = v;
    
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(khlb:) name:@"czlb" object:nil];
}
- (void)khlb:(NSNotification *)text{
    [self setUpReflash];
}

- (void)lodStatus{
    __weak typeof (self) weakSelf = self;
    [Manager requestPOSTWithURLStr:KURLNSString(@"partner/partnerbank/paymentTypeEnums") paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"---66666----%@",diction);
        NSMutableArray *arr = (NSMutableArray *)diction;
        for (NSDictionary *dicc in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
            [weakSelf.statusArray addObject:model];
        }
    } enError:^(NSError *error) {
    }];
}
- (void)lodczStatus{
    __weak typeof (self) weakSelf = self;
    [Manager requestPOSTWithURLStr:KURLNSString(@"partner/partnerrecharge/getPartnerRechargeStatus") paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"status-------%@",diction);
        NSMutableArray *arr = (NSMutableArray *)diction;
        for (NSDictionary *dicc in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
            [weakSelf.czStatusArray addObject:model];
        }
    } enError:^(NSError *error) {
    }];
}
- (void)lodczType{
    __weak typeof (self) weakSelf = self;
    [Manager requestPOSTWithURLStr:KURLNSString(@"partner/partnerrecharge/getPartnerRechargeTypes") paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"type-------%@",diction);
        NSMutableArray *arr = (NSMutableArray *)diction;
        for (NSDictionary *dicc in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
            [weakSelf.czTypeArray addObject:model];
        }
    } enError:^(NSError *error) {
    }];
}
- (void)lodkehuname{
    __weak typeof (self) weakSelf = self;
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:1];
    NSDictionary *dic = @{@"likePartnerName":@"",
                          @"province":@"",
                          @"city":@"",
                          @"likeShopName":@"",
                          @"likeShopAddr":@"",
                          @"likeEmail":@"",
                          @"likeMobile":@"",
                          @"likePhone":@"",
                          @"likeQq":@"",
                          @"searchStatus":arr1,
                          };
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=1&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"partner/partnerinfo/list")];
    [Manager requestPOSTWithURLStr:str paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"kehu-------%@",diction);
        NSMutableArray *arr = (NSMutableArray *)diction;
        for (NSDictionary *dicc in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
            [weakSelf.kehuarr addObject:model];
        }
    } enError:^(NSError *error) {
    }];
}








- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 640;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    DMS_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[DMS_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LRViewBorderRadius(cell.btn2, 7, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn1, 7, 1, [UIColor blackColor]);
   
    
    ModelOne *model = [self.dataArray objectAtIndex:indexPath.row];
    
    for (ModelOne *kehuModel in self.kehuarr) {
        if ([kehuModel.id isEqualToString:model.partnerId]) {
            cell.lab1.text = [NSString stringWithFormat:@"付款人：%@",kehuModel.partnerName];
        }
    }
    
    
    
    cell.lab2.text = [NSString stringWithFormat:@"付款账户：%@",model.paymentAccount];
    cell.lab3.text = [NSString stringWithFormat:@"付款账号：%@",model.paymentNo];
    cell.lab4.text = [NSString stringWithFormat:@"付款附言：%@",model.paymentNote];
    cell.lab5.text = [NSString stringWithFormat:@"付款操作人：%@",model.paymentPerson];
    
    for (ModelOne *kehuModel in self.statusArray) {
        if ([kehuModel.key isEqualToString:model.paymentType]) {
            cell.lab6.text = [NSString stringWithFormat:@"付款方式：%@",kehuModel.value];
        }
    }
    
//    cell.lab7.text = [NSString stringWithFormat:@"付款凭证：%@",model.paymentImg];
    
    cell.lab8.text = [NSString stringWithFormat:@"收款账户：%@",model.receiveAccount];
    cell.lab9.text = [NSString stringWithFormat:@"实收金额：¥%@",model.receiveFee];
    cell.lab10.text = [NSString stringWithFormat:@"收款账号：%@",model.receiveNo];
    cell.lab11.text = [NSString stringWithFormat:@"收款附言：%@",model.receiveNote];
    cell.lab12.text = [NSString stringWithFormat:@"收款确认人：%@",model.receivePerson];
    
    
    for (ModelOne *kehuModel in self.statusArray) {
        if ([kehuModel.key isEqualToString:model.receiveType]) {
            cell.lab13.text = [NSString stringWithFormat:@"收款方式：%@",kehuModel.value];
        }
    }
    
    cell.lab14.text = [NSString stringWithFormat:@"充值流水号：%@",model.rechargeNo];
    
    for (ModelOne *kehuModel in self.czTypeArray) {
        if ([kehuModel.key isEqualToString:model.rechargeType]) {
            cell.lab15.text = [NSString stringWithFormat:@"充值类型：%@",kehuModel.value];
        }
    }
    for (ModelOne *kehuModel in self.czStatusArray) {
        if ([kehuModel.key isEqualToString:model.status]) {
            cell.lab16.text = [NSString stringWithFormat:@"充值状态：%@",kehuModel.value];
        }
    }
    cell.lab17.text = [NSString stringWithFormat:@"充值金额：¥%@",model.totalFee];
    cell.lab18.text = [NSString stringWithFormat:@"银行交易流水号：%@",model.transNo];
//    cell.lab19.text = [NSString stringWithFormat:@"收款凭证：%@",model.receiveImg];
    
    
    [cell.btn1 addTarget:self action:@selector(clickdelebtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(clickeditbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.lookbtn1 addTarget:self action:@selector(lookbtn1:) forControlEvents:UIControlEventTouchUpInside];
    [cell.lookbtn2 addTarget:self action:@selector(lookbtn2:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)lookbtn1:(UIButton *)sender{
    DMS_TableViewCell *cell = (DMS_TableViewCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    
    LookPictureViewController *edit = [[LookPictureViewController alloc]init];
    edit.imgStr = model.paymentImg;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:edit];
    [self presentViewController:navi animated:YES completion:nil];
}
- (void)lookbtn2:(UIButton *)sender{
    DMS_TableViewCell *cell = (DMS_TableViewCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    LookPictureViewController *edit = [[LookPictureViewController alloc]init];
    edit.imgStr = model.receiveImg;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:edit];
    [self presentViewController:navi animated:YES completion:nil];
}
- (void)clickeditbtn:(UIButton *)sender{
    DMS_TableViewCell *cell = (DMS_TableViewCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    
    CZLB_add_edit_ViewController *edit = [[CZLB_add_edit_ViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:edit];
    edit.navigationItem.title = @"编辑";
    edit.idstr = model.id;

    edit.arr1 = self.kehuarr;
    edit.arr2 = self.statusArray;
    edit.arr3 = self.czTypeArray;
    
    [self presentViewController:navi animated:YES completion:nil];
}





- (void)clickdelebtn:(UIButton *)sender{
    DMS_TableViewCell *cell = (DMS_TableViewCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnerrecharge/delete"),model.id];
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
    NSDictionary *dic = @{
                          };
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=1&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"partner/partnerrecharge/page")];
    
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
    NSDictionary *dic = @{
                          };
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=%ld&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"partner/partnerrecharge/page"),page];
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
- (NSMutableArray *)czTypeArray {
    if (_czTypeArray == nil) {
        self.czTypeArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _czTypeArray;
}
- (NSMutableArray *)czStatusArray {
    if (_czStatusArray == nil) {
        self.czStatusArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _czStatusArray;
}
- (NSMutableArray *)kehuarr {
    if (_kehuarr == nil) {
        self.kehuarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _kehuarr;
}
- (NSMutableArray *)statusArray{
    if (_statusArray == nil) {
        self.statusArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _statusArray;
}
@end
