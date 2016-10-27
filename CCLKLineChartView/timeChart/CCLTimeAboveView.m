//
//  CCLTimeAboveView.m
//  KlineChart
//
//  Created by Crisps on 16/9/28.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLTimeAboveView.h"
#import "CCLTimeModel.h"
#import "MJExtension.h"
#import "CCLFrameTool.h"
@interface CCLTimeAboveView ()
<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *dataArr;

/**
 * 当前时间线
 */
@property (nonatomic, strong) CAShapeLayer *nowData;

/**
 * 均线
 */
@property (nonatomic, strong) CAShapeLayer *avgData;

/**
 * 中间分割线
 */
@property (nonatomic, strong) CAShapeLayer *midSeg;

/**
 * 昨日收盘
 */
@property (nonatomic, assign) CGFloat closePrice;

/**
 * 最高价
 */
@property (nonatomic, assign) CGFloat maxPrice;

/**
 * 最底价
 */
@property (nonatomic, assign) CGFloat minPrice;

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
@property (nonatomic, assign) NSUInteger selIndex;

/**
 *  阴影
 */
@property (nonatomic, strong) CAShapeLayer *shadowLayer;

@end


@implementation CCLTimeAboveView

- (NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (CAShapeLayer *)nowData{
    if (_nowData == nil) {
        _nowData = [CAShapeLayer layer];
        _nowData.lineWidth = 1;
        _nowData.lineJoin = kCALineJoinRound;
        _nowData.lineCap = kCALineCapRound;
        _nowData.strokeColor = [UIColor blueColor].CGColor;
        _nowData.fillColor = [UIColor clearColor].CGColor;
    }
    return _nowData;
}

- (CAShapeLayer *)shadowLayer{
    if (_shadowLayer == nil) {
        _shadowLayer = [CAShapeLayer layer];
        _shadowLayer.lineWidth = 1;
        _shadowLayer.lineJoin = kCALineJoinRound;
        _shadowLayer.lineCap = kCALineCapRound;
        _shadowLayer.fillColor = [[UIColor alloc] initWithRed:189.f/255.f green:207.f/255.f blue:251.f/255.f alpha:0.8].CGColor;
    }
    return _shadowLayer;
}


- (CAShapeLayer *)avgData{
    if (_avgData == nil) {
        _avgData = [CAShapeLayer layer];
        _avgData.lineWidth = 1;
        _avgData.lineJoin = kCALineJoinRound;
        _avgData.lineCap = kCALineCapRound;
        _avgData.strokeColor = [UIColor blueColor].CGColor;
    }
    return _avgData;
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

- (CAShapeLayer *)midSeg{
    if (_midSeg == nil) {
        _midSeg = [CAShapeLayer layer];
        _midSeg.lineWidth = 1;
        _midSeg.lineJoin = kCALineJoinRound;
        _midSeg.lineCap = kCALineCapRound;
        _midSeg.strokeColor = [UIColor blueColor].CGColor;
        
    }
    return _midSeg;
}


- (instancetype)initWithFrame:(CGRect)frame andShareData:(CCLTimeShareData *)shareData{
    if (self = [super initWithFrame:frame]) {
        _shareData = shareData;
        _closePrice = 9.06;
        NSString * path =[[NSBundle mainBundle]pathForResource:@"timeData.plist" ofType:nil];
        NSDictionary *dataDict = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"data"];
        NSArray *sourceArray = dataDict[@"barBodys"];
        self.dataArr = [CCLTimeModel mj_objectArrayWithKeyValuesArray:sourceArray];
        NSLog(@"%@",self.dataArr);
        
        [self drawBackLine];
        [self drawDataLine];
    
        UILongPressGestureRecognizer *longPressReger = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                     action:@selector(handleLongPress:)];
        longPressReger.minimumPressDuration = 0.3f;
        longPressReger.delegate = self;
        [self addGestureRecognizer:longPressReger];
    }
    return self;
}

#pragma mark -  长按手势
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    
    CGPoint p = [gestureRecognizer locationInView:self];
    
    
    
    int index = p.x / (_shareData.allWidth / 241);
    NSLog(@"%d",index);
    [self drawWithLongPress:gestureRecognizer forIndex:index];
    if ([self.delegate respondsToSelector:@selector(handleLongPress:forIndex:andView:)]) {
        [self.delegate handleLongPress:gestureRecognizer forIndex:index andView:self];
    }
}

