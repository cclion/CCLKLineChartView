//
//  CCLLineChartView.h
//  KlineChart
//
//  Created by Crisps on 16/9/6.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 K线类型
 */
typedef enum : NSUInteger {
    CCLKLineDay,
    CCLKLineWeek,
    CCLKLineMonth,
} CCLKLineType;


@interface CCLKLineChartView : UIView

- (instancetype)initWithFrame:(CGRect)frame secID:(NSString *)secID andtype:(CCLKLineType)type;

@end
