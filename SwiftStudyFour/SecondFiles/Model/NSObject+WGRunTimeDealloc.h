//
//  NSObject+WGRunTimeDealloc.h
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/31.
//  Copyright © 2018年 wg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGBlockExecutor.h"

@interface NSObject (WGRunTimeDealloc)

- (void)wg_tuntimeDealloc:(voidBlock)block;

@end
