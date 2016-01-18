//
//  PDDataResult.h
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//  ///返回查询界面功能按钮列表

#import <Foundation/Foundation.h>

@interface VContentResult : NSObject
///数组元素个数
@property (nonatomic,strong) NSString *count;
///具体数组容器
@property (nonatomic,strong) NSArray *datainfo;
@end
