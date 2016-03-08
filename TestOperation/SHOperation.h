//
//  SH2Operation.h
//  TestOperation
//
//  Created by isoftstone on 16/3/4.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHOperation : NSOperation

/**NSOperation的线程锁 */
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;

/**NSOperation的线程runloop模式 */
@property (nonatomic, strong) NSSet *runLoopModes;

@end
