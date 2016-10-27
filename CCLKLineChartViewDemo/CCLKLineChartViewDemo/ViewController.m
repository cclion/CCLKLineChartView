//
//  ViewController.m
//  CCLKLineChartViewDemo
//
//  Created by Crisps on 16/10/27.
//  Copyright © 2016年 来一碗鸭汤. All rights reserved.
//

#import "ViewController.h"
#import "CCLKLineChartView.h"
#import "CCLTimeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CCLKLineChartView *klineChart = [[CCLKLineChartView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 250)
                                                                       secID:@"22"
                                                                     andtype:CCLKLineDay];
    [self.view addSubview:klineChart];
    
    CCLTimeView *timeView = [[CCLTimeView alloc]initWithFrame:CGRectMake(0, 320, [UIScreen mainScreen].bounds.size.width, 250)
                                                     andSecID:@"22"];
    [self.view addSubview:timeView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
