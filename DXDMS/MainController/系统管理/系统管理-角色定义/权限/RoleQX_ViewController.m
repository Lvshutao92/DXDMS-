//
//  RoleQX_ViewController.m
//  DXDMS
//
//  Created by 吕书涛 on 2018/4/8.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "RoleQX_ViewController.h"
#import "SinTreeCheckView.h"
#import "SinTreeCheckNode.h"
@interface RoleQX_ViewController ()
{
    SinTreeCheckView *_treeCheck;
    SinTreeCheckNode *root;
}
@property(nonatomic,strong)NSMutableArray *array;

@property(nonatomic,strong)NSMutableArray *selectArray;

@property(nonatomic,strong)NSMutableArray *idArray;
@end

@implementation RoleQX_ViewController

- (NSMutableArray *)idArray{
    if (_idArray == nil) {
        self.idArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _idArray;
}
- (NSMutableArray *)selectArray{
    if (_selectArray == nil) {
        self.selectArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _selectArray;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)save{
    for (int i = 0; i<[Manager sharedManager].roleQXArray.count; i++) {
        NSString *string = [Manager sharedManager].roleQXArray[i];
        if ([string isEqualToString:@"0"]) {
            [[Manager sharedManager].roleQXArray removeObject:string];
        }
    }
    //NSLog(@"=======------%@",[Manager sharedManager].roleQXArray);
    __weak typeof(self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"system/systemrole/save/resource"),self.idstr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[Manager redingwenjianming:@"token.text"] forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:[Manager redingwenjianming:@"companyID.text"] forHTTPHeaderField:@"companyId"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];

    [manager POST:str parameters:[Manager sharedManager].roleQXArray progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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
        //NSLog(@"******%@",diction);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"******%@",error);
    }];
}
- (void)viewDidLoad
{
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
    _treeCheck = [[SinTreeCheckView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-0)];
    _treeCheck.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    
    
    [self lodQuanXianInfo];
}



- (void)lodQuanXianInfo{
    __weak typeof (self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"system/systemrole/edit/resource"),self.idstr];
    [Manager requestPOSTWithURLStr:str paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)diction;
        [ModelOne mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"children" : [ModelOne class],
                     };
        }];
        //NSLog(@"******%@",diction);
        for (NSDictionary *di in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:di];
            [weakSelf.array addObject:model];
        }
        for (ModelOne *model in weakSelf.array){
            if ([model.checked isEqualToString:@"true"]) {
                if (![[Manager sharedManager].roleQXArray containsObject:model.id]) {
                    [[Manager sharedManager].roleQXArray addObject:model.id];
                }
            }
            for (ModelOne *model1 in model.children) {
                if ([model1.checked isEqualToString:@"true"]) {
                    if (![[Manager sharedManager].roleQXArray containsObject:model1.id]) {
                        [[Manager sharedManager].roleQXArray addObject:model1.id];
                    }
                }
                for (ModelOne *model2 in model1.children) {
                    if ([model2.checked isEqualToString:@"true"]) {
                        if (![[Manager sharedManager].roleQXArray containsObject:model2.id]) {
                            [[Manager sharedManager].roleQXArray addObject:model2.id];
                        }
                    }
                    
                }
            }
        }
        
        
        
        
        SinTreeCheckNode *root = [SinTreeCheckNode nodeWithProperties:0 andText:@"全选" superId:0 superIds:0];
        
        for (ModelOne *model in weakSelf.array){
            NSInteger pid = [model.id integerValue];
            SinTreeCheckNode *n_1 = [SinTreeCheckNode nodeWithProperties:pid andText:model.label superId:0 superIds:0];
            [root addChild:n_1];
  
            
            for (ModelOne *model1 in model.children) {
                NSInteger pid1 = [model1.id integerValue];
                SinTreeCheckNode *n_1_1 = [SinTreeCheckNode nodeWithProperties:pid1 andText:model1.label superId:pid superIds:0];
                [n_1 addChild:n_1_1];
            
                
                for (ModelOne *model2 in model1.children) {
                    NSInteger pid2 = [model2.id integerValue];
                    SinTreeCheckNode *n_1_1_1 = [SinTreeCheckNode nodeWithProperties:pid2 andText:model2.label superId:pid2 superIds:pid1];
                    [n_1_1 addChild:n_1_1_1];
                }
            }
        }
        // 设置默认展开层数
        [root ergodicNode:^BOOL(SinTreeCheckNode *node) {
            if(node.level<1){
                // 展开1层
                node.expanded = YES;
                return YES;
            }else{
                return NO;
            }
        }];
        [_treeCheck setRootNode:root];
        [weakSelf.view addSubview:_treeCheck];
    } enError:^(NSError *error) {
        //NSLog(@"%@",error);
    }];
    
    
}


- (NSMutableArray *)array {
    if (_array == nil) {
        self.array = [NSMutableArray arrayWithCapacity:1];
    }
    return _array;
}
@end
