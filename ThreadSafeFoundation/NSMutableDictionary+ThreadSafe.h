//
//  NSMutableDictionary+ThreadSafe.h
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/21.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (ThreadSafe)

@property (nonatomic, strong) NSLock *safeLock;

- (id)sh_safeObjectForKey:(id)aKey;

- (id)sh_safeObjectForKeyedSubscript:(id)key;

- (void)sh_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)sh_safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;

- (void)sh_safeRemoveObjectForKey:(id)aKey;

- (void)sh_safeRemoveAllObjects;

- (void)sh_safeRemoveObjectsForKeys:(NSArray *)keyArray;

- (void)sh_safeSetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues;

- (void)sh_safeAddEntriesFromDictionary:(NSDictionary *)otherDictionary;

- (void)sh_safeEnumerateKeysAndObjectsUsingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block;

- (void)sh_safeEnumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id _Nonnull, id _Nonnull, BOOL * _Nonnull))block;

@end
