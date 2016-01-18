//
//  AAALocationStr.h
//  BaseProject
//
//  Created by hy1 on 16/1/8.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAALocationStr : NSObject
///utf-8 类型字符串
@property (strong, nonatomic) NSString *locationStr;
///中文 类型字符串
@property (strong, nonatomic) NSString *locationStr_cn;

+ (instancetype)sharedAAALocationStr;
@end
