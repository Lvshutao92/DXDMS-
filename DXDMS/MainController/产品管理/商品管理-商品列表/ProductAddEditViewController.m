//
//  ProductAddEditViewController.m
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/28.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "ProductAddEditViewController.h"

@interface ProductAddEditViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *scrollView;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    UITextField *text9;
    UITextField *text10;
    
    
    UIImageView *imgview;
    NSString *imgUrl;
}
@end

@implementation ProductAddEditViewController

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
    
    [self setUpScrollview];
    
    if ([self.navigationItem.title isEqualToString:@"编辑"]) {
        [self lodEditGetList];
    }
}



- (void)lodEditGetList{
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"product/productsku/get"),self.idstr];
    [Manager requestPOSTWithURLStr:str paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        text1.text = [diction objectForKey:@"fcno"];
        text2.text = [diction objectForKey:@"itemNo"];
        text3.text = [diction objectForKey:@"model"];
        text4.text = [NSString stringWithFormat:@"%@",[diction objectForKey:@"listPrice"]];
        text5.text = [diction objectForKey:@"skuName"];
        text6.text = [NSString stringWithFormat:@"%@",[diction objectForKey:@"packageLength"]];
        text7.text = [NSString stringWithFormat:@"%@",[diction objectForKey:@"packageWidth"]];
        text8.text = [NSString stringWithFormat:@"%@",[diction objectForKey:@"packageHeight"]];
        text9.text = [NSString stringWithFormat:@"%@",[diction objectForKey:@"weight"]];
        text10.text = [diction objectForKey:@"barcode"];
        imgUrl = [diction objectForKey:@"mainImgUrl"];
        [imgview sd_setImageWithURL:[NSURL URLWithString:NSString(imgUrl)]];
    } enError:^(NSError *error) {
    }];
}








- (void)save{
    if ([self.navigationItem.title isEqualToString:@"新增"]){
        [self saveAdd];
    }else{
        [self saveEdit];
    }
}

