//
//  NSArray+SafeAction.h
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/20.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeAction)

- (id)safeObjectAtIndex:(NSUInteger)index;

- (id)safeObjectAtIndexedSubscript:(NSUInteger)index;

@end
