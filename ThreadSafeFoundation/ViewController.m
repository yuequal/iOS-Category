//
//  ViewController.m
//  ThreadSafeFoundation
//
//  Created by yuxueqing on 2018/9/20.
//  Copyright © 2018年 yuxueqing. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableDictionary+SafeMethod.h"
#import "NSMutableArray+ThreadSafe.h"
#import "NSArray+SafeAction.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *narray = @[@"1",@"2"];
    id object = narray[4];
    id objet4 = [narray safeObjectAtIndex:4];
    id obj2 = [narray objectAtIndexedSubscript:1];
    id objc3 = [narray objectAtIndexedSubscript:10];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    array.safeLock = [[NSLock alloc] init];
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [array sh_safeObjectAtIndex:1];
        NSLog(@"2");
    });
    NSLog(@"3");
    [array sh_safeObjectAtIndex:10];
    NSLog(@"4");
    [array sh_safeRemoveObjectAtIndex:10];
    [array sh_safeAddObject:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [array sh_safeObjectAtIndex:1];
        NSLog(@"5");
    });
    [array sh_safeInsertObject:nil atIndex:10];
    [array sh_safeInsertObjects:nil atIndexes:[NSIndexSet indexSetWithIndex:10]];
    [array sh_safeRemoveObjectsAtIndexes:[NSIndexSet indexSetWithIndex:10]];
    [array sh_safeReplaceObjectAtIndex:10 withObject:nil];
    [array sh_safeReplaceObjectsAtIndexes:[NSIndexSet indexSetWithIndex:10] withObjects:nil];
    [array sh_safeReplaceObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)] withObjects:nil];
    [array sh_safeReplaceObjectsInRange:NSMakeRange(0, 10) withObjectsFromArray:nil];
    id obj = array[10];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
