//
//  KHLB_add_edit_ViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/2.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "KHLB_add_edit_ViewController.h"

@interface KHLB_add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    UITextField *text9;
    UIScrollView *scrollview;
    
    NSString *sheng;
    NSString *shi;
    NSString *qu;
    
    
    UIView *bgview;
}
@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,strong)UITableView *tableview2;
@property(nonatomic,strong)UITableView *tableview3;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr3;
@end

@implementation KHLB_add_edit_ViewController
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
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollview.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:scrollview];
    
    [self lodaddress];
    
    [self setupview];
    if ([self.navigationItem.title isEqualToString:@"编辑"]){
        [self lodgetinfo];
    }
    
    [self lodsetupview];
}
- (void)lodaddress{
    __weak typeof(self) weakSelf = self;
    [Manager requestPOSTWithURLStr:KURLNSString(@"common/address") paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)diction;
        [weakSelf.arr1 removeAllObjects];
        [weakSelf.arr2 removeAllObjects];
        [weakSelf.arr3 removeAllObjects];
        
        [ModelOne mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"children" : [ModelOne class],
                     };
        }];
        
        for (NSDictionary *dic1 in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:dic1];
            [weakSelf.arr1 addObject:model];
        }
        
        
//        ModelOne *model1 = [weakSelf.arr1 firstObject];
//        for (ModelOne *teomodel in model1.children) {
//            [weakSelf.arr2 addObject:teomodel];
//        }
//
//        ModelOne *model2 = [weakSelf.arr2 firstObject];
//        for (ModelOne *threemodel in model2.children) {
//            [weakSelf.arr3 addObject:threemodel];
//        }
        
    } enError:^(NSError *error) {
    }];
}



- (void)clickbtn1{
    if (sheng.length == 0) {
        sheng = @"";
    }
    if (shi.length == 0) {
        shi = @"";
    }
    if (qu.length == 0) {
        qu = @"";
    }
    text2.text = [NSString stringWithFormat:@"%@%@%@",sheng,shi,qu];
    bgview.hidden = YES;
}
- (void)lodsetupview{
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
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-450, SCREEN_WIDTH/3-1, 400)];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [bgview addSubview:self.tableview1];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview1.tableFooterView = v;
    [self.view bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3+1, SCREEN_HEIGHT-450, SCREEN_WIDTH/3-2, 400)];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [bgview addSubview:self.tableview2];
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview2.tableFooterView = v1;
    [self.view bringSubviewToFront:self.tableview2];
    
    
    self.tableview3 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2+1, SCREEN_HEIGHT-450, SCREEN_WIDTH/3-1, 400)];
    self.tableview3.delegate = self;
    self.tableview3.dataSource = self;
    [self.tableview3 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    [bgview addSubview:self.tableview3];
    UIView *v2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableview3.tableFooterView = v2;
    [self.view bringSubviewToFront:self.tableview3];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.arr1.count;
    }
    if ([tableView isEqual:self.tableview2]) {
        return self.arr2.count;
    }
    return self.arr3.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]){
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        ModelOne *model = [self.arr1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.value;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        return cell;
    }
    if ([tableView isEqual:self.tableview2]){
        static NSString *identifierCell = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        ModelOne *model = [self.arr2 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.value;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        return cell;
    }
    static NSString *identifierCell = @"cell3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    ModelOne *model = [self.arr3 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.value;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //tableview1
    if ([tableView isEqual:self.tableview1]) {
        [self.arr2 removeAllObjects];
        [self.arr3 removeAllObjects];
        sheng = @"";
        shi = @"";
        qu = @"";
        
        ModelOne *model = [self.arr1 objectAtIndex:indexPath.row];
        sheng = model.value;
        for (ModelOne *model1 in model.children) {
            [self.arr2 addObject:model1];
        }
        [self.tableview2 reloadData];
        [self.tableview3 reloadData];
    }

    //tableview2
    if ([tableView isEqual:self.tableview2]) {
        [self.arr3 removeAllObjects];
        ModelOne *model1 = [self.arr2 objectAtIndex:indexPath.row];
        shi = model1.value;
        if ([Manager judgeWhetherIsEmptyAnyObject:model1.children] == YES) {
            for (ModelOne *model2 in model1.children) {
                [self.arr3 addObject:model2];
            }
            [self.tableview3 reloadData];
        }
    }
    //tableview3
    if ([tableView isEqual:self.tableview3]) {
        ModelOne *model = [self.arr3 objectAtIndex:indexPath.row];
        qu = model.value;
    }
    
}












- (void)lodgetinfo{
    //__weak typeof (self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnerinfo/get"),self.idstr];
    [Manager requestPOSTWithURLStr:str paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"-------%@",diction);
        text1.text = [diction objectForKey:@"partnerName"];

        sheng = [diction objectForKey:@"province"];
        shi = [diction objectForKey:@"city"];
        qu = [diction objectForKey:@"district"];
        text2.text = [NSString stringWithFormat:@"%@-%@-%@",sheng,shi,qu];
        
        text3.text = [diction objectForKey:@"addr"];
        text4.text = [diction objectForKey:@"shopName"];
        text5.text = [diction objectForKey:@"shopAddr"];
        text6.text = [diction objectForKey:@"email"];
        text7.text = [diction objectForKey:@"mobile"];
        text8.text = [diction objectForKey:@"phone"];
        text9.text = [diction objectForKey:@"qq"];
        
    } enError:^(NSError *error) {
    }];
}






- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text2]) {
        [text1 resignFirstResponder];
        [text3 resignFirstResponder];
        [text4 resignFirstResponder];
        [text5 resignFirstResponder];
        [text6 resignFirstResponder];
        [text7 resignFirstResponder];
        [text8 resignFirstResponder];
        [text9 resignFirstResponder];
        bgview.hidden = NO;
        
        [self.tableview2 reloadData];
        [self.tableview3 reloadData];
        [self.tableview1 reloadData];
        
//        [FYLCityPickView showPickViewWithComplete:^(NSArray *arr) {
//            text2.text = [NSString stringWithFormat:@"%@-%@-%@",arr[0],arr[1],arr[2]];
//            sheng = arr[0];
//            shi = arr[1];
//            qu = arr[2];
//        }];
        return NO;
    }
    return YES;
}


-(void)save{
    
    
    if (qu.length == 0) {
        qu = @"";
    }
    
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
    }
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (text7.text.length == 0) {
        text7.text = @"";
    }
    if (text8.text.length == 0) {
        text8.text = @"";
    }
    if (text9.text.length == 0) {
        text9.text = @"";
    }
    
    
    
    
    
    if (text1.text.length != 0 && sheng.length != 0 && shi.length != 0) {
    if ([self.navigationItem.title isEqualToString:@"新增"]) {
        [self lodadd];
    }else{
        [self lodedit];
    }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有字段不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)lodadd{
    __weak typeof (self) weakSelf = self;
    NSDictionary *dic = @{@"partnerName":text1.text,
                          @"province":sheng,
                          @"city":shi,
                          @"district":qu,
                          @"addr":text3.text,
                          @"shopName":text4.text,
                          @"shopAddr":text5.text,
                          @"email":text6.text,
                          @"mobile":text7.text,
                          @"phone":text8.text,
                          @"qq":text9.text,
                          };
    [Manager requestPOSTWithURLStr:KURLNSString(@"partner/partnerinfo/add") paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"khlb" object:nil userInfo:dict];
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
- (void)lodedit{
    __weak typeof (self) weakSelf = self;
    NSDictionary *dic = @{@"partnerName":text1.text,
                          @"province":sheng,
                          @"city":shi,
                          @"district":qu,
                          @"addr":text3.text,
                          @"shopName":text4.text,
                          @"shopAddr":text5.text,
                          @"email":text6.text,
                          @"mobile":text7.text,
                          @"phone":text8.text,
                          @"qq":text9.text,
                          };
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnerinfo/update"),self.idstr];
    [Manager requestPOSTWithURLStr:urlstr paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"khlb" object:nil userInfo:dict];
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





- (void)setupview{
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
    lab1.text = @"客户名称:";
    [scrollview addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入客户名称";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, SCREEN_WIDTH-20, 30)];
    lab2.text = @"省市区:";
    [scrollview addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"请选择省市区";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH-20, 30)];
    lab3.text = @"详细地址:";
    [scrollview addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 250, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"请输入详细地址";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, 30)];
    lab4.text = @"店铺名称:";
    [scrollview addSubview:lab4];
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 350, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.placeholder = @"请输入店铺名称";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 410, SCREEN_WIDTH-20, 30)];
    lab5.text = @"店铺地址:";
    [scrollview addSubview:lab5];
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(10, 450, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.placeholder = @"请输入店铺地址:";
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text5];
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 510, SCREEN_WIDTH-20, 30)];
    lab6.text = @"邮箱:";
    [scrollview addSubview:lab6];
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(10, 550, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.placeholder = @"请输入邮箱账号";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text6];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 610, SCREEN_WIDTH-20, 30)];
    lab7.text = @"手机:";
    [scrollview addSubview:lab7];
    text7 = [[UITextField alloc]initWithFrame:CGRectMake(10, 650, SCREEN_WIDTH-20, 40)];
    text7.delegate = self;
    text7.placeholder = @"请输入手机号";
    text7.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text7];
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 710, SCREEN_WIDTH-20, 30)];
    lab8.text = @"电话:";
    [scrollview addSubview:lab8];
    text8 = [[UITextField alloc]initWithFrame:CGRectMake(10, 750, SCREEN_WIDTH-20, 40)];
    text8.delegate = self;
    text8.placeholder = @"请输入电话";
    text8.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text8];
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 810, SCREEN_WIDTH-20, 30)];
    lab9.text = @"qq:";
    [scrollview addSubview:lab9];
    text9 = [[UITextField alloc]initWithFrame:CGRectMake(10, 850, SCREEN_WIDTH-20, 40)];
    text9.delegate = self;
    text9.placeholder = @"请输入qq号码";
    text9.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text9];
    
    
    text5.keyboardType = UIKeyboardTypeURL;
    text6.keyboardType = UIKeyboardTypeEmailAddress;
    text7.keyboardType = UIKeyboardTypePhonePad;
    text8.keyboardType = UIKeyboardTypePhonePad;
    text9.keyboardType = UIKeyboardTypeNumberPad;
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

@end
