//
//  AAATodayCell.h
//  N+
//
//  Created by hy2 on 16/1/14.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAATodayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *todayTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayWeatherDescripeLabel;
//紫外线强度
@property (weak, nonatomic) IBOutlet UILabel *todayUVIndexLabel;

@property (weak, nonatomic) IBOutlet UILabel *todayDressAdviceLabel;


@end
