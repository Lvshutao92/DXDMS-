//
//  ModelOne.h
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/14.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelTwo.h"

@interface ModelOne : NSObject
@property(nonatomic,strong)NSString *companyCount;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *expireTime;
@property(nonatomic,strong)NSString *groupCode;
@property(nonatomic,strong)NSString *groupName;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *userStatus;
@property(nonatomic,strong)NSString *useStatus;
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSString *value;

@property(nonatomic,strong)NSString *companyCode;
@property(nonatomic,strong)NSString *companyName;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *groupId;
@property(nonatomic,strong)NSString *shortName;
@property(nonatomic,strong)NSString *status;

@property(nonatomic,strong)NSString *resourceCode;
@property(nonatomic,strong)NSString *resourceName;
@property(nonatomic,strong)NSString *level;
@property(nonatomic,strong)NSString *parentId;

@property(nonatomic,strong)NSString *roleName;

@property(nonatomic,strong)NSString *mobilePhone;
@property(nonatomic,strong)NSString *passTime;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *salt;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userType;

@property(nonatomic,strong)NSString *pId;
@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *checked;



@property(nonatomic,strong)NSDictionary *groupBase;
@property(nonatomic,strong)ModelTwo *groupBaseModel;


@property(nonatomic,strong)NSArray *groupCompanys;
@property(nonatomic,strong)NSArray *systemRoleList;

@property(nonatomic,strong)NSString *skuName;
@property(nonatomic,strong)NSString *itemNo;
@property(nonatomic,strong)NSString *listPrice;
@property(nonatomic,strong)NSString *model;
@property(nonatomic,strong)NSString *fcno;
@property(nonatomic,strong)NSString *lastUpdateTime;
@property(nonatomic,strong)NSString *mainImgUrl;

@property(nonatomic,strong)NSString *packageLength;
@property(nonatomic,strong)NSString *packageWidth;
@property(nonatomic,strong)NSString *packageHeight;
@property(nonatomic,strong)NSString *weight;
@property(nonatomic,strong)NSString *barcode;


@property(nonatomic,strong)NSString *seriesName;
@property(nonatomic,strong)NSString *typeName;


@property(nonatomic,strong)NSDictionary *productSeries;
@property(nonatomic,strong)ModelTwo *productSeriesModel;

@property(nonatomic,strong)NSDictionary *productType;
@property(nonatomic,strong)ModelTwo *productTypeModel;







@property(nonatomic,strong)NSString *partnerName;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *district;
@property(nonatomic,strong)NSString *shopName;
@property(nonatomic,strong)NSString *shopAddr;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *qq;
@property(nonatomic,strong)NSString *addr;
@property(nonatomic,strong)NSString *color;



@property(nonatomic,strong)NSString *companyId;
@property(nonatomic,strong)NSString *invoiceAddr;
@property(nonatomic,strong)NSString *invoiceBankName;
@property(nonatomic,strong)NSString *invoiceBankNo;
@property(nonatomic,strong)NSString *invoiceCode;
@property(nonatomic,strong)NSString *invoicePhone;
@property(nonatomic,strong)NSString *invoiceTitle;
@property(nonatomic,strong)NSString *invoiceType;


@property(nonatomic,strong)NSString *partnerInfoId;



@property(nonatomic,strong)NSString *paymentAccount;
@property(nonatomic,strong)NSString *paymentNo;
@property(nonatomic,strong)NSString *paymentType;
@property(nonatomic,strong)NSString *totalBalance;
@property(nonatomic,strong)NSString *totalFee;


@property(nonatomic,strong)NSString *likeRemark;

@property(nonatomic,strong)NSString *label;
@property(nonatomic,strong)NSArray *children;
@property(nonatomic,strong)NSString *zip;

@property(nonatomic,strong)NSString *paymentDate;
@property(nonatomic,strong)NSString *paymentImg;
@property(nonatomic,strong)NSString *paymentNote;
@property(nonatomic,strong)NSString *paymentPerson;
@property(nonatomic,strong)NSString *receiveAccount;
@property(nonatomic,strong)NSString *receiveDate;
@property(nonatomic,strong)NSString *receiveFee;
@property(nonatomic,strong)NSString *receiveImg;
@property(nonatomic,strong)NSString *receiveNo;
@property(nonatomic,strong)NSString *receiveNote;
@property(nonatomic,strong)NSString *receivePerson;
@property(nonatomic,strong)NSString *receiveType;
@property(nonatomic,strong)NSString *rechargeNo;
@property(nonatomic,strong)NSString *rechargeType;
@property(nonatomic,strong)NSString *transNo;
@property(nonatomic,strong)NSString *partnerId;

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;
@end
