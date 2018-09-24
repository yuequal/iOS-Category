//
//  SafeMethodSwizzle.m
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/23.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import "SafeMethodSwizzle.h"
#import <objc/runtime.h>

@implementation SafeMethodSwizzle

//static IMP GetOriginalMethodIMP(id self, SEL cmd)
//{
//    Class kclass = [self class];
//
//}

+ (void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL class:(Class)cls
{
    
    Method originalMethod = class_getInstanceMethod(cls, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSEL);
    
    BOOL success =
    class_addMethod(cls,
                    originalSEL,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (success) {
        class_replaceMethod(cls,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
