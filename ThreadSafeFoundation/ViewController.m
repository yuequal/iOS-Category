//
//  ViewController.m
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/20.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableDictionary+SafeMethod.h"
#import "NSMutableArray+SafeAction.h"
#import "NSArray+SafeAction.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *narray = @[@"1",@"2"];
    id object = narray[1];
    id obj2 = [narray objectAtIndexedSubscript:1];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    [array safeObjectAtIndex:10];
    [array safeRemoveObjectAtIndex:10];
    [array safeAddObject:nil];
    [array safeInsertObject:nil atIndex:10];
    [array safeInsertObjects:nil atIndexes:[NSIndexSet indexSetWithIndex:10]];
    [array safeRemoveObjectsAtIndexes:[NSIndexSet indexSetWithIndex:10]];
    [array safeReplaceObjectAtIndex:10 withObject:nil];
    [array safeReplaceObjectsAtIndexes:[NSIndexSet indexSetWithIndex:10] withObjects:nil];
    [array safeReplaceObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)] withObjects:nil];
    [array safeReplaceObjectsInRange:NSMakeRange(0, 10) withObjectsFromArray:nil];
    id obj = array[10];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
