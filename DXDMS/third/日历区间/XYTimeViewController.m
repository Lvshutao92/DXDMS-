//
//  XYTimeViewController.m
//  SuperPlatform
//
//  Created by kaifa on 2018/1/12.
//  Copyright © 2018年 kaifa. All rights reserved.
//  



#import "XYTimeViewController.h"
#import "DayButton.h"

//获取屏幕尺寸
#define iPhone_Width    [[UIScreen mainScreen] bounds].size.width
#define iPhone_Height   [[UIScreen mainScreen] bounds].size.height

#define textColor_six   [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
#define color_zhu       [UIColor colorWithRed:45/255.0 green:174/255.0 blue:214/255.0 alpha:1]

@interface XYTimeViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property NSDate *dispalyDate;//显示的日期
@property (weak, nonatomic) IBOutlet UILabel *disLabel;
@property UIView *displayView;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endeLabel;

@property NSString *left_right;
@property UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@end

@implementation XYTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dispalyDate = [NSDate date];
    
    _displayView = [self getview:_dispalyDate tag:200];
    
    _displayView.frame = CGRectMake(0, 0, iPhone_Width-40, (iPhone_Width-40)*6/7);

    [_timeView addSubview:_displayView];
    
    _disLabel.text = [self dateString:_dispalyDate format:@"yyyy年MM月"];
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [_displayView addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [_displayView addGestureRecognizer:self.rightSwipeGestureRecognizer];
}

- (UIView *)getview:(NSDate *)date tag:(int)numbertag{
    UIView *bigview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iPhone_Width-40, (iPhone_Width-40)*6/7)];
    bigview.backgroundColor = [UIColor whiteColor];
    
    NSArray *timearray = [self getFirst_Last:date isstr:NO];
    int week = [self getWeekdayWithYear:timearray[0]];
    NSString *yearMonth = [self dateString:_dispalyDate format:@"yyyyMM"];
    
    CGFloat width = (bigview.frame.size.width)/7;
    
    UIView *oneview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    int daynum = 1;
    for (int i = 0; i< 42; i++) {
        
        DayButton *daybutton = [DayButton buttonWithType:UIButtonTypeSystem];
        daybutton.frame = CGRectMake(CGRectGetMaxX(oneview.frame), CGRectGetMinY(oneview.frame), width, width);
        NSString *daystring = [self dateString:timearray[1] format:@"dd"];
        
        if (i >= week && daynum<= [daystring intValue]) {
            [daybutton setTitle:[NSString stringWithFormat:@"%d",daynum] forState:UIControlStateNormal];
            [daybutton addTarget:self action:@selector(displayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [daybutton setTitleColor:textColor_six forState:UIControlStateNormal];
            [daybutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            NSString *tagstr;
            if (daynum < 10) {
                tagstr = [NSString stringWithFormat:@"%@0%d",yearMonth,daynum];
            }else{
                tagstr = [NSString stringWithFormat:@"%@%d",yearMonth,daynum];
            }
            daybutton.num = tagstr;
            daynum +=1;
            
        }
        
        if (_startDate == nil) {
            _startLabel.text = @"";
        }else{
            _startLabel.text = [self dateString:_startDate format:@"yyyy-MM-dd"];
        }
        if (_endDate == nil) {
            _endeLabel.text = @"";
        }else{
            _endeLabel.text = [self dateString:_endDate format:@"yyyy-MM-dd"];
        }
        
        [daybutton setTag:numbertag+i];
        [bigview addSubview:daybutton];
        
        oneview.frame = daybutton.frame;
        if ((i+1)%7 == 0) {
            CGRect rect = oneview.frame;
            rect.origin.x = 0;
            rect.origin.y += width;
            rect.size.width = 0;
            oneview.frame = rect;
        }
    }
    return bigview;
}

//  点击
- (void)displayButtonClick:(DayButton *)sender {
    DayButton *button = sender;
    [button setBackgroundColor:color_zhu];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSDate *date = [self stringToDate:[NSString stringWithFormat:@"%@",button.num] format:@"yyyyMMdd"];
    
    if (_startDate == nil && _endDate == nil) {
        _startDate = date;
        [button setBackgroundImage:[UIImage imageNamed:@"lefttime"] forState:UIControlStateNormal];
        
    }else if (_startDate != nil && _endDate == nil) {
        _endDate = date;
        NSString *starstring = [self dateString:_startDate format:@"yyyyMMdd"];
        NSString *endstring = [self dateString:_endDate format:@"yyyyMMdd"];
        if ([starstring intValue] > [endstring intValue]) {
            _endDate = _startDate;
            _startDate = date;
        }
        [self shuaxin:NO];
        
    }else if (_startDate != nil && _endDate != nil) {
        _startDate = date;
        _endDate = nil;
        [self shuaxin:NO];
        [button setBackgroundColor:color_zhu];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"lefttime"] forState:UIControlStateNormal];
    }
    if (_startDate == nil) {
        _startLabel.text = @"";
    }else{
        _startLabel.text = [self dateString:_startDate format:@"yyyy-MM-dd"];
    }
    if (_endDate == nil) {
        _endeLabel.text = @"";
    }else{
        _endeLabel.text = [self dateString:_endDate format:@"yyyy-MM-dd"];
    }
}


