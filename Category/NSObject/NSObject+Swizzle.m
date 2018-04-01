//
//  NSObject+Swizzle.m
//  AFNetworking
//
//  Created by heweihua on 2018/3/15.
//

#import "NSObject+Swizzle.h"

@implementation NSObject (Swizzle)

#ifndef __OPTIMIZE__

+ (BOOL)jr_swizzleMethod:(SEL)origSel withMethod:(SEL)aftSel {
    
    Method originMethod = class_getInstanceMethod(self.class, origSel);
    Method newMethod = class_getInstanceMethod(self.class, aftSel);
    
    //必须两个Method都要拿到
    if(originMethod && newMethod) {
        
        if(class_addMethod(self.class, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            
            //实现成功添加后
            class_replaceMethod(self.class, aftSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        }
        else {
            method_exchangeImplementations(originMethod, newMethod);
        }
        return YES;
    }
    return NO;
}


/*
 类方法
 */
//+ (BOOL)jr_swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)aftSel{
//
//    Method originMethod = class_getClassMethod(self, origSel);
//    Method newMethod = class_getClassMethod(self, aftSel);
//    if(originMethod && newMethod) {
//
//        if(class_addMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
//
//            //实现成功添加后
//            class_replaceMethod(self, aftSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
//        }
//        else {
//            method_exchangeImplementations(originMethod, newMethod);
//        }
//        return YES;
//    }
//    return NO;
//}

#endif

@end
