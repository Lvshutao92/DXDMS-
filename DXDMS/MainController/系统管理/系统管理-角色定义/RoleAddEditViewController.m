//
//  RoleAddEditViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/16.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "RoleAddEditViewController.h"

@interface RoleAddEditViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *text1;
    UITextField *text2;
    
    NSString *str;
    
    UIView *bgview;
}
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation RoleAddEditViewController
- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
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
    [self setupview];
    if ([self.navigationItem.title isEqualToString:@"编辑"]){
        text1.text = self.str1;
        text2.text = self.str2;
        str = self.str1ID;
    }
    
    [self setuptableview];
}

- (void)clickbtn1{
    bgview.hidden = YES;
}
- (void)setuptableview{
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    bgview.hidden = YES;
    [self.view addSubview:bgview];
    
    
    UIButton *btn1  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor lightGrayColor];
    [btn1 addTarget:self action:@selector(clickbtn1) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:btn1];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-450, SCREEN_WIDTH, 400)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [bgview addSubview:self.tableview];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = v;
    
    [self.view bringSubviewToFront:self.tableview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ModelOne *model = [self.arr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.groupName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelOne *model = [self.arr objectAtIndex:indexPath.row];
    str = model.id;
    text1.text = model.groupName;
    bgview.hidden = YES;
}









-(void)save{
    if (text1.text.length != 0 && text2.text.length != 0) {
        
        __weak typeof (self) weakSelf = self;
        if ([self.navigationItem.title isEqualToString:@"新增"]) {
            NSDictionary *dic = @{@"roleName":text2.text,
                                  @"groupId":str,
                                  };
            [Manager requestPOSTWithURLStr:KURLNSString(@"system/systemrole/add") paramDic:dic token:nil finish:^(id responseObject) {
                NSDictionary *diction = [Manager returndictiondata:responseObject];
                //NSLog(@"******%@",diction);
                if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        NSNotification *notification =[NSNotification notificationWithName:@"role" object:nil userInfo:dict];
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
            NSDictionary *dic = @{@"roleName":text2.text,
                                  @"groupId":str,
                                  };
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"system/systemrole/update"),self.idstr];
            [Manager requestPOSTWithURLStr:urlstr paramDic:dic token:nil finish:^(id responseObject) {
                NSDictionary *diction = [Manager returndictiondata:responseObject];
                //NSLog(@"******%@",diction);
                if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        NSNotification *notification =[NSNotification notificationWithName:@"role" object:nil userInfo:dict];
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





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [text2 resignFirstResponder];
        bgview.hidden = NO;
        return NO;
    }
    return YES;
}

- (void)setupview{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+height, SCREEN_WIDTH-20, 30)];
    lab1.text = @"所属集团:";
    [self.view addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 50+height, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请选择所属集团";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110+height, SCREEN_WIDTH-20, 30)];
    lab2.text = @"角色名称:";
    [self.view addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 150+height, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"请输入角色名称";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text2];
    
}

@end
