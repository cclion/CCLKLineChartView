//
//  CCLTimeBelowView.h
//  KlineChart
//
//  Created by Crisps on 16/9/28.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLTimeShareData.h"

@protocol CCLTimeBelowViewDelegate <NSObject>

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSUInteger)index andView:(UIView *)view;

@end

@interface CCLTimeBelowView : UIView

@property (nonatomic, strong) CCLTimeShareData *shareData;

@property (nonatomic, weak) id<CCLTimeBelowViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andShareData:(CCLTimeShareData *)shareData;

- (void)drawWithLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSUInteger )index;

@end
