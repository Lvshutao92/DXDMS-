//
//  SinTreeCheckView.m
//  SinTreeCheckDemo
//
//  Created by RobinTang on 12-12-19.
//  Copyright (c) 2012年 com.sin All rights reserved.
//

#import "SinTreeCheckView.h"
#define CELL_H      55
#define CELL_IMG_W  30
#define CELL_IMG_H  30
#define CELL_EXP_W  20
#define CELL_EXP_H  20
#define CELL_LEV_W  20
#define RELEASE(_o) [_o release], _o = nil

static UIImage *_check_n;
static UIImage *_check_ed;
@interface TreeCheckCell : UITableViewCell
{
    SinTreeCheckView *_parent;
    SinTreeCheckNode *_node;
    UIButton *_btnCheck;
}
@property(nonatomic, retain)SinTreeCheckNode *node;
@end

@implementation TreeCheckCell

@synthesize node = _node;



-(id)initWithStyleAndParent:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andParentView:(SinTreeCheckView*)andParentView{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        if(_check_n==nil)
            _check_n = [UIImage imageNamed:@"sintreecheck_n"];
        
        if(_check_ed==nil)
            _check_ed = [UIImage imageNamed:@"sintreecheck_ed"];
        
        _parent = andParentView;
        _btnCheck = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCheck addTarget:_parent action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnCheck];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat sx = self.node.level*CELL_LEV_W;
    _btnCheck.frame = CGRectMake(sx, (h-CELL_IMG_H)/2, CELL_IMG_W, CELL_IMG_H);
    self.textLabel.frame = CGRectMake(sx+CELL_IMG_W, 0, w-sx-CELL_IMG_W-CELL_EXP_W, h);
    if(self.node.isContainer){
        self.textLabel.text = [NSString stringWithFormat:@"%@(%ld)", self.node.text, [self.node.children count]];
    }
    else{
        self.textLabel.text = self.node.text;
    }
    
    self.imageView.frame = CGRectMake(w-CELL_EXP_W, (h-CELL_EXP_H)/2, CELL_EXP_W, CELL_EXP_H);
    UIImage *img = _node.checked?_check_ed:_check_n;
    [_btnCheck setImage:img forState:UIControlStateNormal];
    
    [_btnCheck setTag:self.tag];
}

@end



@implementation SinTreeCheckView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setDelegate:self];
        [self setDataSource:self];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
    }
    return self;
}

- (void)setRootNode:(SinTreeCheckNode *)rootNode{
    
    _root = rootNode;
    [_cells removeAllObjects];
    if(_cells == nil)
        _cells = [[NSMutableArray alloc] initWithCapacity:0];
    [_cells addObject:_root];
    if(_root.expanded){
        [self expandNode:_root];
    }
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cells count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_H;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SinTreeCheckCellIdentifier";
	TreeCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[TreeCheckCell alloc] initWithStyleAndParent:UITableViewCellStyleSubtitle
                                     reuseIdentifier:CellIdentifier andParentView:self];
	}
    SinTreeCheckNode *node = [_cells objectAtIndex:indexPath.row];
//    NSLog(@"---%@",node);
    cell.node = node;
    cell.tag = indexPath.row;
    [cell setNeedsUpdateConstraints];
    return cell;
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SinTreeCheckNode *node = [_cells objectAtIndex:indexPath.row];
    if(node.children != nil && [node.children count]>0){
        if(!node.expanded){
            node.expanded = YES;
            [self expandNode:node];
        }
        else{
            if(node.hasChilren){
                node.expanded = NO;
                [self unexpandNode:node];
            }
        }
    }
    
    
}

- (void)expandNode:(SinTreeCheckNode*)node{
    NSInteger location = [_cells indexOfObject:node]+1;
    NSMutableArray *willExpand = [NSMutableArray array];
    for (SinTreeCheckNode* ch in node.children) {
        [willExpand addObject:[NSIndexPath indexPathForRow:location inSection:0]];
        [_cells insertObject:ch atIndex:location++];
    }
    [self insertRowsAtIndexPaths:willExpand withRowAnimation:UITableViewRowAnimationLeft];
    for (SinTreeCheckNode* ch in node.children) {
        if(ch.expanded && ch.hasChilren){
            [self expandNode:ch];
        }
    }
}

- (void)unexpandNode:(SinTreeCheckNode *)node{
    if(node.hasChilren){
        [self unexpandNodes:node.children];
    }
}

-(void)unexpandNodes:(NSArray*)nodes{
	for(SinTreeCheckNode *node in nodes ) {
		NSUInteger indexToRemove=[_cells indexOfObjectIdenticalTo:node];
		NSArray *willUnexpand=node.children;
		if(willUnexpand && [willUnexpand count]>0){
			[self unexpandNodes:willUnexpand];
		}
		
		if([_cells indexOfObjectIdenticalTo:node]!=NSNotFound) {
			[_cells removeObjectIdenticalTo:node];
			[self deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]]withRowAnimation:UITableViewRowAnimationRight];
		}
	}
}

-(void)checkAction:(id)sender {
    UIButton *btn = sender;
    SinTreeCheckNode *node = [_cells objectAtIndex:btn.tag];
    [node changeCheckStatus:!node.checked];
    
    [self reloadData];
}


@end
