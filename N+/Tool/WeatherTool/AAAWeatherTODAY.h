//
//  AAAWeatherTODAY.h
//  BaseProject
//
//  Created by hy1 on 16/1/8.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAAWeatherTODAY : NSObject
///城市
@property (nonatomic,strong) NSString *city;
///风的种类
@property (nonatomic,strong) NSString *wind;
///天气描述
@property (nonatomic,strong) NSString *weather;
///当天温度范围
@property (nonatomic,strong) NSString *temperature;
///穿衣指数
@property (nonatomic,strong) NSString *dressing_index;
///穿衣建议
@property (nonatomic,strong) NSString *dressing_advice;
///紫外线强度
@property (nonatomic,strong) NSString *uv_index;
///舒适度指数
@property (nonatomic,strong) NSString *comfort_index;
///洗车指数
@property (nonatomic,strong) NSString *wash_index;
///旅游指数
@property (nonatomic,strong) NSString *travel_index;
///晨练指数
@property (nonatomic,strong) NSString *exercise_index;
///干燥指数
@property (nonatomic,strong) NSString *drying_index;
@end
