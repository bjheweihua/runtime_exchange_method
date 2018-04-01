# runtime_exchange_method
runtime 系统方法替换(NSArray、NSMutableArray、NSDictionary、NSMutableDictionary)
防止NSArray因为调用objectAtIndex:方法，取下标时数组越界导致的崩溃.

在项目过程中，使用数组字典set/get, 由于经常忘记容错处理，导致线上代码崩溃而烦恼。
听说可以通过runtime hook系统方法，可以拦截系统方法，走自定义方法。
网上搜索了一下调用方法，发现并没有执行，好奇怪...

后来发现，__NSArrayI才是NSArray真正的类，__NSDictionaryM才是NSMutableDictionary真正的类。

参考资料：http://www.cocoachina.com/ios/20160121/15076.html

列举一些常用的类簇的“真身”：
![](https://github.com/bjheweihua/runtime_exchange_method/blob/master/demo.png)

[[NSArray alloc] init].class;              -> __NSArray0
@[@1].class;                                   ->  __NSSingleObjectArrayI
[NSArray new].class;                       ->  __NSArray0
NSArray.class;                                ->  NSArray
@[].class;                                         ->  __NSArray0
[[NSMutableArray alloc] init].class; ->  __NSArrayM
[NSMutableArray new].class;         ->  __NSArrayM
NSMutableArray.class;                  -> NSMutableArray

### 代码实现

1. 方法替换封装
```
#import "NSObject+Swizzle.h"
@implementation NSObject (Swizzle)
#ifndef __OPTIMIZE__
+ (BOOL)jr_swizzleMethod:(SEL)origSel withMethod:(SEL)aftSel {
    
    Method originMethod = class_getInstanceMethod(self, origSel);
    Method newMethod = class_getInstanceMethod(self, aftSel);
    
    //必须两个Method都要拿到
    if(originMethod && newMethod) {
        
        if(class_addMethod(self, origSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
            
            //实现成功添加后
            class_replaceMethod(self, aftSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        }
        else {
            method_exchangeImplementations(originMethod, newMethod);
        }
        return YES;
    }
    return NO;
}
#endif
@end
```


2. 系统方法替换具体实现
```
#import "NSArray+Swizzle.h"
#import "NSObject+Swizzle.h"

@implementation NSArray (Swizzle)

#ifndef __OPTIMIZE__

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class cls = objc_getClass("__NSArrayI");
        [cls jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(objectAtIndex_replace:)];
        //这里已经实现了方法替换，objectAtIndex:会调用objectAtIndex_replace:
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
```

