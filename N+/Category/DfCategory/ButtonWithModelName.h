//
//  ButtonWithModelName.h
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//  继承UIButton，给Button添加隐藏识别字段

#import <UIKit/UIKit.h>

@interface ButtonWithModelName : UIButton

@property (nonatomic,strong) NSString *modelName;

@end
