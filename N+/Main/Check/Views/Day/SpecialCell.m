//
//  SpecialCell.m
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "SpecialCell.h"
#import "UIView+becomeCornerView.h"

@interface SpecialCell ()


@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation SpecialCell
- (void)layoutSubviews{
    [super layoutSubviews];
    [UIView changeCorner:self.redView radius:35.];
    [UIView changeCorner:self.yellowView radius:35.];
    [UIView changeCorner:self.blueView radius:35.];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
