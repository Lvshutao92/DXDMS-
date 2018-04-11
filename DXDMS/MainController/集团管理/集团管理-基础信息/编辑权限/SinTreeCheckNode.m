//
//  TreeCheckNode.m
//  GDDJ
//
//  Created by RobinTang on 12-12-19.
//  Copyright (c) 2012年 com.sin All rights reserved.
//

#import "SinTreeCheckNode.h"

@implementation SinTreeCheckNode

@synthesize cid, text, checked, children, expanded, level, superID, superIDS;


-(id)init{
    self = [super init];
    if(self){
        self.cid = 0;
        self.text = nil;
        self.level = 0;
        self.checked = NO;
        self.expanded = NO;
        self.children = nil;
        self.superID = 0;
        self.superIDS = 0;
    }
    return self;
}


+(id)nodeWithProperties:(NSInteger)cid andText:(NSString *)andText superId:(NSInteger)superID superIds:(NSInteger)superIDS{
     //NSLog(@"cid---------%ld",cid);
    if ([[Manager sharedManager].isOrNoRole isEqualToString:@"role"]) {
        NSString *string = [NSString stringWithFormat:@"%ld",(long)cid];
        BOOL isno = YES;
        if ([[Manager sharedManager].roleQXArray containsObject:string]) {
            isno = NO;
        }else{
            isno = YES;
        }
        //NSLog(@"isno--======---------%ld",isno);
        return [SinTreeCheckNode nodeWithProperties:cid andText:andText andLevel:0 andChecked:isno andExpanded:NO andChildren:nil andSuperId:superID superIds:superIDS];
    }
    NSString *string = [NSString stringWithFormat:@"%ld",(long)cid];
    BOOL isno = YES;
    for (NSString *str in [Manager sharedManager].qxArray) {
        //NSLog(@"str========%@",str);
        if ([str isEqualToString:string]) {
            isno = NO;
            break;
        }
    }
//    NSLog(@"isno--======---------%ld",superID);
    return [SinTreeCheckNode nodeWithProperties:cid andText:andText andLevel:0 andChecked:isno andExpanded:NO andChildren:nil andSuperId:superID superIds:superIDS];
}


+(id)nodeWithProperties:(NSInteger)cid andText:(NSString *)andText andLevel:(NSInteger)andLevel andChecked:(BOOL)andChecked andExpanded:(BOOL)andExpanded andChildren:(NSArray*)andChildren andSuperId:(NSInteger )superID superIds:(NSInteger)superIDS{
    
    SinTreeCheckNode *node = [[SinTreeCheckNode alloc] init];
    node.cid = cid;
    node.text = andText;
    node.level = andLevel;
    node.checked = andChecked;
    node.expanded = andExpanded;
    node.superID = superID;
    node.superIDS = superIDS;
    if(andChildren!=nil){
        for (SinTreeCheckNode *ch in andChildren) {
            [node addChild:ch];
        }
    }
    return node;
}


-(NSString *)description{
    NSMutableString *s = [[NSMutableString alloc]initWithCapacity:0];
    [s appendFormat:@"cid:%ld text:%@ level:%ld expanded:%@ superID:%ld superIDS:%ld", (long)self.cid, self.text, (long)self.level, self.expanded?@"YES":@"NO", (long)self.superID, (long)self.superIDS];
    if (self.hasChilren) {
        [s appendString:@" children:["];
        BOOL notfirst = NO;
        for (SinTreeCheckNode *ch in children) {
            if (notfirst) {
                [s appendString:@","];
            }
            [s appendFormat:@"(%@)", [ch description]];
            notfirst = YES;
        }
        [s appendString:@"]"];
    }
    return s;
}

-(BOOL)isContainer{
    return children != nil;
}

