//
//  CCLLineChartView.m
//  KlineChart
//
//  Created by Crisps on 16/9/6.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLKLineChartView.h"
#import "CCLKLineShareData.h"
#import "CCLKLineAboveView.h"
#import "CCLKLineBelowView.h"
@interface CCLKLineChartView ()
<
CCLKLineAboveViewDelegate,
CCLKLineBelowViewDelegate
>
@property (nonatomic, copy) NSString *secID;

@property (nonatomic, assign) CCLKLineType type;

@property (nonatomic, strong) CCLKLineShareData *shareData;

@property (nonatomic, strong) CCLKLineAboveView *aboveView;

@property (nonatomic, strong) CCLKLineBelowView *belowView;


@end

@implementation CCLKLineChartView

- (instancetype)initWithFrame:(CGRect)frame secID:(NSString *)secID andtype:(CCLKLineType)type{
    if (self = [super initWithFrame:frame]) {
        _secID = secID;
        _type = type;
        
        // 旋转
        [self addSubview:self.aboveView];
        self.aboveView.transform = CGAffineTransformMakeRotation( M_PI * 0.5);
        self.aboveView.frame = CGRectMake(0, 0, self.shareData.aboveHeight, self.shareData.aboveWidth);
        
        [self addSubview:self.belowView];
        self.belowView.transform = CGAffineTransformMakeRotation( M_PI * 0.5);
        self.belowView.frame = CGRectMake(0, self.shareData.aboveWidth +20, self.shareData.belowHeight, self.shareData.belowWidth);

        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return self;
}


- (CCLKLineShareData *)shareData{
    if (_shareData == nil) {
        _shareData = [[CCLKLineShareData alloc] init];
        _shareData.aboveHeight = self.bounds.size.width;
        _shareData.aboveWidth = self.bounds.size.height *0.6;

        _shareData.gap = 10;
        _shareData.currHeight = 10;
 
        _shareData.belowHeight = self.bounds.size.width;
        _shareData.belowWidth = self.bounds.size.height * 0.3;

    }
    return _shareData;
}

#pragma mark - 滑动
- (void)KLineViewDidScroll:(UITableView *)tableView{
    
    if (tableView == self.aboveView) {
        [self.belowView setContentOffset:self.aboveView.contentOffset];
    }else if (tableView == self.belowView){
        [self.aboveView setContentOffset:self.belowView.contentOffset];
    }
    
}


#pragma mark - 捏合
- (void)reloadDate:(UITableView *)tableView{
    if (tableView == self.aboveView) {
        [self.belowView reloadData];
        [self.belowView setContentOffset:self.aboveView.contentOffset];
    }else if (tableView == self.belowView){
        [self.aboveView reloadData];
        [self.aboveView setContentOffset:self.belowView.contentOffset];
    }
}


#pragma mark - 长按
- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSIndexPath *)indexPath andTableView:(UITableView *)tableView{
    if (tableView == self.aboveView) {
        [self.belowView drawWithLongPress:gestureRecognizer forIndex:indexPath];
        
    }else if (tableView == self.belowView){
        [self.aboveView drawWithLongPress:gestureRecognizer forIndex:indexPath];
    }
}


- (CCLKLineAboveView *)aboveView{
    if (_aboveView == nil) {
        _aboveView = [[CCLKLineAboveView  alloc] initWithFrame:CGRectMake(0, 0, self.shareData.aboveWidth, self.shareData.aboveHeight) andShareData:self.shareData];
        _aboveView.layer.borderWidth = 1;
        _aboveView.layer.borderColor = [UIColor blackColor].CGColor;
        _aboveView.kDelegate = self;
    }
    return _aboveView;
}


- (CCLKLineBelowView *)belowView{
    if (_belowView == nil) {
        _belowView = [[CCLKLineBelowView  alloc] initWithFrame:CGRectMake(0 , self.shareData.aboveWidth +20 , self.shareData.belowWidth, self.shareData.belowHeight) andShareData:self.shareData];
        _belowView.layer.borderWidth = 1;
        _belowView.layer.borderColor = [UIColor blackColor].CGColor;
        _belowView.kDelegate = self;
    }
    return _belowView;
}




@end
