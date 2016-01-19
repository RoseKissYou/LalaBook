//
//  MonthDetailViewController.h
//  N+
//
//  Created by hy1 on 16/1/19.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JTCalendar.h"

@interface MonthDetailViewController : UIViewController<JTCalendarDataSource>

///日历以下
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTCalendarContentView *calendarContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) JTCalendar *calendar;
//日历以上

///用于判断是否是日考勤
@property (strong, nonatomic)NSString *modelName;

@end
