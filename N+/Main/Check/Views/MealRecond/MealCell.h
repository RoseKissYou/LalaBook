//
//  MealCell.h
//  N+
//
//  Created by hy1 on 16/1/20.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *breafastRight;
@property (weak, nonatomic) IBOutlet UIImageView *lunchRight;
@property (weak, nonatomic) IBOutlet UIImageView *dinnerRight;
@property (weak, nonatomic) IBOutlet UIImageView *nightRight;

@end
