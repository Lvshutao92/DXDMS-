//
//  PermissionsAddEditViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/16.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "PermissionsAddEditViewController.h"


@interface PermissionsAddEditViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    NSString *str1s;
    
    UIView *bgview;
    
    NSString *stringOne;
    NSString *stringTwo;
    NSString *stringOneID;
    NSString *stringTwoID;
}
@property(nonatomic,strong)UITableView *leftTableview;
@property(nonatomic,strong)UITableView *rightTableview;
@property(nonatomic,strong)UIView *lineView;



@end

@implementation PermissionsAddEditViewController
- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 7, 30, 30);
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = bar;
    
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = bar1;
    
    if ([self.navigationItem.title isEqualToString:@"编辑"]){
        [self setupview1];
        [self lodEditGetList];
    }else{
        [self setupview];
    }
    [self setuptableview];
    
}

- (void)lodEditGetList{
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"system/systemresource/get"),self.idstr];
    [Manager requestPOSTWithURLStr:str paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        text2.text = [diction objectForKey:@"resourceCode"];
        text3.text = [diction objectForKey:@"resourceName"];
        str1s = [diction objectForKey:@"parentId"];
    } enError:^(NSError *error) {
    }];
}






- (void)clickbtn1{
    
    if ([Manager judgeWhetherIsEmptyAnyObject:stringTwoID] == YES) {
        str1s = stringTwoID;
    }else{
        str1s = stringOneID;
    }
    text1.text = [NSString stringWithFormat:@"%@ %@",stringOne,stringTwo];
    if ([Manager judgeWhetherIsEmptyAnyObject:stringTwoID] == NO && [Manager judgeWhetherIsEmptyAnyObject:stringOneID] == NO) {
        text1.text = @"";
    }
    bgview.hidden = YES;
}
- (void)setuptableview{
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    bgview.hidden = YES;
    [self.view addSubview:bgview];
    
    
    UIButton *btn1  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [btn1 setTitle:@"确定" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(clickbtn1) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:btn1];
    
    self.leftTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-450, SCREEN_WIDTH/2-1, 400)];
    self.leftTableview.delegate = self;
    self.leftTableview.dataSource = self;
    [self.leftTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [bgview addSubview:self.leftTableview];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 1)];
    self.leftTableview.tableFooterView = v;
    [self.view bringSubviewToFront:self.leftTableview];
    
    self.rightTableview = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+1, SCREEN_HEIGHT-450, SCREEN_WIDTH/2-1, 400)];
    self.rightTableview.delegate = self;
    self.rightTableview.dataSource = self;
    [self.rightTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [bgview addSubview:self.rightTableview];
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 1)];
    self.rightTableview.tableFooterView = v1;
    [self.view bringSubviewToFront:self.rightTableview];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.leftTableview]) {
        return self.arr.count;
    }
    return self.arr1.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.leftTableview]){
        static NSString *identifierCell = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ModelOne *model = [self.arr objectAtIndex:indexPath.row];
        cell.textLabel.text = model.label;
        return cell;
    }
    static NSString *identifierCell = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ModelTwo *model = [self.arr1 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.label;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.leftTableview]) {
        stringTwo   = @"";
        stringTwoID = @"";
        
        ModelOne *model = [self.arr objectAtIndex:indexPath.row];
        stringOne = model.label;
        stringOneID = model.value;
        [self.arr1 removeAllObjects];
        for (NSDictionary *dic in model.children) {
            ModelTwo *mo = [ModelTwo mj_objectWithKeyValues:dic];
            [self.arr1 addObject:mo];
        }
        [self.rightTableview reloadData];
    }
    if ([tableView isEqual:self.rightTableview]) {
        ModelTwo *model = [self.arr1 objectAtIndex:indexPath.row];
        stringTwo   = model.label;
        stringTwoID = model.value;
    }

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        bgview.hidden = NO;
        [self.arr1 removeAllObjects];
        [self.leftTableview reloadData];
        [self.rightTableview reloadData];
        return NO;
    }
    return YES;
}

































-(void)save{
    //NSLog(@"%@---%@---%@----%@",stringOne,stringTwo,stringOneID,stringTwoID);
    
    if (text2.text.length != 0 && text3.text.length != 0 && str1s.length != 0) {

        __weak typeof (self) weakSelf = self;
        if ([self.navigationItem.title isEqualToString:@"新增"]) {
                NSDictionary *dic = @{@"parentId":str1s,
                                      @"resourceCode":text2.text,
                                      @"resourceName":text3.text,
                                      };
                [Manager requestPOSTWithURLStr:KURLNSString(@"system/systemresource/add") paramDic:dic token:nil finish:^(id responseObject) {
                    NSDictionary *diction = [Manager returndictiondata:responseObject];
                    //NSLog(@"******%@",diction);
                    if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"温馨提示" preferredStyle:1];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            NSDictionary *dict = [[NSDictionary alloc]init];
                            NSNotification *notification =[NSNotification notificationWithName:@"quanxian" object:nil userInfo:dict];
                            [[NSNotificationCenter defaultCenter] postNotification:notification];
                            [self dismissViewControllerAnimated:YES completion:nil];
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
                    NSLog(@"******%@",error);
                }];
        }else{
            NSDictionary *dic = @{@"resourceCode":text2.text,
                                  @"resourceName":text3.text,
                                  @"parentId":str1s,
                                  };
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"system/systemresource/update"),self.idstr];
            [Manager requestPOSTWithURLStr:urlstr paramDic:dic token:nil finish:^(id responseObject) {
                NSDictionary *diction = [Manager returndictiondata:responseObject];
                //NSLog(@"******%@",diction);
                if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        NSNotification *notification =[NSNotification notificationWithName:@"quanxian" object:nil userInfo:dict];
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                        [self dismissViewControllerAnimated:YES completion:nil];
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
                NSLog(@"******%@",error);
            }];
        }


    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有字段不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}







- (void)setupview{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+height, SCREEN_WIDTH-20, 30)];
    lab1.text = @"上级资源:";
    [self.view addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 50+height, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入上级资源";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110+height, SCREEN_WIDTH-20, 30)];
    lab2.text = @"资源代码:";
    [self.view addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 150+height, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"请输入资源代码";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210+height, SCREEN_WIDTH-20, 30)];
    lab3.text = @"资源名称:";
    [self.view addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 250+height, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"请输入资源名称";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text3];
}
- (void)setupview1{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+height, SCREEN_WIDTH-20, 30)];
    lab2.text = @"资源代码:";
    [self.view addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 50+height, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"请输入资源代码";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110+height, SCREEN_WIDTH-20, 30)];
    lab3.text = @"资源名称:";
    [self.view addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 150+height, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"请输入资源名称";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text3];
}
@end
