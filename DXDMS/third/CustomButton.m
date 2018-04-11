//
//  CustomButton.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/17.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = YES;
    }
    return self;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGSize btnS = contentRect.size;
    CGFloat titleX = 0;
    CGFloat titleY = btnS.height * 0.65;
    CGFloat titleW = btnS.width;
    CGFloat titleH = btnS.height * 0.3;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGSize btnS = contentRect.size;
    CGFloat imageX = btnS.width * 0.35;
    CGFloat imageY = btnS.height * 0.2;
    CGFloat imageW = btnS.width * 0.3;
    CGFloat imageH = btnS.height * 0.4;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    //在这里可以动态的调整自己的frame
    
    
    
}

@end

