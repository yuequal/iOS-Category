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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSDictionary *ddcic = @{@"ke":@"2"};
//    [ddcic objectForKey:nil];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"ke1":@"1"}];
    [dic setValue:nil forKey:@"ke1"];
    [dic objectForKey:nil];
    [dic objectForKeyedSubscript:nil];
    [dic removeObjectsForKeys:@[@"22"]];
    [dic addEntriesFromDictionary:nil];
    [dic setValuesForKeysWithDictionary:nil];
//    NSLog(@"%@",[dic objectForKey:@"ke3"]);

//    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
//    [array removeObject:nil];
//    [array removeObjectsInArray:@[@"2",@"3"]];
//    [array replaceObjectsInRange:NSMakeRange(0, 1) withObjectsFromArray:@[@"4",@"6",@"8"]];
//    [array replaceObjectsAtIndexes:[NSIndexSet indexSetWithIndex:1] withObjects:@[@"3",@"5"]];
//    [array removeObjectsInArray:@[@"1",@"3",@"5",@"6"]];
//    [array insertObjects:nil atIndexes:[NSIndexSet indexSetWithIndex:1]];
//    [array addObject:nil];
//    [array insertObject:nil atIndex:1];
//    [array setObject:nil atIndexedSubscript:1];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11", nil];
    array.safeLock = [NSLock new];
    [array sh_safeObjectAtIndex:100];
    [array sh_safeRemoveObjectAtIndex:10];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [array sh_safeRemoveObjectAtIndex:10];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [array sh_safeRemoveObjectAtIndex:10];
    });
    [array sh_safeRemoveObjectAtIndex:10];
    NSLog(@"dee ");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
