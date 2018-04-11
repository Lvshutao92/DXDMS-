//
//  CZLB_add_edit_ViewController.m
//  DXDMS
//
//  Created by 吕书涛 on 2018/4/4.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "CZLB_add_edit_ViewController.h"

@interface CZLB_add_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
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
    UIImageView *img;
    NSString *imgURL;
    
    
    NSString *str1;
    NSString *str2;
    NSString *str3;
    NSString *str4;
    
    UIView *bgview;
    
    UIScrollView *scrollview;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UITextField *textfield;
@end

@implementation CZLB_add_edit_ViewController

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
    scrollview.contentSize = CGSizeMake(0, 1300);
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
    NSString *str = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnerrecharge/get"),self.idstr];
    [Manager requestPOSTWithURLStr:str paramDic:nil token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        text2.text = [diction objectForKey:@"paymentAccount"];
        text10.text = [diction objectForKey:@"paymentNo"];
        text3.text = [diction objectForKey:@"paymentNote"];
        text5.text = [diction objectForKey:@"receiveAccount"];
        text6.text = [diction objectForKey:@"receiveNo"];
        text9.text = [NSString stringWithFormat:@"%@",[diction objectForKey:@"totalFee"]];

        
        str1 = [NSString stringWithFormat:@"%@",[diction objectForKey:@"partnerId"]];
        for (ModelOne *model in self.arr1) {
            if ([model.id isEqualToString:str1]) {
                text1.text = model.partnerName;
            }
        }
        
        
        str2 = [diction objectForKey:@"paymentType"];
        for (ModelOne *kehuModel in self.arr2) {
            if ([kehuModel.key isEqualToString:str2]) {
                text4.text = kehuModel.value;
            }
        }
        
        
        str3 = [diction objectForKey:@"receiveType"];
        for (ModelOne *kehuModel in self.arr2) {
            if ([kehuModel.key isEqualToString:str3]) {
                text7.text = kehuModel.value;
            }
        }
        
        
        str4 = [diction objectForKey:@"rechargeType"];
        for (ModelOne *kehuModel in self.arr3) {
            if ([kehuModel.key isEqualToString:str4]) {
                text8.text = kehuModel.value;
            }
        }
        
        
        imgURL = [diction objectForKey:@"paymentImg"];
        [img sd_setImageWithURL:[NSURL URLWithString:NSString(imgURL)]];
    } enError:^(NSError *error) {
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray == self.arr1) {
        return self.arr1.count;
    }
    if (self.dataArray == self.arr2) {
        return self.arr2.count;
    }
    return self.arr3.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    edit.arr2 = self.statusArray;
//    edit.arr3 = self.czTypeArray;
    if (self.dataArray == self.arr1){
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ModelOne *model = [self.arr1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.partnerName;
        return cell;
    }
    if (self.dataArray == self.arr2){
        static NSString *identifierCell = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ModelOne *model = [self.arr2 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.value;
        return cell;
    }
    static NSString *identifierCell = @"cel3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ModelOne *model = [self.arr3 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.value;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray == self.arr1){
         ModelOne *model = [self.arr1 objectAtIndex:indexPath.row];
         text1.text = model.partnerName;
         str1=model.id;
    }
    if (self.dataArray == self.arr2){
         ModelOne *model = [self.arr2 objectAtIndex:indexPath.row];
        if (self.textfield==text4) {
           text4.text = model.value;
           str2=model.key;
        }
        if (self.textfield==text7) {
            text7.text = model.value;
            str3=model.key;
        }
    }
    if (self.dataArray == self.arr3){
         ModelOne *model = [self.arr3 objectAtIndex:indexPath.row];
         text8.text = model.value;
        str4=model.key;
    }
    bgview.hidden = YES;
}









