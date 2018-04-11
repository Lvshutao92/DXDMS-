//
//  UserAddEditViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/16.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "UserAddEditViewController.h"

@interface UserAddEditViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    NSString *string1;
    
    
    UIView *bgview;
    UIButton *btn2;
    UIButton *btn3;
    XYQRegexPatternHelper *xyqHelper;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr3;

@property(nonatomic, strong)NSMutableArray *selextedArr1;
@property(nonatomic, strong)NSMutableArray *selextedArr2;

@property(nonatomic,strong)NSMutableArray *gongsiIDArr;
@property(nonatomic,strong)NSMutableArray *jueseIDArr;

@end

@implementation UserAddEditViewController
- (NSMutableArray *)gongsiIDArr{
    if (_gongsiIDArr == nil) {
        self.gongsiIDArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _gongsiIDArr;
}
- (NSMutableArray *)jueseIDArr{
    if (_jueseIDArr == nil) {
        self.jueseIDArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _jueseIDArr;
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
    [self lodArr1];
    
    
    
    
    if ([self.navigationItem.title isEqualToString:@"编辑"]){
        [self setupview1];
        text1.text = self.str1;
        string1 = self.str1ID;
        
        [self lodArr2];
        [self lodArr3];
        
        text2.text = [self.companyTitleArr componentsJoinedByString:@","];
        text3.text = [self.roleTitleArr componentsJoinedByString:@","];
        
        self.selextedArr1 = self.companyTitleArr;
        self.gongsiIDArr = self.companyIDArr;
        
        self.selextedArr2 = self.roleTitleArr;
        self.jueseIDArr  = self.roleIDArr;
        
        text4.text = self.str4;
        text5.text = self.str5;
        text6.text = self.str6;
        text7.text = self.str7;
    }
    else{ [self setupview];}
    [self setuptableview];
}









- (void)lodArr1{
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
        [weakSelf.arr1 removeAllObjects];
        for (NSDictionary *dicc in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
            [weakSelf.arr1 addObject:model];
        }
    } enError:^(NSError *error) {
    }];
}
- (void)lodArr2{
    __weak typeof (self) weakSelf = self;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    [arr removeAllObjects];
    [arr addObject:string1];
    NSDictionary *dict = @{@"searchGroupId":arr,
                           };
    [Manager requestPOSTWithURLStr:KURLNSString(@"group/groupcompany/list") paramDic:dict token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"========%@",diction);
        NSMutableArray *arr = (NSMutableArray *)diction;
        [weakSelf.arr2 removeAllObjects];
        for (NSDictionary *dicc in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
            [weakSelf.arr2 addObject:model];
        }
    } enError:^(NSError *error) {
    }];
}
- (void)lodArr3{
    __weak typeof (self) weakSelf = self;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
    [arr removeAllObjects];
    [arr addObject:string1];
    NSDictionary *dict = @{@"searchGroupId":arr,
                           };
    [Manager requestPOSTWithURLStr:KURLNSString(@"system/systemrole/list") paramDic:dict token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"========%@",diction);
        NSMutableArray *arr = (NSMutableArray *)diction;
        [weakSelf.arr3 removeAllObjects];
        for (NSDictionary *dicc in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dicc];
            [weakSelf.arr3 addObject:model];
        }
    } enError:^(NSError *error) {
    }];
}











- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr == self.arr1){
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ModelOne *model = [self.arr1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.groupName;
        return cell;
    }
    if (self.dataArr == self.arr2){
        static NSString *identifierCell = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ModelOne *model = [self.arr2 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.companyName;
        //判断是否选中（选中单元格尾部打勾）
        if ([self.selextedArr1 containsObject:model.companyName]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    static NSString *identifierCell = @"cell3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ModelOne *model = [self.arr3 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.roleName;
    //判断是否选中（选中单元格尾部打勾）
    if ([self.selextedArr2 containsObject:model.roleName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr == self.arr1){
        //清空
        [self.selextedArr1 removeAllObjects];
        [self.arr2 removeAllObjects];
        text2.text = @"";
        [self.gongsiIDArr removeAllObjects];
        //清空
        [self.selextedArr2 removeAllObjects];
        [self.arr3 removeAllObjects];
        text3.text = @"";
        [self.jueseIDArr removeAllObjects];
        //----------------
        ModelOne *model = [self.arr1 objectAtIndex:indexPath.row];
        text1.text = model.groupName;
        string1 = model.id;
        [self lodArr2];
        [self lodArr3];
        bgview.hidden = YES;
    }
    if (self.dataArr == self.arr2){
        //判断该行原先是否选中
        ModelOne *model = [self.arr2 objectAtIndex:indexPath.row];
        if ([self.selextedArr1 containsObject:model.companyName] == YES) {
            [self.selextedArr1 removeObject:model.companyName];
            [self.gongsiIDArr removeObject:model.id];
        }else{
            [self.selextedArr1 addObject:model.companyName];
            [self.gongsiIDArr addObject:model.id];
        }
        text2.text = [self.selextedArr1 componentsJoinedByString:@","];
        [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (self.dataArr == self.arr3){
        ModelOne *models = [self.arr3 objectAtIndex:indexPath.row];
        if ([self.selextedArr2 containsObject:models.roleName] == YES) {
            [self.selextedArr2 removeObject:models.roleName];
            [self.jueseIDArr removeObject:models.id];
        }else{
            [self.selextedArr2 addObject:models.roleName];
            [self.jueseIDArr addObject:models.id];
        }
        text3.text = [self.selextedArr2 componentsJoinedByString:@","];
        [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField isEqual:text4]) {
        if (text4.text.length >20 || text4.text.length <6) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"用户名为6-20位字符组成" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [self judUsername];
    }
    if ([textField isEqual:text5]) {
        if ([XYQRegexPatternHelper validatePassword:text5.text] == NO) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"用户密码为6-20位字符组成" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    if ([textField isEqual:text7]) {
        if ([XYQRegexPatternHelper validateMobile:text7.text] == NO) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入正确的手机号" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    return YES;
}






- (void)textres{
    [text4 resignFirstResponder];
    [text5 resignFirstResponder];
    [text6 resignFirstResponder];
    [text7 resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [self textres];
        bgview.hidden = NO;
        btn2.hidden = YES;
        btn3.hidden = NO;
        self.dataArr = self.arr1;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text2]) {
        [self textres];
        if (string1.length != 0) {
            bgview.hidden = NO;
            btn2.hidden = NO;
            btn3.hidden = YES;
            
            self.dataArr = self.arr2;
            [self.tableview reloadData];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先选择所属集团" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        return NO;
    }
    if ([textField isEqual:text3]) {
        [self textres];
        if (string1.length != 0) {
            bgview.hidden = NO;
            btn2.hidden = NO;
            btn3.hidden = YES;
            self.dataArr = self.arr3;
            [self.tableview reloadData];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请先选择所属集团" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        return NO;
    }
    if ([textField isEqual:text4]) {
        if ([self.navigationItem.title isEqualToString:@"编辑"]){
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}


-(void)save{
    __weak typeof (self) weakSelf = self;
    if ([self.navigationItem.title isEqualToString:@"编辑"]){
        if (string1.length != 0 && self.gongsiIDArr.count != 0 &&
            self.jueseIDArr.count != 0 && text6.text.length != 0 &&
            text7.text.length != 0) {
            NSDictionary *dic = @{@"groupId":string1,
                                  @"companyIds":self.gongsiIDArr,
                                  @"roleIds":self.jueseIDArr,
                                  @"realName":text6.text,
                                  @"mobilePhone":text7.text,
                                  };
            NSLog(@"******%@",dic);
            
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"system/systemuser/update"),self.idstr];
            [Manager requestPOSTWithURLStr:urlstr paramDic:dic token:nil finish:^(id responseObject) {
                NSDictionary *diction = [Manager returndictiondata:responseObject];
                //NSLog(@"******%@",diction);
                if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        NSNotification *notification =[NSNotification notificationWithName:@"yha" object:nil userInfo:dict];
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
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
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有字段不能为空" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        if (string1.length != 0 && self.gongsiIDArr.count != 0 &&
            self.jueseIDArr.count != 0 && text4.text.length != 0 &&
            text5.text.length != 0 && text6.text.length != 0 &&
            text7.text.length != 0) {
           
            NSDictionary *dic = @{@"groupId":string1,
                                  @"companyIds":self.gongsiIDArr,
                                  @"roleIds":self.jueseIDArr,
                                  @"userName":text4.text,
                                  @"password":text5.text,
                                  @"realName":text6.text,
                                  @"mobilePhone":text7.text,
                                  };
            //NSLog(@"******%@",dic);
            [Manager requestPOSTWithURLStr:KURLNSString(@"system/systemuser/add") paramDic:dic token:nil finish:^(id responseObject) {
                NSDictionary *diction = [Manager returndictiondata:responseObject];
                //NSLog(@"******%@",diction);
                if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        NSNotification *notification =[NSNotification notificationWithName:@"yha" object:nil userInfo:dict];
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    }];
                    [alert addAction:cancel];
                    [weakSelf presentViewController:alert animated:YES completion:nil];
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"用户名或者密码格式错误" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alert addAction:cancel];
                    [weakSelf presentViewController:alert animated:YES completion:nil];
                }
            } enError:^(NSError *error) {
                NSLog(@"******%@",error);
            }];
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有字段不能为空" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}


- (void)judUsername{
    __weak typeof (self) weakSelf = self;
    NSDictionary *dic = @{@"userName":text4.text,
                          };
    [Manager requestPOSTWithURLStr:KURLNSString(@"system/systemuser/list") paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)diction;
        if (arr.count != 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"用户名已经存在，请重新填写用户名" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            
        }
    } enError:^(NSError *error) {
        
    }];
}























- (void)setupview1{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+height, SCREEN_WIDTH-20, 30)];
    lab1.text = @"所属集团:";
    [self.view addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 40+height, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请选择所属集团";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 90+height, SCREEN_WIDTH-20, 30)];
    lab2.text = @"所属公司:";
    [self.view addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 120+height, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"请选择所属公司";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 170+height, SCREEN_WIDTH-20, 30)];
    lab3.text = @"角色名称:";
    [self.view addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 200+height, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"请选择角色名称";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 250+height, SCREEN_WIDTH-20, 30)];
    lab4.text = @"用户名:";
    [self.view addSubview:lab4];
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 280+height, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.placeholder = @"请输入用户名";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text4];
    
   
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 330+height, SCREEN_WIDTH-20, 30)];
    lab6.text = @"真实姓名:";
    [self.view addSubview:lab6];
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(10, 360+height, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.placeholder = @"请输入真实姓名";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text6];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 410+height, SCREEN_WIDTH-20, 30)];
    lab7.text = @"手机号:";
    [self.view addSubview:lab7];
    text7 = [[UITextField alloc]initWithFrame:CGRectMake(10, 440+height, SCREEN_WIDTH-20, 40)];
    text7.delegate = self;
    text7.keyboardType = UIKeyboardTypeNumberPad;
    text7.placeholder = @"请输入手机号";
    text7.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text7];
    
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
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 40+height, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请选择所属集团";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 90+height, SCREEN_WIDTH-20, 30)];
    lab2.text = @"所属公司:";
    [self.view addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 120+height, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"请选择所属公司";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 170+height, SCREEN_WIDTH-20, 30)];
    lab3.text = @"角色名称:";
    [self.view addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 200+height, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"请选择角色名称";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 250+height, SCREEN_WIDTH-20, 30)];
    lab4.text = @"用户名:";
    [self.view addSubview:lab4];
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 280+height, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.placeholder = @"请输入用户名";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 330+height, SCREEN_WIDTH-20, 30)];
    lab5.text = @"密码:";
    [self.view addSubview:lab5];
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(10, 360+height, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.placeholder = @"请输入密码";
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text5];
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 410+height, SCREEN_WIDTH-20, 30)];
    lab6.text = @"真实姓名:";
    [self.view addSubview:lab6];
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(10, 440+height, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.placeholder = @"请输入真实姓名";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text6];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 490+height, SCREEN_WIDTH-20, 30)];
    lab7.text = @"手机号:";
    [self.view addSubview:lab7];
    text7 = [[UITextField alloc]initWithFrame:CGRectMake(10, 520+height, SCREEN_WIDTH-20, 40)];
    text7.delegate = self;
    text7.keyboardType = UIKeyboardTypeNumberPad;
    text7.placeholder = @"请输入手机号";
    text7.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text7];

}


