//
//  AAAWeatherSK.h
//  BaseProject
//
//  Created by hy1 on 16/1/8.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAAWeatherSK : NSObject
///温度
@property (nonatomic,strong) NSString *temp;
///风向
@property (nonatomic,strong) NSString *wind_direction;
///风级
@property (nonatomic,strong) NSString *wind_strength;
///湿度
@property (nonatomic,strong) NSString *humidity;
@property (nonatomic , strong) NSString *time;

@end
