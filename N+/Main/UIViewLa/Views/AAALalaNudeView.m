//
//  AAALalaNudeView.m
//  N+
//
//  Created by hy2 on 16/1/15.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAALalaNudeView.h"

@implementation AAALalaNudeView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //实例化拉拉的 Instance Lala's nude images array
        //1. add images name
        NSMutableArray *arrImages = [NSMutableArray arrayWithCapacity:lalaHelloImages];
        for (NSInteger i = 1; i <= lalaHelloImages; i++) {
            NSString *imageName = [NSString stringWithFormat:lalaHelloImageName,(long)i ];
            UIImage *imageList = [UIImage imageNamed:imageName];
            [arrImages addObject:imageList];
        }
        //2. add image view to self
        UIImageView *imageViews = [[UIImageView alloc] initWithImage:arrImages[0]];
        [imageViews setFrame:frame];
        [self addSubview:imageViews];
        //3. setting animation
        [imageViews setAnimationImages:arrImages];
        [imageViews setAnimationDuration:lalaAnimationTime];
        [imageViews startAnimating];
        
    }return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
