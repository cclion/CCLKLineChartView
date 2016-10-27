//
//  CCLTimeView.m
//  KlineChart
//
//  Created by Crisps on 16/9/28.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLTimeView.h"
#import "CCLTimeAboveView.h"
#import "CCLTimeBelowView.h"
#import "CCLTimeShareData.h"

@interface CCLTimeView ()
<CCLTimeAboveViewDelegate,
CCLTimeBelowViewDelegate>

@property (nonatomic, strong) CCLTimeShareData *shareData;

@property (nonatomic, strong) CCLTimeAboveView *aboveView;

@property (nonatomic, strong) CCLTimeBelowView *belowView;

@end


@implementation CCLTimeView

- (instancetype)initWithFrame:(CGRect)frame andSecID:(NSString *)secID{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.aboveView];
        [self addSubview:self.belowView];

        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return self;
}

- (CCLTimeAboveView *)aboveView{
    if (_aboveView == nil) {
        _aboveView = [[CCLTimeAboveView alloc] initWithFrame:CGRectMake(0, 0, self.shareData.allWidth, self.shareData.aboveHeight) andShareData:self.shareData];
        _aboveView.layer.borderWidth = 1;
        _aboveView.layer.borderColor = [UIColor blackColor].CGColor;
        _aboveView.delegate = self;
    }
    return _aboveView;
}

- (CCLTimeBelowView *)belowView{
    if (_belowView == nil) {
        _belowView = [[CCLTimeBelowView alloc] initWithFrame:CGRectMake(0, self.shareData.aboveHeight + 20, self.shareData.allWidth, self.shareData.belowHeight) andShareData:self.shareData];
        _belowView.layer.borderWidth = 1;
        _belowView.layer.borderColor = [UIColor blackColor].CGColor;
        _belowView.delegate = self;
    }
    return _belowView;
}

#pragma mark - 长按
- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSUInteger)index andView:(UIView *)view{
    if (view == self.aboveView) {
        [self.belowView drawWithLongPress:gestureRecognizer forIndex:index];
        
    }else if (view == self.belowView){
        [self.aboveView drawWithLongPress:gestureRecognizer forIndex:index];
    }
}


- (CCLTimeShareData *)shareData{
    if (_shareData == nil) {
        _shareData = [[CCLTimeShareData alloc] init];
        
        _shareData.allWidth = self.bounds.size.width;
        
        _shareData.aboveHeight = self.bounds.size.height * 0.6;
        _shareData.belowHeight = self.bounds.size.height * 0.3;
        
        _shareData.gap = 10;
        
    }
    return _shareData;
}


@end
