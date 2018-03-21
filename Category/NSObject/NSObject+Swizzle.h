//
//  NSObject+Swizzle.h
//  AFNetworking
//
//  Created by heweihua on 2018/3/15.
//  http://www.cocoachina.com/ios/20160121/15076.html

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Swizzle) 

#ifndef __OPTIMIZE__

/*
 实例方法
 */
+ (BOOL)jr_swizzleMethod:(SEL)origSel withMethod:(SEL)aftSel;

/*
 类方法
 */
//+ (BOOL)jr_swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)aftSel;

#endif

@end