- (void)drawWithLongPress:(UILongPressGestureRecognizer *)gestureRecognizer forIndex:(NSUInteger )index{

    
    if (gestureRecognizer.state == 1) {

        [self reloadCrossLineWith:index];
        self.selIndex = index;
    }else if (gestureRecognizer.state == 3){
        
        self.horizontalLine.path = nil;
        self.verticalLine.path = nil;
        
        //        [self.horizontalLine removeFromSuperlayer];
        
        
    }else{
        if (index != self.selIndex) {
            self.selIndex = index;
            [self reloadCrossLineWith:index];
        }
    }

}
- (void)reloadCrossLineWith:(NSUInteger)index{
    
    CCLTimeModel *model = self.dataArr[index];
    CGPoint point = [CCLFrameTool getPointForValue:model.closePrice
                                             index:index
                                             width:_shareData.allWidth
                                          rangeBig:self.maxPrice
                                          rangeSma:self.minPrice
                                            length:_shareData.aboveHeight
                                            andGap:_shareData.gap];
    
    // 计算出中心点
    
    CGFloat y = point.y;
    CGFloat x = point.x;
    
    UIBezierPath *path_h = [[UIBezierPath alloc] init];
    [path_h moveToPoint:CGPointMake(0, y)];
    [path_h addLineToPoint:CGPointMake(self.shareData.allWidth, y)];
    
    self.horizontalLine.path =path_h.CGPath;
    [self.layer addSublayer: self.horizontalLine];
    
    UIBezierPath *path_v = [[UIBezierPath alloc] init];
    [path_v moveToPoint:CGPointMake(x, 0)];
    [path_v addLineToPoint:CGPointMake(x, _shareData.aboveHeight)];
    
    self.verticalLine.path =path_v.CGPath;
    [self.layer addSublayer: self.verticalLine];
    
}

- (void)drawDataLine{
    
    if (self.dataArr.count == 0) {
        return;
    }
    if (_closePrice == 0) {
        return;
    }
    
    CGFloat maxPrice = 0.0;
    CGFloat minPrice = 0.0;
    
    for (int i = 0; i < self.dataArr.count; i++) {
        
        CCLTimeModel *model = self.dataArr[i];
        
        if (i == 0) {
            maxPrice = model.closePrice;
            minPrice = model.closePrice;
            
        }else{
            if ( model.closePrice > maxPrice) {
                maxPrice = model.closePrice;
            }
            if (model.closePrice < minPrice) {
                minPrice = model.closePrice;
            }
        }
    }
    
    //比较绝对值
//    CGFloat abs = maxPrice - _closePrice > _closePrice - minPrice? : _closePrice - minPrice;
    CGFloat abs;
    if ( maxPrice - _closePrice > _closePrice - minPrice) {
        abs = maxPrice - _closePrice;
    }else{
        abs = maxPrice - _closePrice;
    }
    
    self.maxPrice = _closePrice + abs;
    self.minPrice = _closePrice - abs;
    
    UIBezierPath *pathNow = [[UIBezierPath alloc] init];
    
    UIBezierPath *pathShadow = [[UIBezierPath alloc] init];
    
    [pathShadow moveToPoint:CGPointMake(0, _shareData.aboveHeight)];

    for (int i = 0; i < self.dataArr.count; i++) {
        
        CCLTimeModel *model = self.dataArr[i];
        
        CGPoint point = [CCLFrameTool getPointForValue:model.closePrice
                                                 index:i
                                                 width:_shareData.allWidth
                                              rangeBig:self.maxPrice
                                              rangeSma:self.minPrice
                                                length:_shareData.aboveHeight
                                                andGap:_shareData.gap];
        
        [pathShadow addLineToPoint:point];

        if (i == 0) {
         [pathNow moveToPoint:point];
            
        }else{
            [pathNow addLineToPoint:point];
            
            if (i == self.dataArr.count - 1) {
                [pathShadow addLineToPoint:CGPointMake(point.x, _shareData.aboveHeight)];
            }
            
        }

    }
    self.nowData.path = pathNow.CGPath;
    //add it to our view
    [self.layer addSublayer: self.nowData];
    
    self.shadowLayer.path = pathShadow.CGPath;
    [self.layer addSublayer:self.shadowLayer];
    
}


- (void)drawBackLine{
    
    // 中间线
    [self.midSeg setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:5],
      [NSNumber numberWithInt:5],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, _shareData.aboveHeight * 0.5);
    CGPathAddLineToPoint(path, NULL, _shareData.allWidth, _shareData.aboveHeight * 0.5);
    [self.midSeg setPath:path];
    CGPathRelease(path);
    
    [self.layer addSublayer:self.midSeg];
}


@end
