//
//  NSMutableDictionary+SafeMethod.h
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/21.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SafeMethod)

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key;

- (void)safeRemoveObjectForKey:(id)aKey;

@end
