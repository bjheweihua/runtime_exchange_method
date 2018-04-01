//
//  ViewController.m
//  runtime_exchange_method
//
//  Created by heweihua on 2018/3/16.
//  Copyright © 2018年 heweihua. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray* array = [[NSArray alloc] init];
    NSLog(@"[[NSArray alloc] init].class; -> %s \n", class_getName(array.class));

    NSArray* array1 = [[NSArray alloc] initWithObjects:@[], nil];
    NSLog(@"array1.class; ->  %s \n", class_getName(array1.class));
    
    NSArray* array2 = [[NSArray alloc] initWithObjects:@[@"11"], nil];
    NSLog(@"array2.class; -> %s \n", class_getName(array2.class));
    
    NSLog(@"[NSArray new].class; ->  %s \n", class_getName([NSArray new].class));
    NSLog(@"NSArray.class; ->  %s \n", class_getName(NSArray.class));
    NSLog(@"@[].class; ->  %s \n", class_getName(@[].class));
    NSLog(@"@[@1].class; ->  %s \n", class_getName(@[@1].class));

    
    NSMutableArray* array_m = [[NSMutableArray alloc] init];
    NSLog(@"[[NSMutableArray alloc] init].class; ->  %s \n", class_getName(array_m.class));
    
    NSMutableArray* array1_m = [[NSMutableArray alloc] initWithObjects:@[], nil];
    NSLog(@"array1_m.class; ->  %s \n", class_getName(array1_m.class));
    
    NSMutableArray* array2_m = [[NSMutableArray alloc] initWithObjects:@[@"11"], nil];
    NSLog(@"array2_m.class; ->  %s \n", class_getName(array2_m.class));
    
    NSLog(@"[NSMutableArray new].class; ->  %s \n", class_getName([NSMutableArray new].class));
    
    NSLog(@"NSMutableArray.class; ->%s \n", class_getName(NSMutableArray.class));
    

    NSArray* arr = @[@"a", @"b", @"c"];
    NSString* string_a = [arr objectAtIndex:0];
    NSString* string_nulll = [arr objectAtIndex:3];
    NSLog(@"string_a = %@; string_nulll = %@",string_a, string_nulll);
    
    
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    NSLog(@"[[NSMutableArray alloc] init].class = %@ ",  mutArr.class);
    [mutArr addObject:@"test"];
    [mutArr addObject:nil];
    NSString* obj = [mutArr objectAtIndex:mutArr.count];
    NSLog(@"obj3 = %@", obj);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
