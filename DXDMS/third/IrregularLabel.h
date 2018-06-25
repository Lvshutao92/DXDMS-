//
//  IrregularLabel.h
//  DXDMS
//
//  Created by ilovedxracer on 2018/4/26.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IrregularLabel : UILabel
/** 遮罩 */
@property (nonatomic, strong) CAShapeLayer *maskLayer;
/** 路径 */
@property (nonatomic, strong) UIBezierPath *borderPath;
@end
