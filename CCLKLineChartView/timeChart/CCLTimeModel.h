//
//  CCLTimeModel.h
//  KlineChart
//
//  Created by Crisps on 16/10/8.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CCLTimeModel : NSObject

@property (nonatomic, copy) NSString *MAvgData;

@property (nonatomic, copy) NSString *barTime;


@property (nonatomic, assign) CGFloat closePrice;

@property (nonatomic, assign) CGFloat highPrice;

@property (nonatomic, assign) CGFloat lowPrice;

@property (nonatomic, assign) CGFloat openPrice;

@property (nonatomic, assign) CGFloat totalValue;

@property (nonatomic, assign) CGFloat totalVolume;

@end
