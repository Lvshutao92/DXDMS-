//
//  LoginViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/10/16.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LoginViewController.h"
#import "DXDMS-Swift.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    NSString *appstore_verson;
    NSString *appstore_newverson;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupshuxingdaila];
    
    self.btn.layer.masksToBounds = YES;
    self.btn.layer.cornerRadius  = 5;
    LRViewBorderRadius(self.img, 8, 0, [UIColor whiteColor]);
    
    self.btn.backgroundColor =  [UIColor colorWithWhite:.8 alpha:.6];
    LRViewBorderRadius(self.btn, 5, 1, [UIColor colorWithWhite:.8 alpha:.8]);
    
    self.text2.text  = [Manager redingwenjianming:@"username.text"];
    self.text3.text  = [Manager redingwenjianming:@"password.text"];
    
    [self lodverson];
}
- (void)lodverson{
    NSString *dom= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *tex= [dom stringByAppendingPathComponent:@"newversion.text"];
    //取出存入的上次版本号版本号
    appstore_verson = [NSString stringWithContentsOfFile:tex encoding:NSUTF8StringEncoding error:nil];
    //__weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *session = [Manager returnsession];
    [session POST:@"https://itunes.apple.com/lookup?id=1309457456" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"------%@",dic);
        NSMutableArray *arr = [dic objectForKey:@"results"];
        NSDictionary *dict = [arr lastObject];
        //app store版本号
        appstore_newverson = dict[@"version"];
        //写入版本号
        NSString *doucments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        NSString *text= [doucments stringByAppendingPathComponent:@"newversion.text"];
        [appstore_newverson writeToFile:text atomically:YES encoding:NSUTF8StringEncoding error:nil];
        //NSLog(@"appstore版本：%@----存入的版本号：%@",appstore_newverson,appstore_verson);
        if ([appstore_verson isEqualToString:appstore_newverson] && appstore_verson != nil){
            //方法一：
            [SELUpdateAlert showUpdateAlertWithVersion:appstore_newverson Descriptions:@[@"1.阿里巴巴呼啦呼啦",@"2.阿里巴巴呼啦呼啦",@"3.阿里巴巴呼啦呼啦",@"4.阿里巴巴呼啦呼啦",@"5.阿里巴巴呼啦呼啦",@"6.阿里巴巴呼啦呼啦",@"7.阿里巴巴呼啦呼啦阿里巴巴呼啦呼啦阿里巴巴呼啦呼啦阿里巴巴呼啦呼啦阿里巴巴呼啦呼啦阿里巴巴呼啦呼啦阿里巴巴呼啦呼啦"]];
            //方法二：
            //[SELUpdateAlert showUpdateAlertWithVersion:@"1.0.0" Description:@"1.xxxxxxxxxx\n2.xxxxxxxxxxxxxxxxx\n3.xxxxxxxxx\n4.xxxxxxxxxx"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (IBAction)clickBtnLogin:(id)sender {
    
    
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
//                    NSLog(@"未知网络");
                    [self lodlogin];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
//                    NSLog(@"没有网络(断网)");
                    [self noNetWorking];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
//                    NSLog(@"手机自带网络");
                    [self lodlogin];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
//                    NSLog(@"WIFI");
                    [self lodlogin];
                    break;
            }
        }];
        [manager startMonitoring];
  
}
- (void)noNetWorking{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法连接网络，前往设置界面，查看该应用是否被允许连接网络！" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)lodlogin {
    NSDictionary *dic = @{@"userName":self.text2.text,
                          @"password":self.text3.text,
                          };
    [Manager requestPOSTWithURLStr:KURLNSString(@"system/user/login") paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSLog(@"----%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]]isEqualToString:@"200"]) {
            [Manager writewenjianming:@"username.text" content:self.text2.text];
            [Manager writewenjianming:@"password.text" content:self.text3.text];
            
            NSDictionary *dictt = [[NSDictionary alloc]init];
            NSNotification *notification =[NSNotification notificationWithName:@"hiddenlogin" object:nil userInfo:dictt];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [Manager writewenjianming:@"token.text" content:[[diction objectForKey:@"message"]objectForKey:@"token"]];
            NSMutableArray *arr = [[[diction objectForKey:@"message"]objectForKey:@"user"] objectForKey:@"groupCompanys"];
            NSDictionary *di = [arr firstObject];
            [Manager writewenjianming:@"companyID.text" content:[NSString stringWithFormat:@"%@",[di objectForKey:@"id"]]];
            [Manager writewenjianming:@"companyTitle.text" content:[NSString stringWithFormat:@"%@",[di objectForKey:@"companyName"]]];
            
            [[Manager sharedManager].companyArray removeAllObjects];
            for (NSDictionary *dictt in arr) {
                ModelOne *model = [ModelOne mj_objectWithKeyValues:dictt];
                [[Manager sharedManager].companyArray addObject:model];
            }
            
            
            [Manager writewenjianming:@"user.text" content:[[[diction objectForKey:@"message"]objectForKey:@"user"] objectForKey:@"realName"]];
            [Manager writewenjianming:@"phone.text" content:[[[diction objectForKey:@"message"]objectForKey:@"user"] objectForKey:@"mobilePhone"]];
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[diction objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } enError:^(NSError *error) {
        NSLog(@"%@",error);
        NSString *err = [NSString stringWithFormat:@"%@",error];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:err message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}
// admin    zhangqiang123456












- (void)setupshuxingdaila {
    self.text2.delegate = self;
    self.text2.borderStyle = UITextBorderStyleRoundedRect;
    self.text2.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.text3.delegate = self;
    self.text3.borderStyle = UITextBorderStyleRoundedRect;
    self.text3.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.text3.secureTextEntry = YES;
    self.text3.keyboardType = UIKeyboardTypeASCIICapable;
    
    
    self.text2.backgroundColor =  [UIColor colorWithWhite:.8 alpha:.5];
    self.text3.backgroundColor =  [UIColor colorWithWhite:.8 alpha:.5];
    
    
    LRViewBorderRadius(self.text2, 5, 1, [UIColor colorWithWhite:.8 alpha:.8]);
    LRViewBorderRadius(self.text3, 5, 1, [UIColor colorWithWhite:.8 alpha:.8]);
    
    
    [self vie2];
    [self vie3];
}

- (void)vie2{
    _text2.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user-1"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _text2.leftView = lv;
}
- (void)vie3{
    _text3.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lock"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _text3.leftView = lv;
}

- (IBAction)clicktapchangeimg:(id)sender {
    
}



@end
