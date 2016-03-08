//
//  T1Operation.m
//  TestOperation
//
//  Created by isoftstone on 16/3/4.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "T1Operation.h"

@implementation T1Operation

- (void)operationDidStart
{
    [self.lock lock];
    if (![self isCancelled])
    {
        NSLog(@"T1   operationDidStart");
    }
    [self.lock unlock];
}

@end
