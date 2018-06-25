//
//  OneCell.h
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/14.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lab1;

@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;

@property (weak, nonatomic) IBOutlet UILabel *lab4;

@property (weak, nonatomic) IBOutlet UILabel *lab5;

@property (weak, nonatomic) IBOutlet UILabel *lab6;

@property (weak, nonatomic) IBOutlet UIButton *editbtn;
@property (weak, nonatomic) IBOutlet UIButton *delebtn;
@property (weak, nonatomic) IBOutlet UIButton *quanxianBtn;


@property (weak, nonatomic) IBOutlet UISwitch *switchs;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *delebtnwidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab1Height;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deleEditJuLi;

@property (weak, nonatomic) IBOutlet UILabel *lab7;

@property (weak, nonatomic) IBOutlet UILabel *lab8;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab5height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab6height;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab6right;




@property (weak, nonatomic) IBOutlet UIButton *passwordBtn;


@property (weak, nonatomic) IBOutlet UILabel *lab9;


@property (weak, nonatomic) IBOutlet UILabel *line;

@end
