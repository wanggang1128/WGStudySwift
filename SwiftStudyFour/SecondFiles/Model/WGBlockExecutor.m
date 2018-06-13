//
//  WGBlockExecutor.m
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/31.
//  Copyright © 2018年 wg. All rights reserved.
//

#import "WGBlockExecutor.h"

@interface WGBlockExecutor() {
    voidBlock _block;
}
@end

@implementation WGBlockExecutor

-(instancetype)initWithBlock:(voidBlock)block{
    if (self = [super init]) {
        _block = [block copy];
    }
    return self;
}

-(void)dealloc{
    _block ? _block() : nil;
}

@end
