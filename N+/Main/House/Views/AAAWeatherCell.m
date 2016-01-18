//
//  AAAWeatherCell.m
//  BaseProject
//
//  Created by 小笨熊 on 16/1/6.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAAWeatherCell.h"

@interface AAAWeatherCell ()
/**
 *  天气描述
 */
@property (weak, nonatomic) IBOutlet UILabel *weatherDescLabel;
/**
 *  天气描述图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *weatherDescImage;
/**
 *  温度
 */
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

//问候视图
@property (weak, nonatomic) IBOutlet UIView *greetingsView;
//环境指数
@property (weak, nonatomic) IBOutlet UIView *weatherView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightDistance;

@end

@implementation AAAWeatherCell
- (void)changeLalaPosition
{
    self.rightDistance.constant = 0;
}

//展示环境指数气泡
-(void)showWeatherView{
    self.weatherView.hidden = NO;
}
//隐藏环境指数气泡
-(void)hideWeatherView{
    self.weatherView.hidden = YES;
}

//today取用数据: 城市city 天气weather 穿衣指导dressing_index 洗车指导wash_index 旅行指数travel_index 运动指数exercise_index
- (NSString *)setWeatherForCity:(NSString *)city andWeather:(NSString *)weather  andDressing:(NSString *)dressing andTravel:(NSString *)travel andExercise:(NSString *)exercise andWashCar:(NSString *)washCar
{
    NSString *str = [NSString stringWithFormat:@"今天%@天气是%@,穿衣%@,%@运动,%@旅行,%@洗车 ",city,weather,dressing,exercise,travel,washCar];
    self.weatherDescLabel.text = str ;
    return str;
}

- (void)setWeatherDescLabel:(NSString *)desc andTemp:(NSString *)temp{
    self.weatherDescLabel.text = desc;
    self.temperatureLabel.text = [temp stringByAppendingString:@"°C"];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
