//
//  NSArray+Swizzle.m
//  JDMobile
//
//  Created by heweihua on 2018/3/15.
//

#import "NSArray+Swizzle.h"
#import "NSObject+Swizzle.h"

@implementation NSArray (Swizzle)

#ifndef __OPTIMIZE__

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("__NSArrayI");
        [cls jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(objectAtIndex_replace:)];
        //这里已经实现了方法替换，objectAtIndex:会调用objectAtIndexCheck:
    });
}


//防止数组越界
- (nullable id)objectAtIndex_replace:(NSInteger)index{

    if (self.count-1 < index) {
        return nil;
    }

    id value = [self objectAtIndex_replace:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}
#endif

@end


@implementation NSMutableArray (ExchangeMethod)

#ifndef __OPTIMIZE__

+ (void)load {
    
//    NSString *className = NSStringFromClass(self.class);
//    NSLog(@"classname %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("__NSArrayM");
        [cls jr_swizzleMethod:@selector(addObject:) withMethod:@selector(addObject_replace:)];
        [cls jr_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(insertObject_replace:atIndex:)];
    });
}

- (void)addObject_replace:(nonnull id)anObject{
    
    if (!anObject)
        return;
    [self addObject_replace:anObject];
}

- (void)insertObject_replace:(nonnull id)anObject atIndex:(NSUInteger)index{
    
    if (!anObject)
        return;

    if (index > self.count)
        return;
    [self insertObject_replace:anObject atIndex:index];
}

#endif

@end





