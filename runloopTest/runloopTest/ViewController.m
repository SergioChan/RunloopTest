//
//  ViewController.m
//  runloopTest
//
//  Created by chen Yuheng on 15/9/12.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "ViewController.h"
#import "SCCustomThread.h"

@interface ViewController ()
@property (nonatomic,strong) SCCustomThread *runLoopThread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Set up an autorelease pool here if not using garbage collection.
    self.runLoopThread = [[SCCustomThread alloc] init];
    [self.runLoopThread start];
    // Clean up code here. Be sure to release any allocated autorelease pools.
}
- (IBAction)performSelectorPressed:(id)sender {
    [self performSelector:@selector(selectorTest) onThread:self.runLoopThread withObject:nil waitUntilDone:YES];
    [self performSelector:@selector(selectorTest_1) onThread:self.runLoopThread withObject:nil waitUntilDone:YES];
    [self performSelector:@selector(selectorTest_2) onThread:self.runLoopThread withObject:nil waitUntilDone:YES];
    [self performSelector:@selector(selectorTest_2) onThread:self.runLoopThread withObject:nil waitUntilDone:YES];
}

- (void)selectorTest
{
    NSLog(@"fuck");
}

- (void)selectorTest_1
{
    NSLog(@"fuck_1");
}

- (void)selectorTest_2
{
    NSLog(@"fuck_2");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
