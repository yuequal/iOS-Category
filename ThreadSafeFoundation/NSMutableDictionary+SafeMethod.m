//
//  NSMutableDictionary+SafeMethod.m
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/21.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import "NSMutableDictionary+SafeMethod.h"

@implementation NSMutableDictionary (SafeMethod)

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey) return;
    if (!anObject) {
        [self removeObjectForKey:aKey];
        return;
    }
    [self setObject:anObject forKey:aKey];
}

- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!key) return;
    if (!obj) {
        [self removeObjectForKey:key];
        return;
    }
    [self setObject:obj forKeyedSubscript:key];
}

- (void)safeRemoveObjectForKey:(id)aKey
{
    if (!aKey) return;
    [self removeObjectForKey:aKey];
}



@end