- (void)handleSwipes:(UISwipeGestureRecognizer *)sender {
    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {//+
        _dispalyDate = [self monthDate:1 date:_dispalyDate];
        _left_right = @"fromRight";
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {//-
        _dispalyDate = [self monthDate:-1 date:_dispalyDate];
        _left_right = @"fromLeft";
    }
    [self shuaxin:YES];
}

- (void)shuaxin:(BOOL)isdh {

    NSArray *timearray = [self getFirst_Last:_dispalyDate isstr:NO];
    int week = [self getWeekdayWithYear:timearray[0]];
    
    NSString *yearMonth = [self dateString:_dispalyDate format:@"yyyyMM"];
    NSString *daystring = [self dateString:timearray[1] format:@"dd"];
    int daynum = 1;
    for (int i = 200; i<242; i++) {
        DayButton *button = (DayButton *)[self.view viewWithTag:i];
        [button addTarget:self action:@selector(displayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitleColor:textColor_six forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        button.num = 0;
        if (i-200 >= week && daynum<= [daystring intValue]) {
            [button setTitle:[NSString stringWithFormat:@"%d",daynum] forState:UIControlStateNormal];
            
            NSString *tagstr;
            if (daynum < 10) {
                tagstr = [NSString stringWithFormat:@"%@0%d",yearMonth,daynum];
            }else{
                tagstr = [NSString stringWithFormat:@"%@%d",yearMonth,daynum];
            }
            button.num = tagstr;
            daynum +=1;
            
            NSDate *date = [self stringToDate:button.num format:@"yyyyMMdd"];
            
            if (_startDate != nil && _endDate == nil) {
                if (date == _startDate) {
                    [button setBackgroundColor:color_zhu];
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                
            }else if (_startDate != nil && _endDate != nil) {
                NSString *startStr = [self dateString:_startDate format:@"yyyyMMdd"];
                NSString *endStr = [self dateString:_endDate format:@"yyyyMMdd"];
                NSString *dateStr = [self dateString:date format:@"yyyyMMdd"];
                if ([dateStr intValue] >= [startStr intValue] && [dateStr intValue] <= [endStr intValue]) {
                    [button setBackgroundColor:color_zhu];
                    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                if ([startStr isEqualToString:endStr]) {
                    [button setBackgroundImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
                    
                }else if ([dateStr isEqualToString:startStr]) {
                    [button setBackgroundImage:[UIImage imageNamed:@"lefttime"] forState:UIControlStateNormal];
                    
                }else if ([dateStr isEqualToString:endStr]) {
                    [button setBackgroundImage:[UIImage imageNamed:@"righttime"] forState:UIControlStateNormal];
                    
                }
            }
            
        }
    }
    if (isdh){
        _disLabel.text = [self dateString:_dispalyDate format:@"yyyy年MM月"];
        [self transitionWithType:@"reveal" WithSubtype:_left_right ForView:_displayView];
    }
    
}

- (void)updateBackguong {
    
    
}

#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view {
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.7f;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (IBAction)closeClick:(id)sender {
    [self.view removeFromSuperview];
}
- (IBAction)okClick:(id)sender {
    if (_endDate != nil && _endDate != nil) {
        _selectTime(_startDate,_endDate);
        [self.view removeFromSuperview];
    }
}

//---------------------------------------------------------------------------------------------------------------------------
#pragma mark - 计算时间加减
- (NSDate *)monthDate:(int)num date:(NSDate *)date{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:num];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

#pragma mark - 字符串转换时间
- (NSDate *)stringToDate:(NSString*)string format:(NSString *)format {
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];//格式化
    [formatter setDateFormat:format];
    return [formatter dateFromString:string];
}

#pragma mark - 时间转换字符串
- (NSString *) dateString:(NSDate*)date format:(NSString *)format {
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];//格式化
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

#pragma mark - 获取月份的第一天和最后一天
- (NSArray *)getFirst_Last:(NSDate *)dateStr isstr:(BOOL)isStr{
    NSDate *newDate = dateStr;
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];

    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];

    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }

    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *firstString = [self dateString:firstDate format:@"yyyy-MM-dd"];
    NSString *lastString = [self dateString:lastDate format:@"yyyy-MM-dd"];
    if (isStr) {
        return @[firstString, lastString];
    }
    return @[firstDate, lastDate];
    
}

#pragma mark - 时间转周几
- (int)getWeekdayWithYear:(NSDate *)dateTime{
    NSInteger year = [[self dateString:dateTime format:@"yyyy"] integerValue];
    NSInteger month = [[self dateString:dateTime format:@"MM"] integerValue];
    NSInteger day = [[self dateString:dateTime format:@"dd"] integerValue];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *calender =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [calender dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [calender components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekDayNum =[weekdayComponents weekday] - 1;
    return (int)weekDayNum;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
