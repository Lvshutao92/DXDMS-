//
//  CompanyAddEditViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/15.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "CompanyAddEditViewController.h"

@interface CompanyAddEditViewController ()<UITextFieldDelegate>
{
    UITextField *text1;
    UITextField *text2;
}
@property (nonatomic, strong) DateTimePickerView *datePickerView;
@end

@implementation CompanyAddEditViewController
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
        [self lodEditGetList];
    }
}
- (void)lodEditGetList{
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"group/groupbase/get"),self.idstr];
    [Manager requestPOSTWithURLStr:str paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        text1.text = [diction objectForKey:@"groupCode"];
        text2.text = [diction objectForKey:@"groupName"];
    } enError:^(NSError *error) {
    }];
}




-(void)save{
    if (text1.text.length != 0 && text2.text.length != 0) {
        
        __weak typeof (self) weakSelf = self;
        if ([self.navigationItem.title isEqualToString:@"新增"]) {
            NSDictionary *dic = @{@"groupCode":text1.text,
                                  @"groupName":text2.text,
                                  };
            [Manager requestPOSTWithURLStr:KURLNSString(@"group/groupbase/add") paramDic:dic token:nil finish:^(id responseObject) {
                NSDictionary *diction = [Manager returndictiondata:responseObject];
                //NSLog(@"******%@",diction);
                if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        NSNotification *notification =[NSNotification notificationWithName:@"jituan" object:nil userInfo:dict];
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
            NSDictionary *dic = @{@"groupCode":text1.text,
                                  @"groupName":text2.text,
                                  };
            NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"group/groupbase/update"),self.idstr];
            [Manager requestPOSTWithURLStr:urlstr paramDic:dic token:nil finish:^(id responseObject) {
                NSDictionary *diction = [Manager returndictiondata:responseObject];
                //NSLog(@"******%@",diction);
                if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        NSNotification *notification =[NSNotification notificationWithName:@"jituan" object:nil userInfo:dict];
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
//    if ([textField isEqual:text4]) {
//        [text1 resignFirstResponder];
//        [text2 resignFirstResponder];
//        [text3 resignFirstResponder];
//        DateTimePickerView *pickerView = [[DateTimePickerView alloc] init];
//        self.datePickerView = pickerView;
//        pickerView.delegate = self;
//        pickerView.pickerViewMode = DatePickerViewDateTimeMode;
//        [self.view addSubview:pickerView];
//        [pickerView showDateTimePickerView];
//        return NO;
//    }
    return YES;
}


//#pragma mark - delegate DateTimePickerViewDelegate
//- (void)didClickFinishDateTimePickerView:(NSString *)date{
//    text4.text = [NSString stringWithFormat:@"%@:00",date];
//}
- (void)setupview{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+height, SCREEN_WIDTH-20, 30)];
    lab1.text = @"集团编号:";
    [self.view addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 50+height, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入集团编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110+height, SCREEN_WIDTH-20, 30)];
    lab2.text = @"集团名称:";
    [self.view addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 150+height, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"请输入集团名称";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:text2];
    
}

@end
