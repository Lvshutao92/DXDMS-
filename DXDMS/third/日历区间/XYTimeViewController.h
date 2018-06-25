//
//  XYTimeViewController.h
//  SuperPlatform
//
//  Created by kaifa on 2018/1/12.
//  Copyright © 2018年 kaifa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYTimeViewController : UIViewController

@property NSDate *startDate;
@property NSDate *endDate;

@property (copy)void (^selectTime)(NSDate *startDate, NSDate *endDate);
- (void)shuaxin:(BOOL)isdh;
@end