-(void)save{
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (str1.length != 0 && text2.text.length != 0 &&
        str2.length != 0 && text5.text.length != 0 &&
        text6.text.length != 0 && str3.length != 0 &&
        str4.length != 0 && text9.text.length != 0 &&
        imgURL.length != 0 && text10.text.length != 0) {
       
        if ([self.navigationItem.title isEqualToString:@"新增"]) {
            [self lodadd];
        }else{
            [self lodedit];
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"除付款附言，其他信息均不能为空不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}




- (void)lodadd{
//    NSLog(@"%@--%@---%@----%@----%@-----%@-----%@-----%@-----%@-----%@",text2.text,text3.text,text5.text,text6.text,text9.text,str1,str2,str3,str4,imgURL);
    __weak typeof (self) weakSelf = self;
    NSDictionary *dic = @{@"paymentAccount":text2.text,
                          @"paymentNote":text3.text,
                          @"receiveAccount":text5.text,
                          @"receiveNo":text6.text,
                          @"totalFee":text9.text,
                          @"paymentNo":text10.text,
                          @"paymentImg":imgURL,
                          @"partnerId":str1,
                          @"paymentType":str2,
                          @"receiveType":str3,
                          @"rechargeType":str4,
                          };
    //NSLog(@"******%@",dic);
    [Manager requestPOSTWithURLStr:KURLNSString(@"partner/partnerrecharge/add") paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"czlb" object:nil userInfo:dict];
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
    NSDictionary *dic = @{@"paymentAccount":text2.text,
                          @"paymentNote":text3.text,
                          @"receiveAccount":text5.text,
                          @"receiveNo":text6.text,
                          @"totalFee":text9.text,
                          @"paymentNo":text10.text,
                          @"paymentImg":imgURL,
                          @"partnerId":str1,
                          @"paymentType":str2,
                          @"receiveType":str3,
                          @"rechargeType":str4,
                          };
    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KURLNSString(@"partner/partnerrecharge/update"),self.idstr];
    [Manager requestPOSTWithURLStr:urlstr paramDic:dic token:nil finish:^(id responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        //NSLog(@"******%@",diction);
        if ([[NSString stringWithFormat:@"%@",[diction objectForKey:@"code"]] isEqualToString:@"200"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSDictionary *dict = [[NSDictionary alloc]init];
                NSNotification *notification =[NSNotification notificationWithName:@"czlb" object:nil userInfo:dict];
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


















- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.textfield = textField;
    
    if ([textField isEqual:text1]) {
        [text5 resignFirstResponder];
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        [text6 resignFirstResponder];
        [text9 resignFirstResponder];
        [text10 resignFirstResponder];
        self.dataArray = self.arr1;
         bgview.hidden = NO;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text4]) {
        [text5 resignFirstResponder];
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        [text6 resignFirstResponder];
        [text9 resignFirstResponder];
         [text10 resignFirstResponder];
        self.dataArray = self.arr2;
        bgview.hidden = NO;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text7]) {
        [text5 resignFirstResponder];
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        [text6 resignFirstResponder];
        [text9 resignFirstResponder];
         [text10 resignFirstResponder];
        self.dataArray = self.arr2;
        bgview.hidden = NO;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text8]) {
        [text5 resignFirstResponder];
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        [text6 resignFirstResponder];
        [text9 resignFirstResponder];
         [text10 resignFirstResponder];
        self.dataArray = self.arr3;
        bgview.hidden = NO;
        [self.tableview reloadData];
        return NO;
    }
    return YES;
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
    lab2.text = @"付款账户:";
    [scrollview addSubview:lab2];
    text2 = [[UITextField alloc]initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.placeholder = @"付款账户";
    text2.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text2];
    
    
    UILabel *lab11 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, SCREEN_WIDTH-20, 30)];
    lab11.text = @"付款账号:";
    [scrollview addSubview:lab11];
    text10 = [[UITextField alloc]initWithFrame:CGRectMake(10, 250, SCREEN_WIDTH-20, 40)];
    text10.delegate = self;
    text10.placeholder = @"付款账号";
    text10.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text10];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 310, SCREEN_WIDTH-20, 30)];
    lab3.text = @"付款附言:";
    [scrollview addSubview:lab3];
    text3 = [[UITextField alloc]initWithFrame:CGRectMake(10, 350, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.placeholder = @"付款附言";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 410, SCREEN_WIDTH-20, 30)];
    lab4.text = @"付款方式:";
    [scrollview addSubview:lab4];
    text4 = [[UITextField alloc]initWithFrame:CGRectMake(10, 450, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.placeholder = @"付款方式";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 510, SCREEN_WIDTH-20, 30)];
    lab5.text = @"收款账户:";
    [scrollview addSubview:lab5];
    text5 = [[UITextField alloc]initWithFrame:CGRectMake(10, 550, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.placeholder = @"收款账户";
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text5];
    
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 610, SCREEN_WIDTH-20, 30)];
    lab6.text = @"收款账号:";
    [scrollview addSubview:lab6];
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(10,650, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.placeholder = @"收款账号";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text6];
    
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 710, SCREEN_WIDTH-20, 30)];
    lab7.text = @"收款方式:";
    [scrollview addSubview:lab7];
    text7 = [[UITextField alloc]initWithFrame:CGRectMake(10, 750, SCREEN_WIDTH-20, 40)];
    text7.delegate = self;
    text7.placeholder = @"收款方式";
    text7.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text7];
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 810, SCREEN_WIDTH-20, 30)];
    lab8.text = @"充值类型:";
    [scrollview addSubview:lab8];
    text8 = [[UITextField alloc]initWithFrame:CGRectMake(10, 850, SCREEN_WIDTH-20, 40)];
    text8.delegate = self;
    text8.placeholder = @"充值类型";
    text8.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text8];
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 910, SCREEN_WIDTH-20, 30)];
    lab9.text = @"充值金额:";
    [scrollview addSubview:lab9];
    text9 = [[UITextField alloc]initWithFrame:CGRectMake(10, 950, SCREEN_WIDTH-20, 40)];
    text9.delegate = self;
    text9.placeholder = @"充值金额";
    text9.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text9];
    
    UILabel *lab10 = [[UILabel alloc]initWithFrame:CGRectMake(10, 1010, SCREEN_WIDTH-20, 30)];
    lab10.text = @"付款凭证:";
    [scrollview addSubview:lab10];
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(130, 1020, 120, 120)];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.userInteractionEnabled = YES;
    img.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    [scrollview addSubview:img];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapimg:)];
    [img addGestureRecognizer:tap];
    
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
    img.image = imagesave;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    imgURL = @"";
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
            imgURL = [diction objectForKey:@"message"];
            //NSLog(@"----------%@",imgURL);
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



- (NSMutableArray *)arr3{
    if (_arr3 == nil) {
        self.arr3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr3;
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
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
