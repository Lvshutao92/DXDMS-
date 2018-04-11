//
//  FPXX_edit_ViewController.m
//  DXDMS
//
//  Created by 吕书涛 on 2018/4/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "FPXX_edit_ViewController.h"

@interface FPXX_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    
    NSString *inviocetype;
    NSString *partnerInfoId;
    
    
    
    UIView *bgview;
    
    UIScrollView *scrollview;
}
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation FPXX_edit_ViewController
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
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollview.contentSize = CGSizeMake(0, 900);
    [self.view addSubview:scrollview];
    
    
    [self setupview];
   
    
    [self setuptableview];
    
    [self lodEditGetList];
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

- (void)lodEditGetList{
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnerinvoice/get"),self.idstr];
    [Manager requestPOSTWithURLStr:str paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
//        NSLog(@"******%@",diction);
        text1.text = [diction objectForKey:@"invoiceAddr"];
        text2.text = [diction objectForKey:@"invoiceBankName"];
        text3.text = [diction objectForKey:@"invoiceBankNo"];
        text4.text = [diction objectForKey:@"invoiceCode"];
        text5.text = [diction objectForKey:@"invoicePhone"];
        text6.text = [diction objectForKey:@"invoiceTitle"];
        
        NSString *str1 = [NSString stringWithFormat:@"%@",[diction objectForKey:@"invoiceType"]];
        NSString *str2 = [NSString stringWithFormat:@"%@",[diction objectForKey:@"partnerInfoId"]];
        
        
        
        for (ModelOne *statusModel in self.arr) {
            if ([statusModel.key isEqualToString:str1]) {
                text7.text = statusModel.value;
            }
        }
        
        for (ModelOne *kehuModel in self.arr1) {
            if ([kehuModel.id isEqualToString:str2]) {
                text8.text = kehuModel.partnerName;
            }
        }
        
       
        
        inviocetype   = str1;
        partnerInfoId = str2;
    } enError:^(NSError *error) {
    }];
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
    
    cell.textLabel.text = model.value;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelOne *model = [self.arr objectAtIndex:indexPath.row];
    inviocetype = model.key;
    text7.text = model.value;
    bgview.hidden = YES;
}









-(void)save{
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
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
    if (text8.text.length != 0 && text7.text.length != 0 && text6.text.length != 0) {
        __weak typeof (self) weakSelf = self;
            NSDictionary *dic = @{@"invoiceAddr":text1.text,
                                  @"invoiceBankName":text2.text,
                                  @"invoiceBankNo":text3.text,
                                  @"invoiceCode":text4.text,
                                  @"invoicePhone":text5.text,
                                  @"invoiceTitle":text6.text,
                                  @"invoiceType":inviocetype,
                                  @"partnerInfoId":partnerInfoId,
                                  };
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnerinvoice/update"),self.idstr];
            [Manager requestPOSTWithURLStr:urlstr paramDic:dic token:nil finish:^(id responseObject) {
                NSDictionary *diction = [Manager returndictiondata:responseObject];
                //NSLog(@"******%@",diction);
                if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        NSNotification *notification =[NSNotification notificationWithName:@"fpxx" object:nil userInfo:dict];
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
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"客户名称/发票抬头/发票类型不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text7]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        [text4 resignFirstResponder];
        [text5 resignFirstResponder];
        [text6 resignFirstResponder];
        bgview.hidden = NO;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text8]) {
        return NO;
    }
    return YES;
}

- (void)setupview{
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
    lab1.text = @"注册地址:";
    [scrollview addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"注册地址";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, SCREEN_WIDTH-20, 30)];
    lab2.text = @"开户银行:";
    [scrollview addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"开户银行";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH-20, 30)];
    lab3.text = @"银行账号:";
    [scrollview addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 250, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"银行账号";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, 30)];
    lab4.text = @"纳税人识别吗:";
    [scrollview addSubview:lab4];
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 350, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.placeholder = @"纳税人识别吗";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 410, SCREEN_WIDTH-20, 30)];
    lab5.text = @"注册电话:";
    [scrollview addSubview:lab5];
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(10, 450, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.placeholder = @"注册电话";
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text5];
    
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 510, SCREEN_WIDTH-20, 30)];
    lab6.text = @"发票抬头:";
    [scrollview addSubview:lab6];
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(10,550, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.placeholder = @"发票抬头";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text6];
    
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 610, SCREEN_WIDTH-20, 30)];
    lab7.text = @"发票类型:";
    [scrollview addSubview:lab7];
    text7 = [[UITextField alloc]initWithFrame:CGRectMake(10, 650, SCREEN_WIDTH-20, 40)];
    text7.delegate = self;
    text7.placeholder = @"发票类型";
    text7.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text7];
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 710, SCREEN_WIDTH-20, 30)];
    lab8.text = @"客户名称:";
    [scrollview addSubview:lab8];
    text8 = [[UITextField alloc]initWithFrame:CGRectMake(10, 750, SCREEN_WIDTH-20, 40)];
    text8.delegate = self;
    text8.placeholder = @"客户名称";
    text8.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text8];
    
}
@end
