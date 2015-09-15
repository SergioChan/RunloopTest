//
//  SCCustomThread.m
//  runloopTest
//
//  Created by chen Yuheng on 15/9/12.
//  Copyright (c) 2015年 chen Yuheng. All rights reserved.
//

#import "SCCustomThread.h"

@implementation SCCustomThread
{
    NSInteger _timerIndex;
}

- (void)main
{
    @autoreleasepool {
        NSLog(@"Thread Enter");
        [[NSThread currentThread] setName:@"This is a test thread"];
        NSRunLoop *currentThreadRunLoop = [NSRunLoop currentRunLoop];
        // 或者
        // CFRunLoopRef currentThreadRunLoop = CFRunLoopGetCurrent();
        
        // 创建一个 Run Loop Observer，并添加到当前Run Loop中, 设置Mode为Default
        CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
        CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &currentRunLoopObserver, &context);
        
        if (observer) {
            CFRunLoopRef runLoopRef = currentThreadRunLoop.getCFRunLoop;
            CFRunLoopAddObserver(runLoopRef, observer, kCFRunLoopDefaultMode);
        }
        
        // 创建一个Timer，重复调用来驱动Run Loop
        //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handleTimerTask) userInfo:nil repeats:YES];
        do {
            [currentThreadRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:3]];
        } while (1);
    }
}

#pragma mark - Observer CallBack

void currentRunLoopObserver(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    NSLog(@"Current thread Run Loop activity: %@", printActivity(activity));
}

static inline NSString* printActivity(CFRunLoopActivity activity)
{
    NSString *activityDescription;
    switch (activity) {
        case kCFRunLoopEntry:
            activityDescription = @"kCFRunLoopEntry";
            break;
        case kCFRunLoopBeforeTimers:
            activityDescription = @"kCFRunLoopBeforeTimers";
            break;
        case kCFRunLoopBeforeSources:
            activityDescription = @"kCFRunLoopBeforeSources";
            break;
        case kCFRunLoopBeforeWaiting:
            activityDescription = @"kCFRunLoopBeforeWaiting";
            break;
        case kCFRunLoopAfterWaiting:
            activityDescription = @"kCFRunLoopAfterWaiting";
            break;
        case kCFRunLoopExit:
            activityDescription = @"kCFRunLoopExit";
            break;
        default:
            break;
    }
    return activityDescription;
}

#pragma mark - Actions

- (void)handleTimerTask
{
    NSLog(@"handleTimerTask");
    
    _timerIndex ++;
    NSLog(@"timer Index : %ld", _timerIndex);
    if (_timerIndex > 100) {
        CFRunLoopStop(CFRunLoopGetCurrent()); //只有在-runMode:beforDate 和 -run 两种情况下有效
    }
}
@end
