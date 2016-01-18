//
//  AAALocationStr.m
//  BaseProject
//
//  Created by hy1 on 16/1/8.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAALocationStr.h"

@implementation AAALocationStr
static AAALocationStr *str = nil;
+ (void)initialize{
    if (self == [self class]) {
        str = [[self alloc]init];
    }
}

+ (instancetype)sharedAAALocationStr{
    return str;
}

- (NSString *)locationStr_cn{
    return [self.locationStr stringByRemovingPercentEncoding];
}
@end
