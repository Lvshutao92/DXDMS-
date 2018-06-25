//
//  AnnouncementViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/18.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "AnnouncementViewController.h"

@interface AnnouncementViewController () <UITextFieldDelegate,UIWebViewDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

{
    NSString *_htmlString;//保存输出的富文本
    NSMutableArray *_imageArr;//保存添加的图片
    NSMutableArray *_imageIndexArr;
    UITextField *text1;
}

@property (nonatomic,strong)UIWebView *webView;

@end

@implementation AnnouncementViewController

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(0, 7, 30, 30);
    [bt setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bt];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = bar;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveText)];
    self.navigationItem.rightBarButtonItem = save;
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"] || [[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone Simulator"]) {
        height = 88;
    }else{
        height = 64;
    }
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20+height, 50, 20)];
    lab1.text = @"标题";
    [self.view addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(60, 10+height, SCREEN_WIDTH-70, 40)];
    text1.delegate = self;
    text1.borderStyle = UITextBorderStyleRoundedRect;
    text1.placeholder = @"请输入标题";
    [self.view addSubview:text1];
    
    if (self.titles != nil) {
        text1.text = self.titles;
    }
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 55+height, 50, 20)];
    lab2.text = @"内容:";
    [self.view addSubview:lab2];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 75+height, SCREEN_WIDTH, SCREEN_HEIGHT-75-height)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *indexFileURL = [bundle URLForResource:@"richTextEditor" withExtension:@"html"];
    
    [self.webView setKeyboardDisplayRequiresUserAction:NO];
    [self.webView loadRequest:[NSURLRequest requestWithURL:indexFileURL]];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor orangeColor];
    btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 460, 80, 35);
    btn.layer.cornerRadius = 5;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"添加图片" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (self.inHtmlString.length > 0)
    {
        NSString *place = [NSString stringWithFormat:@"window.placeHTMLToEditor('%@')",self.inHtmlString];
        [webView stringByEvaluatingJavaScriptFromString:place];
    }
}
- (void)addImage
{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}



- (void)printHTML
{
    //NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('title-input').value"];
    NSString *html = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').innerHTML"];
    NSString *script = [self.webView stringByEvaluatingJavaScriptFromString:@"window.alertHtml()"];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
//    NSLog(@"-----------------Title: %@", title);
//    NSLog(@"+++++++++++++++++Inner HTML: %@", html);
    if (html.length == 0 || text1.text.length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入标题及内容" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"好", nil];
        [alert show];
    }
    else
    {
//        _htmlString = html;
//        //对输出的富文本进行处理后上传
//        NSLog(@"%@---%@-----%@",text1.text,html,[self changeString:_htmlString]);
        [self lodsaveTitle:text1.text andContent:html];
    }
}

- (void)lodsaveTitle:(NSString *)title andContent:(NSString *)content{
    __weak typeof (self) weakSelf = self;
    NSDictionary *dic = @{@"title":title,
                          @"content":content,
                          @"receivier":@"",
                          };
    
    NSString *str = nil;
    if (self.titles != nil) {
        str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"announce/announceinfo/update"),self.idstr];
    }else{
        str = KURLNSString(@"announce/announceinfo/add");
    }
    //NSLog(@"*****++++++++++++*%@",str);
    [Manager requestPOSTWithURLStr:str paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发布成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"fabu" object:nil userInfo:dict];
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
    
}












#pragma mark - ImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDate *now = [NSDate date];
    NSString *imageName = [NSString stringWithFormat:@"iOS%@.jpg", [self stringFromDate:now]];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image;
    if ([mediaType isEqualToString:@"public.image"])
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        [imageData writeToFile:imagePath atomically:YES];
    }
    
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[Manager redingwenjianming:@"token.text"] forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:[Manager redingwenjianming:@"companyID.text"] forHTTPHeaderField:@"companyId"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];

//    NSLog(@"%f+++++++++++++%f",image.size.width,image.size.height);
    image = [weakSelf compressImage:image toTargetWidth:image.size.width];
    NSData*imageData =UIImageJPEGRepresentation(image,0.8);
    image = [UIImage imageWithData:imageData];
//    NSLog(@"%f------------%f",image.size.width,image.size.height);
    
    [manager POST:KURLNSString(@"base/file/upload?path=product/sku") parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * data   =  UIImagePNGRepresentation(image);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            NSString *url = NSString([diction objectForKey:@"message"]);
            
            
            //对应自己服务器的处理方法,
            NSString *script = [NSString stringWithFormat:@"window.insertImage('%@', '%@')", url, imagePath];
            NSDictionary *dic = @{@"url":url,@"image":image,@"name":imageName};
            [_imageArr addObject:dic];
            
            [self.webView stringByEvaluatingJavaScriptFromString:script];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[diction objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-----%@",error);
    }];
    
}
- (UIImage*)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    
    [sourceImage drawInRect:CGRectMake(0,0, targetWidth, targetHeight)];UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}






- (void)saveText
{
    [self printHTML];
}


#pragma mark - Method
-(NSString *)changeString:(NSString *)str
{
    
    NSMutableArray * marr = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@"\""]];
    
    for (int i = 0; i < marr.count; i++)
    {
        NSString * subStr = marr[i];
        if ([subStr hasPrefix:@"/var"] || [subStr hasPrefix:@" id="])
        {
            [marr removeObject:subStr];
            i --;
        }
    }
    NSString * newStr = [marr componentsJoinedByString:@"\""];
    return newStr;
    
}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}


@end
