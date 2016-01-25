//
//  UIView+becomeCornerView.m
//  N+
//
//  Created by hy1 on 16/1/19.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "UIView+becomeCornerView.h"

@implementation UIView (becomeCornerView)
+ (void)changeCorner:(UIView *)view radius:(CGFloat)radius{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

@end
