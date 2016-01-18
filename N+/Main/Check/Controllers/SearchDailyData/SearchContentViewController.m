//
//  SearchContentViewController.m
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "SearchContentViewController.h"
#import "SpecialCell.h"
#import "CommonCell.h"
#import "AAASearchTool.h"
#import "AAASearchParam.h"

#import "PDDataResult.h"
#import "PDDataInfoResult.h"

#import "TableViewContentResult.h"
#import "TVCDataInfoResult.h"

#import "NSDate+DateLocationChange.h"

@interface SearchContentViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *_eventsByDate;
    
    NSDate *_todayDate;
    
    NSDate *_dateSelected;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *calenderView;

@property (assign,nonatomic) NSInteger count;

@property (nonatomic,strong) NSArray *firstArr;
@property (nonatomic,strong) NSArray *secondArr;


@end

@implementation SearchContentViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self addCalendar];
    
    AAASearchParam *param = [AAASearchParam sharedAAASearchParam];
    param.tbname = self.modelName;
#warning df-调试中
    [[AAASearchTool sharedAAASearchTool] getTableViewContent:param Success:^(TableViewContentResult *result) {
        NSArray *arr1 = result.datainfo;
        [[AAASearchTool sharedAAASearchTool] getPresentDailyData:nil Success:^(NSArray *result) {
            
            NSArray *arr2 = result[0];
            ////
            NSMutableArray *firstArr = [NSMutableArray array];
            for (TVCDataInfoResult *tvc in arr1) {
                if (firstArr.count == 0) {
                    [firstArr addObject:tvc.GroupName];
                }else{
                    if (![firstArr containsObject:tvc.GroupName]) {
                        [firstArr addObject:tvc.GroupName];
                    }
                }
            }
            NSLog(@"%@",firstArr);
            
            NSMutableArray *secondArr = [NSMutableArray array];
            for (NSString *str in firstArr) {
                NSMutableArray *keyArr = [NSMutableArray array];
                NSMutableArray *valueArr = [NSMutableArray array];
                for (TVCDataInfoResult *tvc in arr1) {
                    NSLog(@"%@",tvc.FieldName);
                    for (PDDataInfoResult *pd in arr2) {
                        NSLog(@"%@",pd.FieldName);
                        if ([tvc.FieldName isEqualToString:pd.FieldName]&&[tvc.GroupName isEqualToString:str]) {
                            [keyArr addObject:pd.FieldName];
                            [valueArr addObject:pd.FieldValue];
                        }
                    }
                }
//                NSDictionary *dic = [[NSDictionary alloc]initWithObjects:valueArr forKeys:keyArr];
//                [secondArr addObject:dic];
                [secondArr addObject:keyArr];
                [secondArr addObject:valueArr];
            }
            NSLog(@"%@",secondArr);
            ////
//            NSLog(@"%@",[NSDictionary In2ArrayOutDicWithOneArr:arr andTwoArr:result[0]]);
//            self.dataDic = [NSDictionary In2ArrayOutDicWithOneArr:arr andTwoArr:result[0]];
//            self.count = [self.dataDic allKeys].count;
            self.firstArr = [firstArr copy];
            self.secondArr = [secondArr copy];
            self.count = self.firstArr.count;
            [self.tableView reloadData];
        } Failure:^(NSError *error) {
            ;
        }];
    } Failure:^(NSError *error) {
        ;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back2CheckVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - 以下为TableView相关板块
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
#warning df-测试观察
    NSLog(@"%@",self.modelName);
    if (self.count == 0) {
        return 0;
    }else{
        return self.count + 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%ld",(unsigned long)self.count);
    
    if (section == 0) {
        return 1;
    }else
        return ((NSArray *)self.secondArr[section * 2 - 1]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *secondArr = self.secondArr;

        if (indexPath.section == 0) {
            SpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SCell" forIndexPath:indexPath];
            cell.timeOne.text = @"10分钟";
            cell.timeTwo.text = @"20分钟";
            cell.timeThree.text = @"30分钟";
            return cell;
        }else{
            CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCell" forIndexPath:indexPath];
            NSArray *arr1 = secondArr[(indexPath.section - 1)*2];
            NSArray *arr2 = secondArr[indexPath.section * 2 - 1];
            cell.keyLabel.text = arr1[indexPath.row];
            cell.valueLabel.text = arr2[indexPath.row];
            return cell;
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 44;
}






#pragma mark - 以下为日历处理板块

- (void)addCalendar{
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    // Generate random events sort by date using a dateformatter for the demonstration
//    [self createRandomEvents];
    
    // Create a min and max date for limit the calendar, optional
    _todayDate = [NSDate date];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:_todayDate];
}


- (IBAction)up:(UISwipeGestureRecognizer *)sender {
    _calendarManager.settings.weekModeEnabled = YES;
    [_calendarManager reload];

    [UIView animateWithDuration:0.25 animations:^{
        self.calendarContentViewHeight.constant = 60;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)down:(id)sender {
    _calendarManager.settings.weekModeEnabled = NO;
    [_calendarManager reload];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.calendarContentViewHeight.constant = 210;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Buttons callback

- (IBAction)didChangeModeTouch
{
    _calendarManager.settings.weekModeEnabled = !_calendarManager.settings.weekModeEnabled;
    [_calendarManager reload];
    
    CGFloat newHeight = 300;
    if(_calendarManager.settings.weekModeEnabled){
        newHeight = 85.;
    }
    
    self.calendarContentViewHeight.constant = newHeight;
    [self.view layoutIfNeeded];
}

#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = YES;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

#pragma mark - Views customization
- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyy年MM月";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
}

#pragma mark - Fake data


// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    NSArray *arr = _eventsByDate[key];
    
    
    if(arr && (arr.count) > 0){
        return YES;
    }
    
    return NO;
    
}

- (void)createRandomEvents
{
    _eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!_eventsByDate[key]){
            _eventsByDate[key] = [NSMutableArray new];
        }
        
        [_eventsByDate[key] addObject:randomDate];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
