//
//  AAALoginResult.h
//  N+
//
//  Created by hy1 on 16/1/21.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAALoginResult : NSObject
///员工号
@property (nonatomic ,strong) NSString *empcode;
///公司名
@property (nonatomic ,strong) NSString *entname;
+ (instancetype)sharedAAALoginResult;
@end
