//
//  OneViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/2.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)JSContext *jsContext;
@end

@implementation OneViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    _webView.delegate=self;
   
    [self.view addSubview:_webView];
    
    
   
}

#pragma mark --webViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //网页加载之前会调用此方法
    
    //retrun YES 表示正常加载网页 返回NO 将停止网页加载z
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页调用此方法
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    _jsContext = [self.webView valueForKeyPath:@"cdn-hangzhou.goeasy.io/goeasy.js"];
    NSLog(@"-------%@",_jsContext);
    _jsContext[@""] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            
            NSString *str= [NSString stringWithFormat:@"%@",jsVal];
            NSLog(@"-------%@",str);
            
            
        }
    };
    
    
    //网页加载完成调用此方法
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //网页加载失败 调用此方法
}
















@end
