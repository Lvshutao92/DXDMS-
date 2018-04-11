//
//  ShoppingCartCell.h
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/27.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *seleBtn;

@property (weak, nonatomic) IBOutlet UIImageView *ing;

@property (weak, nonatomic) IBOutlet UILabel *lab1;

@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;




@property (weak, nonatomic) IBOutlet UILabel *numlab;

@property (weak, nonatomic) IBOutlet UIButton *curtBtn;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
