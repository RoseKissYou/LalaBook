//
//  LeaveCell.h
//  N+
//
//  Created by hy1 on 16/1/19.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *isPassImageView;
@property (weak, nonatomic) IBOutlet UILabel *LeaveTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *LeaveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *LeaveReasonLabel;
@property (weak, nonatomic) IBOutlet UILabel *LeaveStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *LeaveEndLabel;

@end
