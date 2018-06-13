//
//  WGCustomStudyController.m
//  SwiftStudyFour
//
//  Created by wanggang on 2018/1/31.
//  Copyright © 2018年 wg. All rights reserved.
//

//这个类中验证一些关于OC方面的问题

#import "WGCustomStudyController.h"
#import "NSObject+WGRunTimeDealloc.h"
#import "NextViewController.h"
#import <objc/message.h>

@interface WGCustomStudyController ()
{
    //用来验证主动取消正在运行的GCD
    BOOL isCancleGCD;
}

//测试崩溃
@property (nonatomic, copy) NSMutableArray *mutArr01;

//验证strong和copy的区别
@property (nonatomic, strong) NSArray *strongArr;
@property (nonatomic, copy) NSArray *cpyArr;

//测试重写set和get方法
@property (nonatomic, copy) NSString *tittle;

//
@property (nonatomic, strong) dispatch_group_t disGroup;

//
@property (nonatomic, strong) NSDate *now;

@property (nonatomic, strong) CALayer *layer;

@end

@implementation WGCustomStudyController

//同时重写set和get方法后，系统不会生成ivar成员变量，这就需要使用@synthesize来手动合成
@synthesize tittle = _tittle;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self ceshimutArr01];
//    [self shifangweak];
    [self strongAndCopy];
//    [self changeBlockValue];
//    [self gcdGroup];
//    [self dispatchBarrier];
//    [self shoudongKVO];
//    [self xunhuan];
//    [self gcdText];
//    [self donghua];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(pushNextView01)]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    isCancleGCD = YES;
}

- (void)donghua{
    self.layer = [[CALayer alloc] init];
    _layer.backgroundColor = [UIColor redColor].CGColor;
    _layer.frame = CGRectMake(0, 0, 100, 100);
    _layer.cornerRadius = 50;
    [self.view.layer addSublayer:_layer];
}

- (void)pushNextView01{
    [CATransaction begin];
    [CATransaction setAnimationDuration:3];
    self.layer.position = [self getNewPosition];
    self.layer.backgroundColor = [self getNewBackColor];
    [CATransaction commit];
}

- (CGPoint)getNewPosition{
    NSInteger width = floorf(self.view.frame.size.width);
    NSInteger height = floorf(self.view.frame.size.height);
    NSInteger centerx = arc4random() % width;
    NSInteger centery = arc4random() % height;
    return CGPointMake(centerx, centery);
}

- (CGColorRef)getNewBackColor{
    return [UIColor colorWithRed:((arc4random() % 255)/255.f) green:((arc4random() % 255)/255.f) blue:((arc4random() % 255)/255.f) alpha:1].CGColor;
}

- (void)pushNextView{
    [self.navigationController pushViewController:[[NextViewController alloc] init] animated:YES];
}

- (void)gcdText{
    isCancleGCD = NO;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10000; i++) {
            NSLog(@"验证取消正在运行的GCD:%d",i);
            sleep(1);
            if (isCancleGCD) {
                NSLog(@"收到停止GCD信号，准备停止");
                return ;
            }
        }
    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"发出停止GCD运行的信号");
//        isCancleGCD = YES;
//    });
}

- (BOOL)quyu:(int)a{
    if (a == 5) {
        return YES;
    }else {
        return NO;
    }
}

- (void)xunhuan{
    int i = 1;
    while (i <= 10) {
        if ([self quyu:i]) {
            NSLog(@"----->>>>>yes");
            break;
        }else{
            i += 1;
            sleep(2);
            NSLog(@"------->>>>>no");
        }
    }
}

//手动触发KVO
- (void)shoudongKVO{
    [self addObserver:self forKeyPath:@"now" options:NSKeyValueObservingOptionNew context:nil];
    NSLog(@"1");
    [self willChangeValueForKey:@"now"]; // “手动触发self.now的KVO”，必写。
    NSLog(@"2");
    //这句注释的话，就不会执行代理
    [self didChangeValueForKey:@"now"]; // “手动触发self.now的KVO”，必写。
    NSLog(@"4");
}

