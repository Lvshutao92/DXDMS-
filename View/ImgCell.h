//
//  ImgCell.h
//  DXDMS
//
//  Created by 吕书涛 on 2018/4/9.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *labText;

@property (weak, nonatomic) IBOutlet UILabel *labNum;


@end
