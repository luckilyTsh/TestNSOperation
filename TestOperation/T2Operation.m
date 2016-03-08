//
//  T2Operation.m
//  TestOperation
//
//  Created by isoftstone on 16/3/4.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "T2Operation.h"

@implementation T2Operation

- (void)operationDidStart
{
    [self.lock lock];
    if (![self isCancelled])
    {
        NSLog(@"T2   operationDidStart");
    }
    [self.lock unlock];
}


@end
