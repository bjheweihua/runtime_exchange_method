//
//  ViewController.m
//  runtime_exchange_method
//
//  Created by heweihua on 2018/3/16.
//  Copyright © 2018年 heweihua. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+ExchangeMethod.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray* arr = @[@"a", @"b", @"c"];
    NSString* string_a = [arr objectAtIndex:0];
    NSString* string_nulll = [arr objectAtIndex:3];
    NSLog(@"string_a = %@; string_nulll = %@",string_a, string_nulll);
    
    
    NSMutableArray *mutArr = [[NSMutableArray alloc] init];
    [mutArr addObject:@"test"];
    [mutArr addObject:nil];
    [mutArr insertObject:nil atIndex:0];
    
    NSLog(@"mutArr = %@", mutArr);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
