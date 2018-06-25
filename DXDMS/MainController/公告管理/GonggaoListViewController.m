//
//  GonggaoListViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/18.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "GonggaoListViewController.h"
#import "WebViewController.h"
#import "AnnouncementViewController.h"
@interface GonggaoListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSInteger totalnum;
    CGFloat hei;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation GonggaoListViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)clickadd{
    AnnouncementViewController *jituan = [[AnnouncementViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
    jituan.navigationItem.title = @"发布公告";
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
    
    self.navigationItem.rightBarButtonItem = bar1;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"OneCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = v;
    
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(khlb:) name:@"fabu" object:nil];
}
- (void)khlb:(NSNotification *)text{
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100+hei;
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
    LRViewBorderRadius(cell.delebtn, 7, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.editbtn, 7, 1, [UIColor blackColor]);
    cell.lab3.hidden = YES;
    cell.lab4.hidden = YES;
    cell.lab5.hidden = YES;
    cell.lab6.hidden = YES;
    cell.lab7.hidden = YES;
    cell.lab8.hidden = YES;
    cell.lab9.hidden = YES;
    cell.switchs.hidden = YES;
    cell.lab2.font = [UIFont systemFontOfSize:13];
    cell.lab2.textColor = [UIColor grayColor];
    ModelOne *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = model.title;
    cell.lab1.numberOfLines = 0;
    [Manager changeLineSpaceForLabel:cell.lab1 WithSpace:7];
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab1Height.constant = size.height;
    hei = size.height;
    cell.lab2.text = model.createTime;
    [cell.editbtn addTarget:self action:@selector(clickeditbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delebtn addTarget:self action:@selector(clickdeletebtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)clickeditbtn:(UIButton *)sender{
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    AnnouncementViewController *jituan = [[AnnouncementViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:jituan];
    jituan.navigationItem.title = @"发布公告";
    jituan.inHtmlString = model.content;
    jituan.titles = model.title;
    jituan.idstr  = model.id;
    [self presentViewController:navi animated:YES completion:nil];
}
- (void)clickdeletebtn:(UIButton *)sender{
    OneCell *cell = (OneCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    ModelOne *model = [self.dataArray objectAtIndex:indexpath.row];
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"announce/announceinfo/delete"),model.id];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelOne *model = [self.dataArray objectAtIndex:indexPath.row];
    WebViewController *web = [[WebViewController alloc]init];
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:web];
//    web.navigationItem.title = @"详情";
    web.webStr = [self changeString:model.content];
    web.titles = model.title;
    [self presentViewController:web animated:YES completion:nil];
}
#pragma mark - Method
-(NSString *)changeString:(NSString *)str
{
    NSMutableArray * marr = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"\""]];
    for (int i = 0; i < marr.count; i++)
    {
        NSString * subStr = marr[i];
        if ([subStr hasPrefix:@"/var"] || [subStr hasPrefix:@" id="])
        {
            [marr removeObject:subStr];
            i --;
        }
    }
    NSString * newStr = [marr componentsJoinedByString:@"\""];
    return newStr;
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
    NSDictionary *dic = @{};
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=1&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"announce/announceinfo/page")];
    [Manager requestPOSTWithURLStr:str paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
//        NSLog(@"---------%@",diction);
        [weakSelf.dataArray removeAllObjects];
        totalnum = [[diction objectForKey:@"totalRows"] integerValue];
        if ([Manager judgeWhetherIsEmptyAnyObject:[diction objectForKey:@"rows"]] == YES) {
            NSMutableArray *arr = [diction objectForKey:@"rows"];
            for (NSDictionary *dicc in arr) {
                ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
                [weakSelf.dataArray addObject:model];
            }
        }
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
    NSDictionary *dic = @{};
    NSString *str = [NSString stringWithFormat:@"%@?currentPage=%ld&pageSize=10&sortName=id&sortType=desc",KURLNSString(@"announce/announceinfo/page"),page];
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


@end
