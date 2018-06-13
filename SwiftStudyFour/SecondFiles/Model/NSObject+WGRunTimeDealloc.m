//
//  NSObject+WGRunTimeDealloc.m
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/31.
//  Copyright © 2018年 wg. All rights reserved.
//

#import "NSObject+WGRunTimeDealloc.h"
#import <objc/message.h>

@implementation NSObject (WGRunTimeDealloc)

-(void)wg_tuntimeDealloc:(voidBlock)block{
    if (block) {
        WGBlockExecutor *executor = [[WGBlockExecutor alloc] initWithBlock:block];
        //这里释放
        objc_setAssociatedObject(self, @"key", executor, OBJC_ASSOCIATION_RETAIN);
    }
}

@end
