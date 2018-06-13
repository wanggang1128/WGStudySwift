//
//  WGBlockExecutor.h
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/31.
//  Copyright © 2018年 wg. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^voidBlock)(void);

@interface WGBlockExecutor : NSObject

-(instancetype)initWithBlock:(voidBlock)block;

@end
