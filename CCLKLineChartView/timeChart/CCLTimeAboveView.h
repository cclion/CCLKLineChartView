//
//  CCLTimeAboveView.h
//  KlineChart
//
//  Created by Crisps on 16/9/28.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCLTimeShareData.h"

@protocol CCLTimeAboveViewDelegate <NSObject>

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSUInteger)index andView:(UIView *)view;

@end


@interface CCLTimeAboveView : UIView

@property (nonatomic, strong) CCLTimeShareData *shareData;

@property (nonatomic, weak) id<CCLTimeAboveViewDelegate>  delegate;

- (instancetype)initWithFrame:(CGRect)frame andShareData:(CCLTimeShareData *)shareData;

- (void)drawWithLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSUInteger )index;

@end
