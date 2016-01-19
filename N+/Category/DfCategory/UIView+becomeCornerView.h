//
//  UIView+becomeCornerView.h
//  N+
//
//  Created by hy1 on 16/1/19.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (becomeCornerView)
///处理图层圆角
+ (void)changeCorner:(UIView *)view radius:(CGFloat)radius;

@end