- (void)saveEdit{
    if (text10.text == nil) {
        text10.text = @"";
    }
    if (imgUrl == nil) {
        imgUrl = @"";
    }
    __weak typeof (self) weakSelf = self;
    if (text1.text.length != 0 && text6.text.length  != 0 &&
        text2.text.length != 0 && text7.text.length  != 0 &&
        text3.text.length != 0 && text8.text.length  != 0 &&
        text4.text.length != 0 && text9.text.length  != 0 &&
        text5.text.length != 0 ) {
        NSDictionary *dic = @{@"fcno":text1.text,
                              @"itemNo":text2.text,
                              @"model":text3.text,
                              @"listPrice":text4.text,
                              @"skuName":text5.text,
                              @"packageLength":text6.text,
                              @"packageWidth":text7.text,
                              @"packageHeight":text8.text,
                              @"weight":text9.text,
                              @"barcode":text10.text,
                              
                              @"mainImgUrl":imgUrl,
                              };
        NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"product/productsku/update"),self.idstr];
        [Manager requestPOSTWithURLStr:str paramDic:dic token:nil finish:^(id responseObject) {
            NSDictionary *diction = [Manager returndictiondata:responseObject];
            //NSLog(@"******%@",diction);
            if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSDictionary *dict = [[NSDictionary alloc]init];
                    NSNotification *notification =[NSNotification notificationWithName:@"productsku" object:nil userInfo:dict];
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
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有字段不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}






- (void)saveAdd{
    __weak typeof (self) weakSelf = self;
    if (text10.text == nil) {
        text10.text = @"";
    }
    if (imgUrl == nil) {
        imgUrl = @"";
    }
    if (text1.text.length != 0 && text6.text.length  != 0 &&
        text2.text.length != 0 && text7.text.length  != 0 &&
        text3.text.length != 0 && text8.text.length  != 0 &&
        text4.text.length != 0 && text9.text.length  != 0 &&
        text5.text.length != 0 ) {
        NSDictionary *dic = @{@"fcno":text1.text,
                              @"itemNo":text2.text,
                              @"model":text3.text,
                              @"listPrice":text4.text,
                              @"skuName":text5.text,
                              @"packageLength":text6.text,
                              @"packageWidth":text7.text,
                              @"packageHeight":text8.text,
                              @"weight":text9.text,
                              @"barcode":text10.text,
                              
                              @"mainImgUrl":imgUrl,
                              };
        [Manager requestPOSTWithURLStr:KURLNSString(@"product/productsku/add") paramDic:dic token:nil finish:^(id responseObject) {
            NSDictionary *diction = [Manager returndictiondata:responseObject];
            //NSLog(@"******%@",diction);
            if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSDictionary *dict = [[NSDictionary alloc]init];
                    NSNotification *notification =[NSNotification notificationWithName:@"productsku" object:nil userInfo:dict];
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
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有字段不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}




















- (void)clicktapimg:(UITapGestureRecognizer *)gesture{
    [self selectedImage];
}

- (void)selectedImage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请选择图片获取路径" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickerPictureFromAlbum];
    }];
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pictureFromCamera];
    }];
    UIAlertAction *actionC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionA setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [actionB setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [actionC setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [alert addAction:actionA];
    [alert addAction:actionB];
    [alert addAction:actionC];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
//从手机相册选取图片功能
- (void)pickerPictureFromAlbum {
    //1.创建图片选择器对象
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepicker.allowsEditing = YES;
    imagepicker.delegate = self;
    [self presentViewController:imagepicker animated:YES completion:nil];
}
//拍照--照相机是否可用
- (void)pictureFromCamera {
    //照相机是否可用
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (!isCamera) {
        //提示框
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"摄像头不可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;//如果不存在摄像头，直接返回即可，不需要做调用相机拍照的操作；
    }
    //创建图片选择器对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //设置图片选择器选择图片途径
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//从照相机拍照选取
    //设置拍照时下方工具栏显示样式
    imagePicker.allowsEditing = YES;
    //设置代理对象
    imagePicker.delegate = self;
    //最后模态退出照相机即可
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerControllerDelegate
//当得到选中的图片或视频时触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imagesave = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageOrientation imageOrientation = imagesave.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(imagesave.size);
        [imagesave drawInRect:CGRectMake(0, 0, imagesave.size.width, imagesave.size.height)];
        imagesave = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    imgview.image = imagesave;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self imgurl:imagesave];
}
- (void)imgurl:(UIImage *)img{
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[Manager redingwenjianming:@"token.text"] forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:[Manager redingwenjianming:@"companyID.text"] forHTTPHeaderField:@"companyId"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];
    CGSize size = img.size;
    size.height = size.height/5;
    size.width  = size.width/5;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [manager POST:KURLNSString(@"base/file/upload?path=product/sku") parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData * data   =  UIImagePNGRepresentation(scaledImage);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            imgUrl = [diction objectForKey:@"message"];
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













- (void)setUpScrollview{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(0, 1250);
    scrollView.userInteractionEnabled = YES;
    [self.view addSubview:scrollView];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
    lab1.text = @"FCNO:";
    [scrollView addSubview:lab1];
    text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入FCNO";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, SCREEN_WIDTH-20, 30)];
    lab2.text = @"ITEMNO:";
    [scrollView addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"请输入ITEMNO";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH-20, 30)];
    lab3.text = @"MODEL:";
    [scrollView addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 250, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"请输入MODEL";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, 30)];
    lab4.text = @"官方价:";
    [scrollView addSubview:lab4];
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 350, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.placeholder = @"请输入官方价";
    text4.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 410, SCREEN_WIDTH-20, 30)];
    lab5.text = @"产品名称:";
    [scrollView addSubview:lab5];
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(10, 450, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.placeholder = @"请输入产品名称";
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text5];
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 510, SCREEN_WIDTH-20, 30)];
    lab6.text = @"长度（CM）:";
    [scrollView addSubview:lab6];
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(10, 550, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.placeholder = @"请输入长度";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text6];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 610, SCREEN_WIDTH-20, 30)];
    lab7.text = @"宽度（CM）:";
    [scrollView addSubview:lab7];
    text7 = [[UITextField alloc]initWithFrame:CGRectMake(10, 650, SCREEN_WIDTH-20, 40)];
    text7.delegate = self;
    text7.placeholder = @"请输入宽度";
    text7.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text7];
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 710, SCREEN_WIDTH-20, 30)];
    lab8.text = @"高度（CM）:";
    [scrollView addSubview:lab8];
    text8 = [[UITextField alloc]initWithFrame:CGRectMake(10, 750, SCREEN_WIDTH-20, 40)];
    text8.delegate = self;
    text8.placeholder = @"请输入高度";
    text8.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text8];
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 810, SCREEN_WIDTH-20, 30)];
    lab9.text = @"重量(KG):";
    [scrollView addSubview:lab9];
    text9 = [[UITextField alloc]initWithFrame:CGRectMake(10, 850, SCREEN_WIDTH-20, 40)];
    text9.delegate = self;
    text9.placeholder = @"请输入重量";
    text9.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text9];
    
    text6.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    text7.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    text8.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    text9.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    
    
    UILabel *lab10 = [[UILabel alloc]initWithFrame:CGRectMake(10, 910, SCREEN_WIDTH-20, 30)];
    lab10.text = @"产品条码:";
    [scrollView addSubview:lab10];
    text10 = [[UITextField alloc]initWithFrame:CGRectMake(10, 950, SCREEN_WIDTH-20, 40)];
    text10.delegate = self;
    text10.placeholder = @"请输入产品条码";
    text10.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:text10];
    
    UILabel *lab11 = [[UILabel alloc]initWithFrame:CGRectMake(10, 1010, SCREEN_WIDTH-20, 30)];
    lab11.text = @"请上传产品主图:";
    [scrollView addSubview:lab11];
    
    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 1050, 120, 120)];
    imgview.contentMode = UIViewContentModeScaleAspectFit;
    imgview.userInteractionEnabled = YES;
    imgview.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [scrollView addSubview:imgview];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapimg:)];
    [imgview addGestureRecognizer:tap];
}

@end