//代理实现
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"3");
}

/*
 dispatch_barrier_async 作用是在并行队列中，等待前面操作并行操作完成，这里是并行输出
 dispatch-111，dispatch-222
 然后执行
 dispatch_barrier_async中的操作，执行完成后，即输出
 
 最后该并行队列恢复原有执行状态，继续并行执行
 dispatch-555
*/
- (void)dispatchBarrier{
    dispatch_queue_t queue = dispatch_queue_create("WGCurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"dispatch-111");
    });
    dispatch_async(queue, ^{
        NSLog(@"dispatch-222");
    });
    dispatch_barrier_async(queue, ^{
        sleep(5);
        [self gcdGroupRequest:@"333"];
    });
    dispatch_async(queue, ^{
        NSLog(@"dispatch-444");
    });
}

//如何用GCD同步若干个异步调用？（如根据若干个url异步加载多张图片，然后在都下载完成后合成一张整图）
- (void)gcdGroup{
    self.disGroup = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(_disGroup, queue, ^{
        sleep(5);
        [self gcdGroupRequest:@"1111"];
    });
    dispatch_group_async(_disGroup, queue, ^{
        [self gcdGroupRequest:@"2222"];
    });
    dispatch_group_async(_disGroup, queue, ^{
        [self gcdGroupRequest:@"3333"];
    });
    dispatch_group_notify(_disGroup, dispatch_get_main_queue(), ^{
        NSLog(@"4444");
    });
}

- (void)gcdGroupRequest:(NSString *)str{
    [[[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/zhidao/pic/item/5ab5c9ea15ce36d3c704f35538f33a87e950b156.jpg"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSData *data = [NSData dataWithContentsOfURL:location];
//        NSLog(@"data:%@",data);
        NSLog(@"回调%@", str);
    }] resume];
    NSLog(@"%@", str);
}

//在block内部如何修改block外部变量
- (void)changeBlockValue{
    __block int a = 10;
    NSLog(@"%d定义前:%p",a, &a);
    void (^foo)(void) = ^{
        a = 11;
        NSLog(@"%dblock内部:%p",a, &a);
    };
    NSLog(@"%d定义后:%p",a, &a);
    foo();
    NSLog(@"%d定义block完成:%p",a, &a);
}

//验证strong和copy的区别
- (void)strongAndCopy{
    NSMutableArray *mutA = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
    self.strongArr = mutA;
    self.cpyArr = mutA;
    NSLog(@"strongArr的值:%@", self.strongArr);
    NSLog(@"cpyArr的值:%@", self.cpyArr);
    [mutA removeAllObjects];
    [mutA addObject:@"4"];
    NSLog(@"改变后strongArr的值:%@", self.strongArr);
    NSLog(@"改变后cpyArr的值:%@", self.cpyArr);
}

//这个方法时验证：runtime 如何实现 weak 属性的问题
- (void)shifangweak{
    NSObject *foo = [[NSObject alloc] init];
    [foo wg_tuntimeDealloc:^{
        NSLog(@"正在释放foo!");
    }];
}

/*
 在这里，[self.mutArr01 removeObjectAtIndex:0];会崩溃
 因为copy对容器类，始终返回一个不可变类型，所以没有removeObjectAtIndex方法。
 */
- (void)ceshimutArr01{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, nil];
    self.mutArr01 = arr;
    [arr addObject:@3];
    [self.mutArr01 removeObjectAtIndex:0];
    NSLog(@"验证是否崩溃:%@",self.mutArr01);
}

-(instancetype)init{
    if (self = [super init]) {
        _tittle = @"synthesize使用场景";
        NSLog(@"tittle的值:%@", _tittle);
    }
    return self;
}

-(NSString *)tittle{
    return _tittle;
}

-(void)setTittle:(NSString *)tittle{
    _tittle = [tittle copy];
}


























@end
