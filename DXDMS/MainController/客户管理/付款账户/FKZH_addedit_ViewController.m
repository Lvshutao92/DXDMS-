//
//  FKZH_addedit_ViewController.m
//  DXDMS
//
//  Created by 吕书涛 on 2018/4/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "FKZH_addedit_ViewController.h"

@interface FKZH_addedit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UIView *bgview;
    
    UIScrollView *scrollview;
    
    NSString *type;
    NSString *name;
}

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSMutableArray *dataarray;
@end

@implementation FKZH_addedit_ViewController
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
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
            [self lodEditGetList];
    }
    
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
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnerbank/get"),self.idstr];
    [Manager requestPOSTWithURLStr:str paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSLog(@"***6666***%@",diction);
        text3.text = [diction objectForKey:@"paymentAccount"];
        text4.text = [diction objectForKey:@"paymentNo"];

        NSString *str2 = [NSString stringWithFormat:@"%@",[diction objectForKey:@"paymentType"]];
        NSString *str1 = [NSString stringWithFormat:@"%@",[diction objectForKey:@"partnerInfoId"]];



        for (ModelOne *statusModel in self.arr2) {
            if ([statusModel.key isEqualToString:str2]) {
                text2.text = statusModel.value;
            }
        }

        for (ModelOne *kehuModel in self.arr1) {
            if ([kehuModel.id isEqualToString:str1]) {
                text1.text = kehuModel.partnerName;
            }
        }

        name   = str1;
        type   = str2;
    } enError:^(NSError *error) {
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataarray == self.arr1) {
        return self.arr1.count;
    }
    return self.arr2.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataarray == self.arr1){
        static NSString *identifierCell = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ModelOne *model = [self.arr1 objectAtIndex:indexPath.row];
        
        cell.textLabel.text = model.partnerName;
        return cell;
    }
    static NSString *identifierCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ModelOne *model = [self.arr2 objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.value;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataarray == self.arr1){
        ModelOne *model = [self.arr1 objectAtIndex:indexPath.row];
        name = model.id;
        text1.text = model.partnerName;
        bgview.hidden = YES;
    }
    if (self.dataarray == self.arr2){
        ModelOne *model = [self.arr2 objectAtIndex:indexPath.row];
        type = model.key;
        text2.text = model.value;
        bgview.hidden = YES;
    }
    
   
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        bgview.hidden = NO;
        [text3 resignFirstResponder];
        [text4 resignFirstResponder];
        self.dataarray = self.arr1;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text2]) {
        bgview.hidden = NO;
        [text3 resignFirstResponder];
        [text4 resignFirstResponder];
        self.dataarray = self.arr2;
        [self.tableview reloadData];
        return NO;
    }
    return YES;
}






-(void)save{

    if (text1.text.length != 0 && text2.text.length != 0 && text3.text.length != 0 && text4.text.length != 0) {
        if ([self.navigationItem.title isEqualToString:@"新增"]) {
            [self lodadd];
        }else{
            [self lodedit];
        }
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有信息不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (void)lodadd{
    __weak typeof (self) weakSelf = self;
    
    NSDictionary *dic = @{@"partnerInfoId":name,
                          @"paymentType":type,
                          @"paymentAccount":text3.text,
                          @"paymentNo":text4.text,
                          };
    [Manager requestPOSTWithURLStr:KURLNSString(@"partner/partnerbank/add") paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"fkzh" object:nil userInfo:dict];
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
    NSDictionary *dic = @{@"partnerInfoId":name,
                          @"paymentType":type,
                          @"paymentAccount":text3.text,
                          @"paymentNo":text4.text,
                          };
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnerbank/update"),self.idstr];
    [Manager requestPOSTWithURLStr:urlstr paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"fkzh" object:nil userInfo:dict];
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
    text1.placeholder = @"客户名称";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, SCREEN_WIDTH-20, 30)];
    lab2.text = @"支付方式:";
    [scrollview addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"支付方式";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH-20, 30)];
    lab3.text = @"付款账户:";
    [scrollview addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 250, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"付款账户";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, 30)];
    lab4.text = @"付款账号:";
    [scrollview addSubview:lab4];
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 350, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.placeholder = @"付款账号";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text4];
   
    
}

- (NSMutableArray *)arr2{
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)dataarray{
    if (_dataarray == nil) {
        self.dataarray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataarray;
}
@end
