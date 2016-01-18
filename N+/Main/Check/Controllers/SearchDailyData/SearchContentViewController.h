//
//  SearchContentViewController.h
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"

@interface SearchContentViewController : UIViewController<JTCalendarDelegate>

///日历以下
@property (weak, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;

@property (strong, nonatomic) JTCalendarManager *calendarManager;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;
//日历以上

///用于判断是否是日考勤
@property (strong, nonatomic)NSString *modelName;

@end
