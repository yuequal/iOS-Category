//
//  NSMutableArray+SafeAction.h
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/20.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SafeAction)

- (id)safeObjectAtIndex:(NSUInteger)index;

- (id)safeObjectAtIndexedSubscript:(NSUInteger)idx;

- (void)safeAddObject:(id)anObject;

- (void)safeRemoveObjectAtIndex:(NSUInteger)index;

- (void)safeRemoveObjectsAtIndexes:(NSIndexSet *)indexes;

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes;

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

- (void)safeReplaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects;

- (void)safeReplaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray;

@end
