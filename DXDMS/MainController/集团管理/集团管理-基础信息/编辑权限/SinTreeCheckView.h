//
//  SinTreeCheckView.h
//  SinTreeCheckDemo
//
//  Created by RobinTang on 12-12-19.
//  Copyright (c) 2012年 com.sin All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinTreeCheckNode.h"
@interface SinTreeCheckView : UITableView<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_cells;
    SinTreeCheckNode *_root;
}
- (void)setRootNode:(SinTreeCheckNode *)rootNode;
@end
