//
//  SafeMethodSwizzle.h
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/23.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SafeMethodSwizzle : NSObject

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL class:(Class)cls;

@end
