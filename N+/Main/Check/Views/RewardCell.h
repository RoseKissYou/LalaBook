//
//  RewardCell.h
//  N+
//
//  Created by hy1 on 16/1/19.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reasonLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
