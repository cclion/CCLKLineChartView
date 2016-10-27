//
//  CCLKLineBelowView.m
//  KlineChart
//
//  Created by Crisps on 16/9/7.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLKLineBelowView.h"
#import "CCLKLineData.h"
#import "CCLFrameTool.h"
#import "MJExtension.h"
#import "CCLKLineBelowCell.h"
@interface CCLKLineBelowView ()
<UITableViewDelegate,
UITableViewDataSource,
UIGestureRecognizerDelegate>


// 展示数据
@property (nonatomic, strong) NSArray *dataArr;

/**
 * 成交量
 */
@property (nonatomic, strong) CATextLayer *markTextLayer;

/**
 * 最大值显示
 */
@property (nonatomic, strong) CATextLayer *maxTextLayer;

/**
 *  选中的row
 */
@property (nonatomic, assign) NSUInteger selRow;

/**
 * 长按信息横向
 */
@property (nonatomic, strong) CAShapeLayer *horizontalLine;

@end

@implementation CCLKLineBelowView

- (CATextLayer *)markTextLayer{
    if (_markTextLayer == nil) {
        _markTextLayer = [CATextLayer layer];
        _markTextLayer.foregroundColor = [UIColor blackColor].CGColor;
        _markTextLayer.backgroundColor = [UIColor greenColor].CGColor;
        _markTextLayer.alignmentMode = kCAAlignmentLeft;
        _markTextLayer.fontSize = 9.f; //字体的大小
        _markTextLayer.contentsScale = [UIScreen mainScreen].scale;
        
        NSString *text = @"成交量";
        _markTextLayer.string = text;
        // 计算高度
        UIFont *font = [UIFont systemFontOfSize:9];
        CGSize textSize = [text sizeWithFont:font];
        _markTextLayer.bounds = CGRectMake(0, 0, 30, 20);

    }
    return _markTextLayer;
}

- (CATextLayer *)maxTextLayer{
    if (_maxTextLayer == nil) {
        _maxTextLayer = [CATextLayer layer];
        _maxTextLayer = [CATextLayer layer];
        _maxTextLayer.foregroundColor = [UIColor blackColor].CGColor;
        //        _maxTextLayer.backgroundColor = [UIColor greenColor].CGColor;
        _maxTextLayer.alignmentMode = kCAAlignmentRight;
        _maxTextLayer.fontSize = 9.f; //字体的大小
        _maxTextLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _maxTextLayer;
}

- (CAShapeLayer *)horizontalLine{
    
    if (_horizontalLine == nil) {
        _horizontalLine = [CAShapeLayer layer];
        _horizontalLine.strokeColor = [UIColor blueColor].CGColor;
        _horizontalLine.lineWidth = 0.5;
    }
    return _horizontalLine;
}

- (instancetype)initWithFrame:(CGRect)frame andShareData:(CCLKLineShareData *)shareData{
    if (self = [super initWithFrame:frame]) {
        
        _shareData = shareData;
        
        self.delegate = self;
        self.dataSource = self;
        
        
        NSString * path =[[NSBundle mainBundle]pathForResource:@"stockData.plist" ofType:nil];
        NSArray * sourceArray = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"data"];
        self.dataArr = [CCLKLineData mj_objectArrayWithKeyValuesArray:sourceArray];
        NSLog(@"%@",self.dataArr);
        [self registerClass:[CCLKLineBelowCell class] forCellReuseIdentifier:@"CCLKLineBelowCell"];
        
//        _lastHeight = 10;
//        _currHeight = 10;
//        self.shareData.currHeight  = _currHeight;
//        
//        NSArray *smallArray = [self.dataArr subarrayWithRange:NSMakeRange(0, 20)];
//        [self getPeakWithArray:smallArray];
//        
        [self drawBackLine];
        
//        UIPinchGestureRecognizer* gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
//                                                                                      action:@selector(scaleTableView:)];
//        [self addGestureRecognizer:gesture];
//        
        UILongPressGestureRecognizer *longPressReger = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                     action:@selector(handleLongPress:)];
        longPressReger.minimumPressDuration = 0.3f;
        longPressReger.delegate = self;
        [self addGestureRecognizer:longPressReger];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

#pragma mark -  长按手势
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
    CGPoint p = [gestureRecognizer locationInView:self];
    
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:p];//获取响应的长按的indexpath
    
    [self drawWithLongPress:gestureRecognizer forIndex:indexPath];
    if ([self.kDelegate respondsToSelector:@selector(handleLongPress:forIndex:andTableView:)]) {
        [self.kDelegate handleLongPress:gestureRecognizer forIndex:indexPath andTableView:self];
    }
    
}

- (void)drawWithLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSIndexPath *)indexPath{
    CGRect rect = [self rectForRowAtIndexPath:indexPath];
    
    if (gestureRecognizer.state == 1) {
        self.selRow = indexPath.row;
        [self reloadCrossLineWith:indexPath];
    }else if (gestureRecognizer.state == 3){
        
        self.horizontalLine.path = nil;

    }else{
        if (indexPath.row != self.selRow) {
            self.selRow = indexPath.row;
            [self reloadCrossLineWith:indexPath];
        }
    }
    
    if (indexPath == nil)
        NSLog(@"long press on table view but not on a row");
    else
        NSLog(@"long press on table view at row %ld --- rect %@", (long)indexPath.row, NSStringFromCGRect(rect));
}

- (void)reloadCrossLineWith:(NSIndexPath *)indexPath{
    CGRect rect = [self rectForRowAtIndexPath:indexPath];
    // 计算出中心点
    
    CGFloat y = rect.origin.y + rect.size.height / 2;

    UIBezierPath *path_h = [[UIBezierPath alloc] init];
    [path_h moveToPoint:CGPointMake(0, y)];
    [path_h addLineToPoint:CGPointMake(self.shareData.aboveWidth, y)];
    
    self.horizontalLine.path =path_h.CGPath;
    [self.layer addSublayer: self.horizontalLine];

}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  self.shareData.currHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    return [UITableViewCell new];
    
    NSArray *arr = [self indexPathsForVisibleRows];
    
    NSIndexPath *first = [arr firstObject];
    NSIndexPath *last = [arr lastObject];
    
    
//    NSArray *smallArray = [self.dataArr subarrayWithRange:NSMakeRange(first.row, last.row - first.row)];
    
//    [self getPeakWithArray:smallArray];
    
    CCLKLineBelowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCLKLineBelowCell"];
    
    cell.shareData = self.shareData;
    CCLKLineData *data = self.dataArr[indexPath.row];
    cell.data = data;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


- (void)drawBackLine{
    

    [self.layer addSublayer:self.markTextLayer];
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    [self.markTextLayer setAffineTransform:transform];
    
    CGRect frame = CGRectMake(0, self.contentOffset.y + self.bounds.size.height - 30, 13, 30);
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    self.markTextLayer.frame = frame;
    [CATransaction commit];
    
    if (self.shareData.belowMax) {
        [self.layer addSublayer:self.maxTextLayer];
        self.maxTextLayer.string = [NSString stringWithFormat:@"%.2f万",self.shareData.belowMax/10000];
        CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        [self.maxTextLayer setAffineTransform:transform];
        CGRect frame = CGRectMake(0, self.contentOffset.y, 14, 60);
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        self.maxTextLayer.frame = frame;
        [CATransaction commit];
    }

    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.kDelegate respondsToSelector:@selector(KLineViewDidScroll:)]) {
        [self.kDelegate KLineViewDidScroll:self];
    }
     [self drawBackLine];
}


@end
