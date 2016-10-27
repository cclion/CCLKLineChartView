//
//  CCLKLineShareData.h
//  KlineChart
//
//  Created by Crisps on 16/9/6.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCLKLineShareData : NSObject

@property (nonatomic, assign) CGFloat aboveMax;

@property (nonatomic, assign) CGFloat abovemin;

@property (nonatomic, assign) CGFloat currHeight;

@property (nonatomic, assign) CGFloat aboveHeight;

@property (nonatomic, assign) CGFloat aboveWidth;

@property (nonatomic, assign) CGFloat belowMax;

@property (nonatomic, assign) CGFloat belowHeight;

@property (nonatomic, assign) CGFloat belowWidth;

@property (nonatomic, assign) CGFloat gap;

@end
