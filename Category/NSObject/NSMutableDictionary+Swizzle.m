//
//  NSMutableDictionary+Swizzle.m
//  runtime_exchange_method
//
//  Created by heweihua on 2018/3/16.
//  Copyright © 2018年 heweihua. All rights reserved.
//

#import "NSMutableDictionary+Swizzle.h"
#import "NSObject+Swizzle.h"

@implementation NSMutableDictionary (Swizzle)

#ifndef __OPTIMIZE__

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("__NSDictionaryM");
        [cls jr_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(setObject_replace:forKey:)];
    });
}


- (void)setObject_replace:(nonnull id)anObject forKey:(nonnull id <NSCopying>)aKey{
    
    if(!anObject || !aKey) return;
    
    [self setObject_replace:anObject forKey:aKey];
}
#endif

@end
