//
//  SH2Operation.m
//  TestOperation
//
//  Created by isoftstone on 16/3/4.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "SHOperation.h"

static NSString * const kMsspSDKLockName = @"operation.lock";

@implementation SHOperation
{
    BOOL finished;
    BOOL executing;
}

- (instancetype)init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.lock = [[NSRecursiveLock alloc] init];
    self.lock.name = kMsspSDKLockName;
    self.runLoopModes = [NSSet setWithObject:NSRunLoopCommonModes];
    
    return self;
}


- (void)start
{
    [self.lock lock];
    if ([self isCancelled])
    {
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    else if ([self isReady])
    {
        [self willChangeValueForKey:@"isFinished"];
        finished  = NO;
        [self didChangeValueForKey:@"isFinished"];
        
        [self willChangeValueForKey:@"isExecuting"];
        executing = YES;
        [self willChangeValueForKey:@"isExecuting"];
        
        NSLog(@"这里是start,线程号：%@", [NSThread currentThread]);
        //[self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO];
        [self performSelector:@selector(operationDidStart) onThread:[[self class] networkRequestThread] withObject:nil waitUntilDone:NO modes:[self.runLoopModes allObjects]];
    }
    [self.lock unlock];
}


+ (NSThread *)networkRequestThread
{
    NSLog(@"networkRequestThread");
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    
    return _networkRequestThread;
}

+ (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        NSLog(@"networkRequestThreadEntryPoint");
        [[NSThread currentThread] setName:@"TestThread"];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runloop run];
    }
}



- (void)operationDidStart
{
    [self.lock lock];
    if (![self isCancelled])
    {
        NSLog(@"operationDidStart");
    }
    [self.lock unlock];
}


- (void)finishOperation
{
    [self.lock lock];
    NSLog(@"is finishOperation");
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self willChangeValueForKey:@"isFinished"];
    finished  = YES;
    [self didChangeValueForKey:@"isFinished"];
    [self.lock unlock];
}

- (BOOL) isConcurrent{
    NSLog(@"is concurrent");
    return YES;
}

- (BOOL) isFinished{
    NSLog(@"is finished");
    return finished;
}

- (BOOL) isExecuting{
    NSLog(@"is executing");
    return executing;
}

//- (void)cancel
//{
//    [self.lock lock];
//    if (![self isFinished] && ![self isCancelled])
//    {
//        [super cancel];
//    }
//    [self.lock unlock];
//}


@end
