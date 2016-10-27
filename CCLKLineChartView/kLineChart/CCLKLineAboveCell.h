//
//  CCLKLineAboveCell.h
//  KlineChart
//
//  Created by Crisps on 16/9/6.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLKLineData.h"
#import "CCLKLineShareData.h"

@interface CCLKLineAboveCell : UITableViewCell

@property (nonatomic, strong) CCLKLineData *data;

@property (nonatomic, strong) CCLKLineData *lastData; // 可选数据，展示均线

@property (nonatomic, strong) CCLKLineData *nextData; // 可选数据，展示均线


@property (nonatomic, strong) CATextLayer *textLayer;

@property (nonatomic, assign) BOOL isShowDay;


@property (nonatomic, strong) CCLKLineShareData *shareData; // 必须最先赋值

- (void)setData:(CCLKLineData *)data max:(CGFloat )max andMin:(CGFloat)min;

- (void)setindex:(NSUInteger)row;




@end
