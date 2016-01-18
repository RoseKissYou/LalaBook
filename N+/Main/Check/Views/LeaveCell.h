//
//  LeaveCell.h
//  N+
//
//  Created by hy1 on 16/1/14.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *sfImageView;

@property (weak, nonatomic) IBOutlet UILabel *leaveTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *leaveTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *leaveReasonLabel;

@property (weak, nonatomic) IBOutlet UILabel *leaveStartLabel;

@property (weak, nonatomic) IBOutlet UILabel *leaveEndLabel;

@end