- (void)clickbtn2{
    bgview.hidden = YES;
}
- (void)clickbtn3{
    bgview.hidden = YES;
}
- (void)setuptableview{
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    bgview.hidden = YES;
    [self.view addSubview:bgview];
   
    btn2  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 addTarget:self action:@selector(clickbtn2) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:btn2];
    
    btn3  = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [btn3 setTitle:@"取消" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor lightGrayColor];
    [btn3 addTarget:self action:@selector(clickbtn3) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:btn3];
    
    btn2.hidden = YES;
    btn3.hidden = YES;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-450, SCREEN_WIDTH, 400)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    [bgview addSubview:self.tableview];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview.tableFooterView = v;
    
    [self.view bringSubviewToFront:self.tableview];
}





- (NSMutableArray *)companyIDArr{
    if (_companyIDArr == nil) {
        self.companyIDArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _companyIDArr;
}
- (NSMutableArray *)companyTitleArr{
    if (_companyTitleArr == nil) {
        self.companyTitleArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _companyTitleArr;
}






- (NSMutableArray *)roleIDArr{
    if (_roleIDArr == nil) {
        self.roleIDArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _roleIDArr;
}
- (NSMutableArray *)roleTitleArr{
    if (_roleTitleArr == nil) {
        self.roleTitleArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _roleTitleArr;
}



- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArr;
}
- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)arr2{
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)arr3{
    if (_arr3 == nil) {
        self.arr3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr3;
}
- (NSMutableArray *)selextedArr1{
    if (_selextedArr1 == nil) {
        self.selextedArr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _selextedArr1;
}
- (NSMutableArray *)selextedArr2{
    if (_selextedArr2 == nil) {
        self.selextedArr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _selextedArr2;
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
