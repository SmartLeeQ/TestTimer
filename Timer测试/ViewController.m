//
//  ViewController.m
//  Timer测试
//
//  Created by lixiaoqiang on 2018/1/14.
//  Copyright © 2018年 lixiaoqiang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong)NSTimer *localTimer;
@property (nonatomic,strong)NSTimer *beatsTimer;
@property (nonatomic,assign)BOOL isBeats;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"我开始了");
    self.isBeats = NO;
    [self loadWebView];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
     self.localTimer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(timeAction) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.localTimer forMode:NSDefaultRunLoopMode];
         [[NSRunLoop currentRunLoop] run];
    });
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"启动心跳");
    self.isBeats = !self.isBeats;
    if (self.isBeats) {
        self.beatsTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(beatsAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.beatsTimer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }else
    {
        if (self.beatsTimer.isValid) {
            [self.beatsTimer invalidate];
            self.beatsTimer = nil;
        }
    }

}
- (void)beatsAction
{
     NSLog(@"心跳");
    if (self.localTimer.isValid) {
        [self.localTimer invalidate];
        self.localTimer = nil;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.localTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(loadWebView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.localTimer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });

   // [self timeAction];
}
- (void)timeAction
{
    [self loadWebView];
//    NSLog(@"%s----%@",__func__,[NSThread currentThread]);
//    if (self.localTimer.isValid) {
//        [self.localTimer invalidate];
//        self.localTimer = nil;
//    }
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        self.localTimer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(loadWebView) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:self.localTimer forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] run];
//    });
    [self beatsAction];
}
- (void)loadWebView
{
    NSLog(@"%s----%@",__func__,[NSThread currentThread]);

}
@end
