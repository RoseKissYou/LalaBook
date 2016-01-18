//
//  AAAWeatherDataRequestTool.h
//  BaseProject
//
//  Created by hy1 on 16/1/7.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AAAWeather;
@interface AAAWeatherDataRequestTool : NSObject

+ (instancetype)sharedAAAWeatherDataRequestTool;
/**
 根据城市请求天气数据
 */
- (void)requestWeatherDataWithcityName:(NSString *)cityName Success:(void(^)(AAAWeather *weather))success Failure:(void(^)(NSError *error))failure;
@end
