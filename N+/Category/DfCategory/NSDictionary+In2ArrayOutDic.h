//
//  NSDictionary+In2ArrayOutDic.h
//  N+
//
//  Created by hy1 on 16/1/13.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (In2ArrayOutDic)
///只针对处理返回数据中键值的调整
+ (NSDictionary *)In2ArrayOutDicWithOneArr:(NSArray *)oneArr andTwoArr:(NSArray *)twoArr;

@end
