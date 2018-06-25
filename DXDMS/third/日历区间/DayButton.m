//
//  Dayview.m
//  SuperPlatform
//
//  Created by kaifa on 2018/1/12.
//  Copyright © 2018年 kaifa. All rights reserved.
//

#import "DayButton.h"


@implementation DayButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor whiteColor];
        [self start];
    }
    return self;
}

- (void)awakeFromNib {
    if (self) {
        
        [self start];
        //self.backgroundColor = [UIColor whiteColor];
        
    }
    
}

- (void)start {
   self.backgroundColor = [UIColor whiteColor];
    
}

- (void)startButton {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ([[UIScreen mainScreen] bounds].size.width-40)/14, ([[UIScreen mainScreen] bounds].size.width-40)/7)];
    view.backgroundColor = [UIColor colorWithRed:45/255.0 green:174/255.0 blue:214/255.0 alpha:1];
    [self addSubview:view];
    
}

@end
