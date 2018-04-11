//
//  FYLCityModel.m
//  QinYueHui
//
//  Created by FuYunLei on 2017/4/14.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "FYLCityModel.h"


@implementation FYLProvince

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"value",
             @"city" : @"children",
             @"code1" : @"key"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"city" : [FYLCity class]};
}

@end

@implementation FYLCity

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"value",
             @"town" : @"children",
             @"code2" : @"key"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"town" : [FYLTown class]};
}

@end

@implementation FYLTown

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name" : @"value",
             @"coder" : @"key"};
}

@end
