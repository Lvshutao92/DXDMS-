//
//  SelecQuanXianViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/21.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "SelecQuanXianViewController.h"
#import "SinTreeCheckNode.h"
#import "SinTreeCheckView.h"
@interface SelecQuanXianViewController ()
{
    SinTreeCheckView *_treeCheck;
    SinTreeCheckNode *root;
}
@property(nonatomic,strong)NSMutableArray *array;

@property(nonatomic,strong)NSMutableArray *selectArray;

@property(nonatomic,strong)NSMutableArray *idArray;
@end

@implementation SelecQuanXianViewController
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
    for (int i = 0; i<[Manager sharedManager].qxArray.count; i++) {
        NSString *string = [Manager sharedManager].qxArray[i];
        if ([string isEqualToString:@"0"]) {
            [[Manager sharedManager].qxArray removeObjectAtIndex:i];
        }
    }
    //NSLog(@"=======------%@",[Manager sharedManager].qxArray);
    __weak typeof(self) weakSelf = self;
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"group/groupbase/group/update"),self.idstr];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[Manager redingwenjianming:@"token.text"] forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:[Manager redingwenjianming:@"companyID.text"] forHTTPHeaderField:@"companyId"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];

    [manager POST:str parameters:[Manager sharedManager].qxArray progress:^(NSProgress * _Nonnull uploadProgress) {

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
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"group/groupbase/resource"),self.idstr];
    [Manager requestPOSTWithURLStr:str paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)diction;
        for (NSDictionary *di in arr) {
            ModelOne *model = [ModelOne mj_objectWithKeyValues:di];
            [weakSelf.array addObject:model];
            //NSLog(@"******%@",diction);
            if ([model.checked isEqualToString:@"true"]) {
                [[Manager sharedManager].qxArray addObject:model.id];
            }
        }
        NSMutableArray *firstArr = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *secondArr = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *thirdArr = [NSMutableArray arrayWithCapacity:1];
        NSInteger cid = 0;
        SinTreeCheckNode *root = [SinTreeCheckNode nodeWithProperties:cid andText:@"全选" superId:0 superIds:0];
        for (ModelOne *model in weakSelf.array) {
            if ([model.level isEqualToString:@"first"]) {
                [firstArr addObject:model];
            }
            if ([model.level isEqualToString:@"second"]) {
                [secondArr addObject:model];
            }
            if ([model.level isEqualToString:@"third"]) {
                [thirdArr addObject:model];
            }
        }
        for (ModelOne *model in firstArr) {
            NSInteger pid = [model.id integerValue];
             SinTreeCheckNode *n_1 = [SinTreeCheckNode nodeWithProperties:pid andText:model.name superId:0 superIds:0];
             [root addChild:n_1];
            //duibi
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];
            for (ModelOne *models in secondArr) {
                if ([models.pId isEqualToString:model.id]) {
                    [arr addObject:models];
                }
            }
            for (ModelOne *models1 in arr) {
                NSInteger pid1 = [models1.id integerValue];
                NSInteger id1  = [models1.pId integerValue];

                SinTreeCheckNode *n_1_1 = [SinTreeCheckNode nodeWithProperties:pid1 andText:models1.name superId:id1 superIds:0];
                [n_1 addChild:n_1_1];
                //duibi
                NSMutableArray *arra = [NSMutableArray arrayWithCapacity:1];
                for (ModelOne *models2 in thirdArr) {
                    if ([models2.pId isEqualToString:models1.id]) {
                        [arra addObject:models2];
                    }
                }
                for (ModelOne *models3 in arra) {
                    NSInteger pid2 = [models3.id integerValue];
                    NSInteger id2  = [models3.pId integerValue];
                    SinTreeCheckNode *n_1_1_1 = [SinTreeCheckNode nodeWithProperties:pid2 andText:models3.name superId:id2 superIds:id1];
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

    }];
    
    
}


- (NSMutableArray *)array {
    if (_array == nil) {
        self.array = [NSMutableArray arrayWithCapacity:1];
    }
    return _array;
}
@end
