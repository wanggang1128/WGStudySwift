//
//  WGRunTimeTestController.m
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/25.
//  Copyright © 2018年 wg. All rights reserved.
//

#import "WGRunTimeTestController.h"
#import <objc/message.h>
#import "WGPerson.h"

@interface WGRunTimeTestController ()

@end

@implementation WGRunTimeTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBaseView];
//    [self methodFirs];
    [self methodSecond];
    
}

- (void)setBaseView{
    self.view.backgroundColor = [UIColor yellowColor];
}

//1.通常初始化对象，调用对象方法
- (void)methodFirs{
    WGPerson *per = [[WGPerson alloc] init];
    [per eat];
    //或者
    [per performSelector:@selector(eat)];
}

//2.对方法1 用消息机制写
- (void)methodSecond{
    /*
     WGPerson *per = [[WGPerson alloc] init];
     可拆分为
     WGPerson *per = [WGPerson alloc];
     [per init];
    */
    
    //这样其实下面三行代码里面还包含OC代码,可以这样改
//    WGPerson *per = objc_msgSend([WGPerson class], @selector(alloc));
//    per = objc_msgSend(per, @selector(init));
//    objc_msgSend(per, @selector(eat));
    
    //改成这样
    WGPerson *per = objc_msgSend(objc_getClass("WGPerson"), sel_registerName("alloc"));
    per = objc_msgSend(per, sel_registerName("init"));
    objc_msgSend(per, sel_registerName("eat"));
    //带参数方法
    objc_msgSend(per, sel_registerName("look:"),@"电子书");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}















@end
