//
//  NSMutableDictionary+ThreadSafe.m
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/21.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import "NSMutableDictionary+ThreadSafe.h"
#import <objc/runtime.h>

static const char *SHDictionarySafeLockAssociateKey = "SHDictionarySafeLockAssociateKey";

@implementation NSMutableDictionary (ThreadSafe)

- (NSLock *)safeLock
{
    NSLock *associateLock = (NSLock *)objc_getAssociatedObject(self, SHDictionarySafeLockAssociateKey);
    if (!associateLock) {
        associateLock = [[NSLock alloc] init];
        objc_setAssociatedObject(self, SHDictionarySafeLockAssociateKey, associateLock, OBJC_ASSOCIATION_RETAIN);
        return associateLock;
    }
    return associateLock;
}

- (void)setSafeLock:(NSLock *)safeLock
{
    objc_setAssociatedObject(self, SHDictionarySafeLockAssociateKey, safeLock, OBJC_ASSOCIATION_RETAIN);
}

- (id)sh_safeObjectForKey:(id)aKey
{
    id object = nil;
    if (!aKey) return object;
    
    [self.safeLock lock];
    object = [self objectForKey:aKey];
    [self.safeLock unlock];
    return object;
}

- (id)sh_safeObjectForKeyedSubscript:(id)key
{
    id object = nil;
    if (!key) return object;
    
    [self.safeLock lock];
    object = [self objectForKeyedSubscript:key];
    [self.safeLock unlock];
    return object;
}

- (void)sh_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!aKey || !anObject) return;
    [self.safeLock lock];
    [self setObject:anObject forKey:aKey];
    [self.safeLock unlock];
}

- (void)sh_safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!key || !obj) return;
    [self.safeLock lock];
    [self setObject:obj forKeyedSubscript:key];
    [self.safeLock unlock];
}

- (void)sh_safeRemoveObjectForKey:(id)aKey
{
    if (!aKey) return;
    [self.safeLock lock];
    [self removeObjectForKey:aKey];
    [self.safeLock unlock];
}

- (void)sh_safeRemoveAllObjects
{
    [self.safeLock lock];
    [self removeAllObjects];
    [self.safeLock unlock];
}

- (void)sh_safeRemoveObjectsForKeys:(NSArray *)keyArray
{
    if (!keyArray || keyArray.count == 0) return;
    [self.safeLock lock];
    [self removeObjectsForKeys:keyArray];
    [self.safeLock unlock];
}

- (void)sh_safeSetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
    if (!keyedValues) return;
    [self.safeLock lock];
    [self setValuesForKeysWithDictionary:keyedValues];
    [self.safeLock unlock];
}

- (void)sh_safeAddEntriesFromDictionary:(NSDictionary *)otherDictionary
{
    if (!otherDictionary) return;
    [self.safeLock lock];
    [self addEntriesFromDictionary:otherDictionary];
    [self.safeLock unlock];
}

- (void)sh_safeEnumerateKeysAndObjectsUsingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block
{
    if (!block) return;
    [self.safeLock lock];
    [self enumerateKeysAndObjectsUsingBlock:block];
    [self.safeLock unlock];
}

- (void)sh_safeEnumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block
{
    if (!block) return;
    [self.safeLock lock];
    [self enumerateKeysAndObjectsWithOptions:opts usingBlock:block];
    [self.safeLock unlock];
}

@end
