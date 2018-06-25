//
//  WebViewController.m
//  DXRacer
//
//  Created by ilovedxracer on 2017/7/10.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
{
    UIView *views;
}
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation WebViewController


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}




- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-10, self.view.frame.size.height-5)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    // 避免WebView最下方出现黑线
     self.webView.opaque = NO;
     self.webView.backgroundColor = [UIColor clearColor];
    // 去掉webView的滚动条
    for (UIView *subView in [self.webView subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]])
        {
            // 不显示竖直的滚动条
            [(UIScrollView *)subView setShowsVerticalScrollIndicator:NO];
        }
    }
    NSString *header = @"<head><style>img{min-width:375px;max-width:100%!important;display:block;margin:0 auto}</style></head>";
    NSString *str = [NSString stringWithFormat:@"%@%@",header,self.webStr];
    [self.webView loadHTMLString:str baseURL:nil];
    [self.view addSubview:self.webView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, SCREEN_HEIGHT-60, 40, 40);
    LRViewBorderRadius(btn, 20, 0, [UIColor clearColor]);
    btn.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view bringSubviewToFront:views];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    webView.scalesPageToFit = YES;
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'"];

//    if (self.str != nil){
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'"];
        [webView stringByEvaluatingJavaScriptFromString:
         @"var script = document.createElement('script');"
         "script.type = 'text/javascript';"
         "script.text = \"function ResizeImages() { "
         "var myimg,oldwidth;"
         "var maxwidth=600"
         "for(i=0;i <document.images.length;i++){"
         "myimg = document.images[i];"
         "myimg.setAttribute('style','display:block;margin:0 auto;width:100%;')"
         "if(myimg.width > maxwidth){"
         "oldwidth = myimg.width;"
         "myimg.width = maxwidth;"
         "myimg.height = myimg.height * (maxwidth/oldwidth);"
         "}"
         "}"
         "}\";"
         "document.getElementsByTagName('head')[0].appendChild(script);"];
        [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
//    }

}
- (void) webViewDidStartLoad:(UIWebView *)webView {
    UIView *v  = [[UIView alloc]init];
    v.backgroundColor = [UIColor whiteColor];
    UILabel *titLab = [[UILabel alloc]init];
    titLab.backgroundColor = [UIColor whiteColor];
    titLab.text = self.titles;
    titLab.numberOfLines = 0;
    titLab.font = [UIFont systemFontOfSize:22];
    [Manager changeLineSpaceForLabel:titLab WithSpace:8];
    CGFloat height = [self getHeightLineWithString:self.titles withWidth:SCREEN_WIDTH-20 withFont:[UIFont systemFontOfSize:22]];
    
    titLab.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, height);
    v.frame = CGRectMake(0, 10, SCREEN_WIDTH-20, height+20);
    UIView *vv  = [[UIView alloc]initWithFrame:CGRectMake(0, height+19, SCREEN_WIDTH-20, 1)];
    vv.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [v addSubview:vv];
    [v addSubview:titLab];
    [_webView.scrollView addSubview:v];
    _webView.scrollView.subviews[0].frame = CGRectMake(5, height+35, SCREEN_WIDTH-10, 0);
}
#pragma mark - 根据字符串计算label高度
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font {
    //1.1最大允许绘制的文本范围
    CGSize size = CGSizeMake(width, 2000);
    //1.2配置计算时的行截取方法,和contentLabel对应
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:8];
    //1.3配置计算时的字体的大小
    //1.4配置属性字典
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
    //2.计算
    //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
    CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}





@end
