//
//  CCLKLineAboveView.m
//  KlineChart
//
//  Created by Crisps on 16/9/6.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLKLineAboveView.h"
#import "CCLKLineData.h"
#import "CCLFrameTool.h"
#import "MJExtension.h"

#import "CCLKLineAboveCell.h"

@interface CCLKLineAboveView ()
<UITableViewDelegate,
UITableViewDataSource,
UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat max;

@property (nonatomic, assign) CGFloat min;

@property (nonatomic, assign) CGFloat belowMax;

// 上一次结束时的高度
@property (nonatomic, assign) CGFloat lastHeight;
// 当前展示的高度
@property (nonatomic, assign) CGFloat currHeight;
// 展示数据
@property (nonatomic, strong) NSArray *dataArr;

/**
 * 长按信息横向
 */
@property (nonatomic, strong) CAShapeLayer *horizontalLine;
/**
 * 长按信息纵向
 */
@property (nonatomic, strong) CAShapeLayer *verticalLine;
/**
 *  选中的row
 */
@property (nonatomic, assign) NSUInteger selRow;
/**
 * 背景图纵向
 */
@property (nonatomic, strong) CAShapeLayer *backLine;

/**
 * 最大值
 */
@property (nonatomic, strong) CAShapeLayer *maxLine;

/**
 * 最小值
 */
@property (nonatomic, strong) CAShapeLayer *minLine;

/**
 * 不复权
 */
@property (nonatomic, strong) CATextLayer *markTextLayer;

/**
 * 最大值显示
 */
@property (nonatomic, strong) CATextLayer *maxTextLayer;

/**
 * 最大值显示
 */
@property (nonatomic, strong) CATextLayer *minTextLayer;

/**
 * 中值显示
 */
@property (nonatomic, strong) CATextLayer *midTextLayer;



@end

@implementation CCLKLineAboveView


- (CAShapeLayer *)backLine{
    
    if (_backLine == nil) {
        _backLine = [CAShapeLayer layer];
        _backLine.strokeColor = [UIColor grayColor].CGColor;
        _backLine.lineWidth = 0.5;
    }
    return _backLine;
}

- (CAShapeLayer *)maxLine{
    
    if (_maxLine == nil) {
        _maxLine = [CAShapeLayer layer];
        _maxLine.strokeColor = [UIColor grayColor].CGColor;
        _maxLine.lineWidth = 0.5;
    }
    return _maxLine;
}
- (CAShapeLayer *)minLine{
    
    if (_minLine == nil) {
        _minLine = [CAShapeLayer layer];
        _minLine.strokeColor = [UIColor grayColor].CGColor;
        _minLine.lineWidth = 0.5;
    }
    return _minLine;
}


