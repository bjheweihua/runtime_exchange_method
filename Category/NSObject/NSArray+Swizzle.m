//
//  NSArray+Swizzle.m
//  JDMobile
//
//  Created by heweihua on 2018/3/15.
//

#import "NSArray+Swizzle.h"
#import "NSObject+Swizzle.h"

//https://blog.csdn.net/zyx196/article/details/49493029
//https://www.aopod.com/2017/02/24/class-clusters/
//https://developer.apple.com/library/content/documentation/General/Conceptual/CocoaEncyclopedia/ClassClusters/ClassClusters.html
//http://www.cocoachina.com/ios/20160121/15076.html

@implementation NSArray (NSArraySwizzle)

#ifndef __OPTIMIZE__

+ (void)load {
    
//    NSString *className = NSStringFromClass(self.class);
//    NSLog(@"classname %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [objc_getClass("__NSArrayI") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(objectAtIndexI:)];
        [objc_getClass("__NSArray0") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(objectAtIndex0:)];
        [objc_getClass("__NSSingleObjectArrayI") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(objectAtIndexSingle:)];
        [objc_getClass("__NSPlaceholderArray") jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(objectAtIndexPlaceholder:)];
    });
}


//- (nullable id) objectAtIndex:(unsigned)index{
//
//    if (index >= [self count])
//        return nil;
//    else
//        return [self objectAtIndex:index];
//}


- (nullable id)objectAtIndexI:(NSInteger)index{

//    NSLog(@"%s ; %s , [self count] = %@ \n", class_getName(self.class), __func__, @([self count]));
    if (index >= [self count])
        return nil;
    else
        return [self objectAtIndexI:index];
}

- (nullable id)objectAtIndex0:(NSInteger)index{
    
//    NSLog(@"%s ; %s , [self count] = %@ \n", class_getName(self.class), __func__, @([self count]));
    if (index >= [self count])
        return nil;
    else
        return [self objectAtIndex0:index];
}

- (nullable id)objectAtIndexSingle:(NSInteger)index{
    
//    NSLog(@"%s ; %s , [self count] = %@ \n", class_getName(self.class), __func__, @([self count]));
    if (index >= [self count])
        return nil;
    else
        return [self objectAtIndexSingle:index];
}

- (nullable id)objectAtIndexPlaceholder:(NSInteger)index{
    
//    NSLog(@"%s ; %s , [self count] = %@ \n", class_getName(self.class), __func__, @([self count]));
    if (index >= [self count])
        return nil;
    else
        return [self objectAtIndexPlaceholder:index];
}
#endif

@end


@implementation NSMutableArray (NSMutableArraySwizzle)

#ifndef __OPTIMIZE__

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("__NSArrayM");
        [cls jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(objectAtIndexM:)];
        [cls jr_swizzleMethod:@selector(addObject:) withMethod:@selector(addObjectM:)];
//        [cls jr_swizzleMethod:@selector(insertObject:atIndex:) withMethod:@selector(insertObjectM:atIndex:)];
    });
}

- (nullable id)objectAtIndexM:(NSInteger)index{
    
//    NSLog(@"%s ; %s \n", class_getName(self.class), __func__);
    if (index >= [self count])
        return nil;
    else
        return [self objectAtIndexM:index];
}


- (void)addObjectM:(nonnull id)anObject{
    
//    NSLog(@"%s ; %s \n", class_getName(self.class), __func__);
    if (!anObject)
        return;
    [self addObjectM:anObject];
}

/*
#warning 这个方法实现起来有问题
- (void)insertObjectM:(nonnull id)anObject atIndex:(NSUInteger)index{
    
    NSLog(@"%s ; %s \n", class_getName(self.class), __func__);
    if (!anObject)
        return;
    if (index >= [self count])
        return;
    [self insertObjectM:anObject atIndex:index];
}
*/
#endif

@end








