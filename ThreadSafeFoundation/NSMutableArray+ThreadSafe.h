//
//  NSMutableArray+ThreadSafe.h
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/20.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (ThreadSafe)

@property (nonatomic,strong) NSLock *safeLock;

- (id)sh_safeObjectAtIndex:(NSUInteger)index;

- (id)sh_safeObjectAtIndexedSubscript:(NSUInteger)idx;

- (void)sh_safeAddObject:(id)anObject;

- (void)sh_safeRemoveAllObjects;

- (void)sh_safeRemoveLastObject;

- (void)sh_safeRemoveObjectAtIndex:(NSUInteger)index;

- (void)sh_safeRemoveObjectsAtIndexes:(NSIndexSet *)indexes;

- (void)sh_safeRemoveObjectsInArray:(NSArray *)otherArray;

- (void)sh_safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)sh_safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;

- (void)sh_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (void)sh_safeReplaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects;

- (void)sh_safeReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;

- (void)sh_safeEnumerateObjectsUsingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block;

- (void)sh_safeEnumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block;

- (void)sh_safeEnumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, NSUInteger, BOOL * _Nonnull))block;

@end
