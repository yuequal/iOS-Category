//
//  NSMutableArray+ThreadSafe.m
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/20.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import "NSMutableArray+ThreadSafe.h"
#import "SafeMethodSwizzle.h"
#import <objc/runtime.h>

@implementation NSMutableArray (ThreadSafe)

- (NSLock *)safeLock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSafeLock:(NSLock *)safeLock
{
    objc_setAssociatedObject(self, @selector(safeLock), safeLock, OBJC_ASSOCIATION_RETAIN);
}

- (id)sh_safeObjectAtIndex:(NSUInteger)index
{
    id object = nil;
    [self.safeLock lock];
    if (![self _indexIsValid:index]) {
        [self.safeLock unlock];
        return object;
    }
    object = [self objectAtIndex:index];
    [self.safeLock unlock];
    return object;
}

- (id)sh_safeObjectAtIndexedSubscript:(NSUInteger)index
{
    id object = nil;
    [self.safeLock lock];
    if (![self _indexIsValid:index]) {
        [self.safeLock unlock];
        return object;
    }
    object = [self objectAtIndexedSubscript:index];
    [self.safeLock unlock];
    return object;
}

- (void)sh_safeAddObject:(id)anObject
{
    if (!anObject) return;
    [self.safeLock lock];
    [self addObject:anObject];
    [self.safeLock unlock];
}

- (void)sh_safeRemoveAllObjects
{
    [self.safeLock lock];
    [self removeAllObjects];
    [self.safeLock unlock];
}

- (void)sh_safeRemoveLastObject
{
    [self.safeLock lock];
    [self removeLastObject];
    [self.safeLock unlock];
}

- (void)sh_safeRemoveObjectAtIndex:(NSUInteger)index
{
    [self.safeLock lock];
    if (![self _indexIsValid:index]) {
        [self.safeLock unlock];
        return;
    }
    [self removeObjectAtIndex:index];
    [self.safeLock unlock];
}

- (void)sh_safeRemoveObjectsAtIndexes:(NSIndexSet *)indexes
{
    if (!indexes) return;
    [self.safeLock lock];
    if (![self _indexSetIsValid:indexes]) {
        [self.safeLock unlock];
        return;
    }
    [self removeObjectsAtIndexes:indexes];
    [self.safeLock unlock];
}

- (void)sh_safeRemoveObjectsInArray:(NSArray *)otherArray
{
    if (!otherArray) return;
    [self.safeLock lock];
    [self removeObjectsInArray:otherArray];
    [self.safeLock unlock];
}

- (void)sh_safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject) return;
    [self.safeLock lock];
    if (![self _indexIsValid:index]) {
        [self.safeLock unlock];
        return;
    }
    [self insertObject:anObject atIndex:index];
    [self.safeLock unlock];
}

- (void)sh_safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (!objects || !indexes) return;
    [self.safeLock lock];
    if (![self _indexSetIsValid:indexes]) {
        [self.safeLock unlock];
        return;
    }
    [self insertObjects:objects atIndexes:indexes];
    [self.safeLock unlock];
}

- (void)sh_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (!anObject) return;
    [self.safeLock lock];
    if (![self _indexIsValid:index]) {
        [self.safeLock unlock];
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
    [self.safeLock unlock];
}

- (void)sh_safeReplaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (!indexes || !objects || indexes.count != objects.count) return;
    [self.safeLock lock];
    if (![self _indexSetIsValid:indexes]) {
        [self.safeLock unlock];
        return;
    }
    [self replaceObjectsAtIndexes:indexes withObjects:objects];
    [self.safeLock unlock];
}

- (void)sh_safeReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    if (!otherArray) return;
    [self.safeLock lock];
    if (![self _rangeIsValid:range]) {
        [self.safeLock unlock];
        return;
    }
    [self replaceObjectsInRange:range withObjectsFromArray:otherArray];
    [self.safeLock unlock];
}

- (void)sh_safeEnumerateObjectsUsingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block
{
    if (!block) return;
    [self.safeLock lock];
    [self enumerateObjectsUsingBlock:block];
    [self.safeLock unlock];
}

- (void)sh_safeEnumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block
{
    if (!s || !block) return;
    [self.safeLock lock];
    [self enumerateObjectsAtIndexes:s options:opts usingBlock:block];
    [self.safeLock unlock];
}

- (void)sh_safeEnumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block
{
    if (!block) return;
    [self.safeLock lock];
    [self enumerateObjectsWithOptions:opts usingBlock:block];
    [self.safeLock unlock];
}

- (BOOL)_indexIsValid:(NSInteger)index
{
    return (index >= 0 && index < self.count);
}

- (BOOL)_indexSetIsValid:(NSIndexSet *)indexSet
{
    BOOL valid = YES;
    if (indexSet.firstIndex >= self.count || indexSet.lastIndex >= self.count ||
        indexSet.count > self.count) {
        valid = NO;
    }
    return valid;
}

- (BOOL)_rangeIsValid:(NSRange)range
{
    BOOL valid = YES;
    if (range.location >= self.count || range.length > self.count ||
        range.length + range.location >= self.count) {
        valid = NO;
    }
    return valid;
}

@end
