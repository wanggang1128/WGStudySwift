//
//  WGPerson.m
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/25.
//  Copyright © 2018年 wg. All rights reserved.
//

#import "WGPerson.h"

@implementation WGPerson

-(void)eat{
    NSLog(@"RunTime验证已经吃了");
}

- (void)look:(NSString *)book{
    NSLog(@"Runtime验证看%@了",book);
}

@end