-(BOOL)hasChilren{
    return children!=nil && [children count]>0;
}
-(void)changeLevel:(NSInteger)newlevel{
    if(newlevel != level){
        self.level = newlevel;
        if([self hasChilren]){
            for (SinTreeCheckNode *ch in children) {
                [ch changeLevel:level+1];
            }
        }
    }
}
-(void)changeCheckStatus:(BOOL)checkStatus{
    if ([[Manager sharedManager].isOrNoRole isEqualToString:@"role"])
    {
        self.checked = checkStatus;
       
        if (self.checked == NO) {
            if (![[Manager sharedManager].roleQXArray containsObject:[NSString stringWithFormat:@"%ld",(long)self.cid]]) {
                [[Manager sharedManager].roleQXArray addObject:[NSString stringWithFormat:@"%ld",(long)self.cid]];
            }
            if (![[Manager sharedManager].roleQXArray containsObject:[NSString stringWithFormat:@"%ld",(long)self.superID]]){
                [[Manager sharedManager].roleQXArray addObject:[NSString stringWithFormat:@"%ld",(long)self.superID]];
            }
            if (![[Manager sharedManager].roleQXArray containsObject:[NSString stringWithFormat:@"%ld",(long)self.superIDS]]){
                [[Manager sharedManager].roleQXArray addObject:[NSString stringWithFormat:@"%ld",(long)self.superIDS]];
            }
        }else{
            [[Manager sharedManager].roleQXArray removeObject:[NSString stringWithFormat:@"%ld",(long)self.cid]];
//            [[Manager sharedManager].roleQXArray removeObject:[NSString stringWithFormat:@"%ld",(long)self.superID]];
//            [[Manager sharedManager].roleQXArray removeObject:[NSString stringWithFormat:@"%ld",(long)self.superIDS]];
        }

        if([self hasChilren]){
            for (SinTreeCheckNode *ch in children) {
                [ch changeCheckStatus:checkStatus];
            }
        }
    }
    else
    {
        self.checked = checkStatus;
        if (self.checked == NO) {
            if (![[Manager sharedManager].qxArray containsObject:[NSString stringWithFormat:@"%ld",(long)self.cid]]) {
                [[Manager sharedManager].qxArray addObject:[NSString stringWithFormat:@"%ld",(long)self.cid]];
            }
            if (![[Manager sharedManager].qxArray containsObject:[NSString stringWithFormat:@"%ld",(long)self.superID]]){
                [[Manager sharedManager].qxArray addObject:[NSString stringWithFormat:@"%ld",(long)self.superID]];
            }
            if (![[Manager sharedManager].qxArray containsObject:[NSString stringWithFormat:@"%ld",(long)self.superIDS]]){
                [[Manager sharedManager].qxArray addObject:[NSString stringWithFormat:@"%ld",(long)self.superIDS]];
            }
        }else{
            [[Manager sharedManager].qxArray removeObject:[NSString stringWithFormat:@"%ld",(long)self.cid]];
//            [[Manager sharedManager].qxArray removeObject:[NSString stringWithFormat:@"%ld",(long)self.superID]];
//            [[Manager sharedManager].qxArray removeObject:[NSString stringWithFormat:@"%ld",(long)self.superIDS]];
        }
        if([self hasChilren]){
            for (SinTreeCheckNode *ch in children) {
                [ch changeCheckStatus:checkStatus];
            }
        }
        
    }
}
-(void)addChild:(SinTreeCheckNode*)child{
    if(self.children == nil){
        self.children = [NSMutableArray arrayWithCapacity:0];
    }
    [self.children addObject:child];
    [child changeLevel:level+1];
}
-(BOOL)ergodicNode:(BLOCK_ON_SINTREECHECKNODE)ope{
    if(ope(self)){  // 如果几点自身操作成功则遍历孩子
        if(self.hasChilren){
            for (SinTreeCheckNode *ch in self.children) {
                
                [ch ergodicNode:ope];
            }
        }
        return YES;
    }
    // 否则的话就不遍历孩子了
    return NO;
}
@end
