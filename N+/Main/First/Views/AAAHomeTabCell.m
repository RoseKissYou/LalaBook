//
//  AAAHomeTabCell.m
//  BaseProject
//
//  Created by 小笨熊 on 16/1/5.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAAHomeTabCell.h"

@interface AAAHomeTabCell ()
@property (weak, nonatomic) IBOutlet UIImageView *essayHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *essayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *essayJobLabel;
@property (weak, nonatomic) IBOutlet UILabel *essayTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *essayAdmineLabel;
@property (weak, nonatomic) IBOutlet UILabel *essayCommentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *essayLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *essayContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *essayContentImageView;


@end

@implementation AAAHomeTabCell
- (void)essayWithImageView:(NSString *)imageName essayName:(NSString *)name
{
    self.essayHeaderImageView.image = [UIImage imageNamed:imageName];
    self.essayNameLabel.text = name;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
