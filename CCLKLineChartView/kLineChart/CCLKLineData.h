//
//  CCLKLineData.h
//  KlineChart
//
//  Created by Crisps on 16/8/24.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCLKLineData : NSObject

@property (nonatomic, copy) NSString *rise_and_fall_rate;

@property (nonatomic, copy) NSString *tradedate;

@property (nonatomic, copy) NSString *date_week;

@property (nonatomic, assign) CGFloat avg_5;

@property (nonatomic, assign) CGFloat avg_10;

@property (nonatomic, assign) CGFloat avg_20;

@property (nonatomic, assign) CGFloat total_value_trade;

@property (nonatomic, assign) CGFloat pre_close_px;

// 开盘 收盘
@property (nonatomic, assign) CGFloat openprice;

@property (nonatomic, assign) CGFloat closeprice;

// 最高 最低
@property (nonatomic, assign) CGFloat highestprice;

@property (nonatomic, assign) CGFloat lowestprice;

// 出手量
@property (nonatomic, assign) CGFloat turnovervol;

@property (nonatomic, assign) CGFloat rise_and_fall_value;

// 自己计算
@property (nonatomic, assign) CGFloat max;
@property (nonatomic, assign) CGFloat min;

// 是不是涨
@property (nonatomic, assign) BOOL isRise;
@end
