//
//  NSArray+SafeAction.m
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/20.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import "NSArray+SafeAction.h"

@implementation NSArray (SafeAction)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (id)safeObjectAtIndexedSubscript:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndexedSubscript:index];
    }
    return nil;
}

@end
