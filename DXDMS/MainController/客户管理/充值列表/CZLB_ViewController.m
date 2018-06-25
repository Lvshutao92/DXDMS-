//
//  CZLB_ViewController.m
//  DXDMS
//
//  Created by 吕书涛 on 2018/4/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "CZLB_ViewController.h"
#import "CZLB_add_edit_ViewController.h"
@interface CZLB_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSInteger page;
    NSInteger totalnum;
    
    UIView *bgSearchView;
    UIScrollView *scrollview;
    UIView *bgTableview1;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
}
@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSMutableArray *arr2;

@property(nonatomic,strong)NSMutableArray *aarr;
@property(nonatomic,strong)NSMutableArray *aarr2;

@property(nonatomic,strong)NSMutableArray *baarr;
@property(nonatomic,strong)NSMutableArray *baarr2;
@property(nonatomic,strong)NSMutableArray *dataArray1;




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
- (NSMutableArray *)baarr2 {
    if (_baarr2 == nil) {
        self.baarr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _baarr2;
}
- (NSMutableArray *)baarr {
    if (_baarr == nil) {
        self.baarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _baarr;
}
- (NSMutableArray *)dataArray1{
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
- (NSMutableArray *)aarr2 {
    if (_aarr2 == nil) {
        self.aarr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _aarr2;
}
- (NSMutableArray *)aarr {
    if (_aarr == nil) {
        self.aarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _aarr;
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
    [text3 resignFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [self testregis];
        self.dataArray1 = self.kehuarr;
        bgTableview1.hidden = NO;
        [self.tableview1 reloadData];
        return NO;
    }
    if ([textField isEqual:text2]) {
        [self testregis];
        self.dataArray1 = self.czTypeArray;
        bgTableview1.hidden = NO;
        [self.tableview1 reloadData];
        return NO;
    }
    if ([textField isEqual:text3]) {
        [self testregis];
        self.dataArray1 = self.czStatusArray;
        bgTableview1.hidden = NO;
        [self.tableview1 reloadData];
        return NO;
    }
    return YES;
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
    scrollview.contentSize = CGSizeMake(0, 350);
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
    lab1.text = @"客户名称:";
    [scrollview addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH-20, 20)];
    lab2.text = @"充值类型:";
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
    
    
    
    [self setUpSearchView];
    [self setUpTableview1];
    
    
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
    if ([tableView isEqual:self.tableview1]) {
        return 50;
    }
    return 640;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        if (self.dataArray1 == self.kehuarr) {
            return self.kehuarr.count;
        }
        if (self.dataArray1 == self.czTypeArray) {
            return self.czTypeArray.count;
        }
        if (self.dataArray1 == self.czStatusArray) {
            return self.czStatusArray.count;
        }
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        if (self.dataArray1 == self.kehuarr) {
            static NSString *identifierCell = @"cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ModelOne *model = [self.kehuarr objectAtIndex:indexPath.row];
            cell.textLabel.text = model.partnerName;
            //判断是否选中（选中单元格尾部打勾）
            if ([self.arr containsObject:model.id]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }
        if (self.dataArray1 == self.czTypeArray) {
            static NSString *identifierCell = @"cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ModelOne *model = [self.czTypeArray objectAtIndex:indexPath.row];
            cell.textLabel.text = model.value;
            //判断是否选中（选中单元格尾部打勾）
            if ([self.aarr containsObject:model.key]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }
        if (self.dataArray1 == self.czStatusArray) {
            static NSString *identifierCell = @"cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ModelOne *model = [self.czStatusArray objectAtIndex:indexPath.row];
            cell.textLabel.text = model.value;
            //判断是否选中（选中单元格尾部打勾）
            if ([self.baarr containsObject:model.key]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }
    }
    
    
    
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        if (self.dataArray1 == self.kehuarr) {
            ModelOne *model = [self.kehuarr objectAtIndex:indexPath.row];
            if ([self.arr containsObject:model.id]) {
                [self.arr removeObject:model.id];
            }else{
                [self.arr addObject:model.id];
            }
            if ([self.arr2 containsObject:model.partnerName]) {
                [self.arr2 removeObject:model.partnerName];
            }else{
                [self.arr2 addObject:model.partnerName];
            }
            text1.text = [self.arr2 componentsJoinedByString:@" "];
            [self.tableview1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        if (self.dataArray1 == self.czTypeArray) {
            ModelOne *model = [self.czTypeArray objectAtIndex:indexPath.row];
            if ([self.aarr containsObject:model.key]) {
                [self.aarr removeObject:model.key];
            }else{
                [self.aarr addObject:model.key];
            }
            if ([self.aarr2 containsObject:model.value]) {
                [self.aarr2 removeObject:model.value];
            }else{
                [self.aarr2 addObject:model.value];
            }
            text2.text = [self.aarr2 componentsJoinedByString:@" "];
            [self.tableview1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        if (self.dataArray1 == self.czStatusArray) {
            ModelOne *model = [self.czStatusArray objectAtIndex:indexPath.row];
            if ([self.baarr containsObject:model.key]) {
                [self.baarr removeObject:model.key];
            }else{
                [self.baarr addObject:model.key];
            }
            if ([self.baarr2 containsObject:model.value]) {
                [self.baarr2 removeObject:model.value];
            }else{
                [self.baarr2 addObject:model.value];
            }
            text3.text = [self.baarr2 componentsJoinedByString:@" "];
            [self.tableview1 reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
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
    NSDictionary *dic = @{@"searchPartnerId":self.arr,
                          @"searchRechargeType":self.aarr,
                          @"searchStatus":self.baarr,
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
    NSDictionary *dic = @{@"searchPartnerId":self.arr,
                          @"searchRechargeType":self.aarr,
                          @"searchStatus":self.baarr,
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
