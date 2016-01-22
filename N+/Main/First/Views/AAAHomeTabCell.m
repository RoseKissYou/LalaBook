//
//  AAAHomeTabCell.m
//  BaseProject
//
//  Created by 小笨熊 on 16/1/5.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAAHomeTabCell.h"

@interface AAAHomeTabCell ()
@property (weak, nonatomic) IBOutlet UIImageView *essayHeaderImageView;//头像
@property (weak, nonatomic) IBOutlet UILabel *essayNameLabel;//名字
@property (weak, nonatomic) IBOutlet UILabel *essayJobLabel;//部门
@property (weak, nonatomic) IBOutlet UILabel *essayTimeLabel;//发布时间
@property (weak, nonatomic) IBOutlet UILabel *essayAdmineLabel;//点赞数量
@property (weak, nonatomic) IBOutlet UILabel *essayCommentsLabel;//点评数量
@property (weak, nonatomic) IBOutlet UILabel *essayLocationLabel;//地点定位
@property (weak, nonatomic) IBOutlet UILabel *essayContentLabel;//说说内容
@property (weak, nonatomic) IBOutlet UIImageView *essayContentImageView;//说说图片


@end

@implementation AAAHomeTabCell
- (void)essayWithImageView:(NSString *)imageName essayName:(NSString *)name withContentImage:(NSString *)contentImage
{
    self.essayHeaderImageView.image = [UIImage imageNamed:imageName];
    self.essayNameLabel.text = name;
    self.essayContentImageView.image = [UIImage imageNamed:contentImage];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