- (CATextLayer *)markTextLayer{
    if (_markTextLayer == nil) {
        _markTextLayer = [CATextLayer layer];
        _markTextLayer.foregroundColor = [UIColor blackColor].CGColor;
        _markTextLayer.backgroundColor = [UIColor greenColor].CGColor;
        _markTextLayer.alignmentMode = kCAAlignmentLeft;
        _markTextLayer.fontSize = 9.f; //字体的大小
        _markTextLayer.contentsScale = [UIScreen mainScreen].scale;
        
        NSString *text = @"不复权";
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

-(CATextLayer *)minTextLayer{
    if (_minTextLayer == nil) {
        _minTextLayer = [CATextLayer layer];
        _minTextLayer = [CATextLayer layer];
        _minTextLayer.foregroundColor = [UIColor blackColor].CGColor;
//        _minTextLayer.backgroundColor = [UIColor greenColor].CGColor;
        _minTextLayer.alignmentMode = kCAAlignmentRight;
        _minTextLayer.fontSize = 9.f; //字体的大小
        _minTextLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _minTextLayer;
}

-(CATextLayer *)midTextLayer{
    if (_midTextLayer == nil) {
        _midTextLayer = [CATextLayer layer];
        _midTextLayer = [CATextLayer layer];
        _midTextLayer.foregroundColor = [UIColor blackColor].CGColor;
//        _midTextLayer.backgroundColor = [UIColor greenColor].CGColor;
        _midTextLayer.alignmentMode = kCAAlignmentRight;
        _midTextLayer.fontSize = 9.f; //字体的大小
        _midTextLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _midTextLayer;
}


- (CAShapeLayer *)horizontalLine{
    
    if (_horizontalLine == nil) {
        _horizontalLine = [CAShapeLayer layer];
        _horizontalLine.strokeColor = [UIColor blueColor].CGColor;
        _horizontalLine.lineWidth = 0.5;
    }
    return _horizontalLine;
}

- (CAShapeLayer *)verticalLine{
    
    if (_verticalLine == nil) {
        _verticalLine = [CAShapeLayer layer];
        _verticalLine.strokeColor = [UIColor blueColor].CGColor;
        _verticalLine.lineWidth = 0.5;
    }
    return _verticalLine;
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
        [self registerClass:[CCLKLineAboveCell class] forCellReuseIdentifier:@"CCLKLineAboveCell"];
        
        _lastHeight = 10;
        _currHeight = 10;
        self.shareData.currHeight  = _currHeight;
        
        NSArray *smallArray = [self.dataArr subarrayWithRange:NSMakeRange(0, 20)];
        [self getPeakWithArray:smallArray];
        
        [self drawBackLine];
        
        UIPinchGestureRecognizer* gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(scaleTableView:)];
        [self addGestureRecognizer:gesture];
        
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
        self.verticalLine.path = nil;
        
        //        [self.horizontalLine removeFromSuperlayer];
        
        
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
    CGFloat x;
    // 根据涨跌显示的点不固定
    CCLKLineData *data = self.dataArr[indexPath.row];
    
    // 跌看闭盘
    if (data.openprice >= data.closeprice) {
        x = [CCLFrameTool getLeftForValue:data.closeprice
                                 rangeBig: self.shareData.aboveMax
                                 rangeSma:self.shareData.abovemin
                                   length:self.shareData.aboveWidth
                                   andGap:self.shareData.gap];
    }else{
        x = [CCLFrameTool getLeftForValue:data.closeprice
                                 rangeBig: self.shareData.aboveMax
                                 rangeSma:self.shareData.abovemin
                                   length:self.shareData.aboveWidth
                                   andGap:self.shareData.gap];
    }
    
    
    UIBezierPath *path_h = [[UIBezierPath alloc] init];
    [path_h moveToPoint:CGPointMake(0, y)];
    [path_h addLineToPoint:CGPointMake(self.shareData.aboveWidth, y)];
    
    self.horizontalLine.path =path_h.CGPath;
    [self.layer addSublayer: self.horizontalLine];
    
    
    UIBezierPath *path_v = [[UIBezierPath alloc] init];
    [path_v moveToPoint:CGPointMake(x, self.contentOffset.y)];
    [path_v addLineToPoint:CGPointMake(x, self.contentOffset.y + self.shareData.aboveHeight)];
    
    self.verticalLine.path =path_v.CGPath;
    [self.layer addSublayer: self.verticalLine];
    
    
}


#pragma mark -  捏合手势
- (void) scaleTableView:(UIPinchGestureRecognizer*)gesture{
    NSLog(@"state%ld--- scale%f ---velocity%f",(long)gesture.state,gesture.scale,gesture.velocity);
    //控制手指数
    //    if (gesture.numberOfTouches != 2) {
    //        return;
    //    }
    
    
    if (gesture.numberOfTouches == 2 && gesture.state != 0.0f) {
        //计算捏合中心，根据中心点，确定放大位置
        CGPoint p1 = [gesture locationOfTouch: 0 inView:self];
        CGPoint p2 = [gesture locationOfTouch: 1 inView:self];
        CGPoint newCenter = CGPointMake((p1.x+p2.x)/2,(p1.y+p2.y)/2);
        NSIndexPath *indexPath = [self indexPathForRowAtPoint:newCenter];//获取响应的长按的indexpath
        
        
        //T添加临时变数
        CGFloat tempHeight = _lastHeight * gesture.scale;
        
        int h = (int)tempHeight;
        tempHeight = h;
        
        if (_currHeight == tempHeight || tempHeight < 10 || tempHeight > 40) {
            
        }else{
            // 变化之前
            CGFloat y1 = indexPath.row * _currHeight;
            CGFloat o1 = self.contentOffset.y;
            CGFloat h1 = _currHeight * 0.5;
            
            // 变化之后
            CGFloat y2 = indexPath.row * tempHeight;
            CGFloat h2 = tempHeight * 0.5;
            
            CGFloat o2 = y2 + h2 - y1 + o1 - h1;
            
            _currHeight = tempHeight;
            [self reloadData];
            self.contentOffset = CGPointMake(0, o2);
            if ([self.kDelegate respondsToSelector:@selector(reloadDate:)]) {
                [self.kDelegate reloadDate:self];
            }
            
        }
    }
    
    // 当滑动结束时
    if (gesture.state == 3 || gesture.state == 6) {
        _lastHeight = _currHeight;
    }
    
    
    
}

// 获取当前数组极值
- (void)getPeakWithArray:(NSArray *)arr{
    
    CGFloat max = 0;
    NSUInteger maxRow = 0;
    
    CGFloat min = 200000.f;
    NSUInteger minRow = 0;
    
    CGFloat belowMax = 0;

    for (CCLKLineData *data in arr) {
        if (data.highestprice >= max) {
            max = data.highestprice;
            maxRow = [self.dataArr indexOfObject:data];
            
        }
        if (data.lowestprice <= min) {
            min = data.lowestprice;
            minRow = [self.dataArr indexOfObject:data];
        }
        
        
        if (data.turnovervol >= belowMax) {
            belowMax = data.turnovervol;
        }
        
    }
    
    //    NSMutableArray
    if (max != self.max) {
        self.max = max;
    }
    if (min != self.min) {
        self.min = min;
    }
    if (belowMax != self.belowMax) {
        self.belowMax = belowMax;
    }
    
    
    //    NSLog(@"max %f %lu  --- min %f %lu",max,(unsigned long)maxRow,min,(unsigned long)minRow );
}

- (void)setMax:(CGFloat)max{
    _max = max;
    self.shareData.aboveMax = _max;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLinedataChange" object:@"This is posterone!"];
}

- (void)setMin:(CGFloat)min{
    _min = min;
    self.shareData.abovemin = _min;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLinedataChange" object:@"This is posterone!"];
}

- (void)setBelowMax:(CGFloat)belowMax{
    _belowMax = belowMax;
    self.shareData.belowMax = _belowMax;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLinedataBelowMaxChange" object:@"This is posterone!"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.shareData.currHeight  = _currHeight;
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
    
    
    NSArray *smallArray = [self.dataArr subarrayWithRange:NSMakeRange(first.row, last.row - first.row)];
    
    [self getPeakWithArray:smallArray];
    
    CCLKLineAboveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCLKLineAboveCell"];
    
    cell.shareData = self.shareData;
    
    CCLKLineData *data = self.dataArr[indexPath.row];
    cell.data = data;
//    [cell setindex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //拓展
    //判断是否有上一个值
    if (indexPath.row >= 1) {
        CCLKLineData *lastData = self.dataArr[indexPath.row - 1];
        cell.lastData = lastData;
    }else{
        // 赋值nil是为了清楚
        cell.lastData = nil;
    }
    //判断是否有下一个
    if (self.dataArr.count - indexPath.row - 1) {
        
        CCLKLineData *nextData = self.dataArr[indexPath.row + 1];
        cell.nextData = nextData;
    }else{
        cell.nextData = nil;
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([self.kDelegate respondsToSelector:@selector(KLineViewDidScroll:)]) {
        [self.kDelegate KLineViewDidScroll:self];
    }
    
    [self drawBackLine];
    
    
    NSArray *arr = [self visibleCells];
    
    for (CCLKLineAboveCell *cell in arr) {
        
        if (cell.isShowDay) {
            
            NSIndexPath *indexPath = [self indexPathForCell:cell];//获取响应的长按的indexpath
            
            CGRect rect = [self rectForRowAtIndexPath:indexPath];
            
            CGFloat yCenter = rect.origin.y + rect.size.height / 2 - self.contentOffset.y;
            
            [self.superview.layer addSublayer:cell.textLayer];

            CGFloat w = 40;
            CGFloat h = 14;
            CGFloat x = self.shareData.aboveHeight - yCenter - w * 0.5;
            CGFloat y = self.shareData.aboveWidth;
        
            CGRect frame = CGRectMake(x, y, w, h);

            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            
            cell.textLayer.frame = frame;
            
            [CATransaction commit];
           
        }
    }
}

- (void)drawBackLine{
    
    UIBezierPath *path_mid = [[UIBezierPath alloc] init];
    [path_mid moveToPoint:CGPointMake(self.shareData.aboveWidth * 0.5, self.contentOffset.y)];
    [path_mid addLineToPoint:CGPointMake(self.shareData.aboveWidth * 0.5, self.contentOffset.y + self.bounds.size.height)];
    
    self.backLine.path = path_mid.CGPath;
    [self.layer addSublayer:self.backLine];

    UIBezierPath *path_max = [[UIBezierPath alloc] init];
    [path_max moveToPoint:CGPointMake(10, self.contentOffset.y)];
    [path_max addLineToPoint:CGPointMake(10, self.contentOffset.y + self.bounds.size.height)];
    
    self.maxLine.path = path_max.CGPath;
    [self.layer addSublayer:self.maxLine];
    
    
    UIBezierPath *path_min = [[UIBezierPath alloc] init];
    [path_min moveToPoint:CGPointMake(self.shareData.aboveWidth - 10, self.contentOffset.y)];
    [path_min addLineToPoint:CGPointMake(self.shareData.aboveWidth - 10, self.contentOffset.y + self.bounds.size.height)];
    
    self.minLine.path = path_min.CGPath;
    [self.layer addSublayer:self.minLine];

    
    
    
    [self.layer addSublayer:self.markTextLayer];
 
    CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
    [self.markTextLayer setAffineTransform:transform];
    
    
    CGRect frame = CGRectMake(0, self.contentOffset.y + self.bounds.size.height - 30, 13, 30);
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
   
    self.markTextLayer.frame = frame;
    [CATransaction commit];
    

    
    if (_max) {
        [self.layer addSublayer:self.maxTextLayer];
        self.maxTextLayer.string = [NSString stringWithFormat:@"%.2f",_max];
        CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        [self.maxTextLayer setAffineTransform:transform];
        CGRect frame = CGRectMake(10 - 7, self.contentOffset.y, 14, 60);
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        self.maxTextLayer.frame = frame;
        [CATransaction commit];
    }
    if (_min) {
        [self.layer addSublayer:self.minTextLayer];
        self.minTextLayer.string = [NSString stringWithFormat:@"%.2f",_min];
        CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        [self.minTextLayer setAffineTransform:transform];
        CGRect frame = CGRectMake(self.shareData.aboveWidth - 10 - 7 , self.contentOffset.y, 14, 60);
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        self.minTextLayer.frame = frame;
        [CATransaction commit];
    }
    if (_min && _max) {
        [self.layer addSublayer:self.midTextLayer];
        self.midTextLayer.string = [NSString stringWithFormat:@"%.2f",(_min + _max) / 2];
        CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        [self.midTextLayer setAffineTransform:transform];
        CGRect frame = CGRectMake(self.shareData.aboveWidth * 0.5 - 7, self.contentOffset.y, 14, 60);
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        self.midTextLayer.frame = frame;
        [CATransaction commit];
    }
}


@end
