//
//  NSMutableArray+SafeAction.m
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/20.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import "NSMutableArray+SafeAction.h"
#import "SafeMethodSwizzle.h"

@implementation NSMutableArray (SafeAction)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[SafeMethodSwizzle class] swizzleSEL:@selector(objectAtIndexedSubscript:) withSEL:@selector(safeObjectAtIndexedSubscript:) class:NSClassFromString(@"__NSArrayM")];
    });
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (![self _indexIsValid:index]) return nil;
    return [self objectAtIndex:index];
}

- (id)safeObjectAtIndexedSubscript:(NSUInteger)index
{
    if (![self _indexIsValid:index]) return nil;
    return [self safeObjectAtIndexedSubscript:index];
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if (![self _indexIsValid:index]) return ;
    [self removeObjectAtIndex:index];
}

- (void)safeRemoveObjectsAtIndexes:(NSIndexSet *)indexes
{
    if (!indexes || ![self _indexSetIsValid:indexes]) return;
    [self removeObjectsAtIndexes:indexes];
}

- (void)safeAddObject:(id)anObject
{
    if (!anObject) return;
    [self addObject:anObject];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject || ![self _indexIsValid:index]) return ;
    [self insertObject:anObject atIndex:index];
}

- (void)safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (!objects || ![self _indexSetIsValid:indexes]) return;
    [self insertObjects:objects atIndexes:indexes];
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (!anObject || ![self _indexIsValid:index]) return ;
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)safeReplaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (!objects || !indexes || ![self _indexSetIsValid:indexes] ||
        indexes.count != objects.count) return;
    [self replaceObjectsAtIndexes:indexes withObjects:objects];
}

- (void)safeReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    if ( range.length > self.count   ||
         range.location >= self.count ||
         range.length + range.location >= self.count) return;
    [self replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

- (BOOL)_indexIsValid:(NSInteger)index
{
    return (index >= 0 && index < self.count);
}

- (BOOL)_indexSetIsValid:(NSIndexSet *)indexSet
{
    BOOL valid = YES;
    if (indexSet.firstIndex >= self.count ||
        indexSet.lastIndex >= self.count ||
        indexSet.count > self.count) {
        valid = NO;
    }
    return valid;
}

@end
