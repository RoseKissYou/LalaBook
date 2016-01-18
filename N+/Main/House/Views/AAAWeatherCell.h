//
//  AAAWeatherCell.h
//  BaseProject
//
//  Created by 小笨熊 on 16/1/6.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAAWeatherCell : UITableViewCell
- (NSString *)setWeatherForCity:(NSString *)city andWeather:(NSString *)weather  andDressing:(NSString *)dressing andTravel:(NSString *)travel andExercise:(NSString *)exercise andWashCar:(NSString *)washCar;
//设置天气描述和温度
- (void)setWeatherDescLabel:(NSString *)desc andTemp:(NSString *)temp;


//展示环境指数气泡
-(void)showWeatherView;
//隐藏环境指数气泡
-(void)hideWeatherView;

- (void)changeLalaPosition;
@end
