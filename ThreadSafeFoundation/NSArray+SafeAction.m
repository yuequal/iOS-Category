//
//  NSArray+SafeAction.m
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/20.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import "NSArray+SafeAction.h"
#import "SafeMethodSwizzle.h"

@implementation NSArray (SafeAction)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[SafeMethodSwizzle class] swizzleSEL:@selector(objectAtIndexedSubscript:) withSEL:@selector(safeObjectAtIndexedSubscript:) class:NSClassFromString(@"__NSArrayI")];
    });
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (id)safeObjectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self safeObjectAtIndexedSubscript:index];
}


@end
