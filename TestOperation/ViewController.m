//
//  ViewController.m
//  TestOperation
//
//  Created by isoftstone on 16/3/4.
//  Copyright © 2016年 isoftstone. All rights reserved.
//

#import "ViewController.h"

#import "T1Operation.h"
#import "T2Operation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    
    //SHOperation *test1 = [[SHOperation alloc] init];
    
    //[queue addOperation:test1];
    
    T1Operation *t1 = [[T1Operation alloc] init];
    [queue addOperation:t1];
    
    T2Operation *t2 = [[T2Operation alloc] init];
    [queue addOperation:t2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
