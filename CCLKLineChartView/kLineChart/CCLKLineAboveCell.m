//
//  CCLKLineAboveCell.m
//  KlineChart
//
//  Created by Crisps on 16/9/6.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLKLineAboveCell.h"
#import "CCLFrameTool.h"

@interface CCLKLineAboveCell ()

/**
 *  柱状图
 */
@property (nonatomic, strong) CAShapeLayer *pillarLayer;
/**
 *  线图
 */
@property (nonatomic, strong) CAShapeLayer *lineLayer;

/**
 *  记录位置
 */
@property (nonatomic, strong) UILabel *indexLabel;

/**
 * 均线5分钟 接上
 */
@property (nonatomic, strong) CAShapeLayer *avg_5_up;

/**
 * 均线5分钟 接下
 */
@property (nonatomic, strong) CAShapeLayer *avg_5_down;

/**
 * 均线10分钟 接上
 */
@property (nonatomic, strong) CAShapeLayer *avg_10_up;

/**
 * 均线10分钟 接下
 */
@property (nonatomic, strong) CAShapeLayer *avg_10_down;

/**
 * 均线20分钟 接上
 */
@property (nonatomic, strong) CAShapeLayer *avg_20_up;

/**
 * 均线20分钟 接下
 */
@property (nonatomic, strong) CAShapeLayer *avg_20_down;


/**
 * 标志线
 */
@property (nonatomic, strong) CAShapeLayer *markLayer;

/**
 *  当前界面最大值、最小值 (转shareData)
 */
@property (nonatomic, assign) CGFloat visibleMax;

@property (nonatomic, assign) CGFloat visibleMin;

@property (nonatomic, assign) CGFloat visibleGap;

@property (nonatomic, assign) CGFloat currHeight;

@property (nonatomic, assign) CGFloat currWidth;

@end

@implementation CCLKLineAboveCell


- (UILabel *)indexLabel{
    if (_indexLabel == nil) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        _indexLabel.textColor = [UIColor blackColor];
    }
    return _indexLabel;
}
-(CATextLayer *)textLayer{
    if (_textLayer == nil) {
        _textLayer = [CATextLayer layer];
        _textLayer.frame = self.contentView.bounds;
        _textLayer.foregroundColor = [UIColor blackColor].CGColor;
        _textLayer.alignmentMode = kCAAlignmentJustified;
        UIFont *font = [UIFont systemFontOfSize:9];
        CFStringRef fontName = (__bridge CFStringRef)font.fontName;
        CGFontRef fontRef = CGFontCreateWithFontName(fontName);
        _textLayer.font = fontRef;
        _textLayer.fontSize = font.pointSize;
        CGFontRelease(fontRef);
        _textLayer.contentsScale = [UIScreen mainScreen].scale;

    }
    return _textLayer;
}
- (CGFloat)visibleMax{
    return self.shareData.aboveMax;
}

- (CGFloat)visibleMin{
    return self.shareData.abovemin;
}

- (CGFloat)visibleGap{
    return self.shareData.gap;
}

- (CGFloat)currHeight{
    return self.shareData.currHeight;
}

-(CGFloat)currWidth{
    return self.shareData.aboveWidth;
}

- (CAShapeLayer *)pillarLayer{
    
    if (_pillarLayer == nil) {
        _pillarLayer = [CAShapeLayer layer];
        _pillarLayer.strokeColor = [UIColor clearColor].CGColor;
        //        _pillarLayer.fillColor = [UIColor redColor].CGColor;
        _pillarLayer.lineWidth = 1;
        //        _pillarLayer.lineJoin = kCALineJoinRound;
        //        _pillarLayer.lineCap = kCALineCapRound;
    }
    return _pillarLayer;
}

- (CAShapeLayer *)lineLayer
{
    if (_lineLayer == nil) {
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.strokeColor = [UIColor redColor].CGColor;
        _lineLayer.lineWidth = 1;
        _lineLayer.lineJoin = kCALineJoinRound;
        _lineLayer.lineCap = kCALineCapRound;
    }
    return _lineLayer;
}


- (CAShapeLayer *)markLayer{
    if (_markLayer == nil) {
        _markLayer = [CAShapeLayer layer];
        _markLayer.strokeColor = [UIColor grayColor].CGColor;
        _markLayer.lineWidth = 0.5;
    }
    return _markLayer;
}



- (CAShapeLayer *)avg_5_up{
    
    if (_avg_5_up == nil) {
        _avg_5_up = [CAShapeLayer layer];
        _avg_5_up.strokeColor = [UIColor blueColor].CGColor;
        _avg_5_up.lineWidth = 1;
        _avg_5_up.lineJoin = kCALineJoinRound;
        _avg_5_up.lineCap = kCALineCapRound;
    }
    return _avg_5_up;
}

- (CAShapeLayer *)avg_5_down{
    
    if (_avg_5_down == nil) {
        _avg_5_down = [CAShapeLayer layer];
        _avg_5_down.strokeColor = [UIColor blueColor].CGColor;
        _avg_5_down.lineWidth = 1;
        _avg_5_down.lineJoin = kCALineJoinRound;
        _avg_5_down.lineCap = kCALineCapRound;
    }
    return _avg_5_down;
}

- (CAShapeLayer *)avg_10_up{
    
    if (_avg_10_up == nil) {
        _avg_10_up = [CAShapeLayer layer];
        _avg_10_up.strokeColor = [UIColor orangeColor].CGColor;
        _avg_10_up.lineWidth = 1;
        _avg_10_up.lineJoin = kCALineJoinRound;
        _avg_10_up.lineCap = kCALineCapRound;
    }
    return _avg_10_up;
}

- (CAShapeLayer *)avg_10_down{
    
    if (_avg_10_down == nil) {
        _avg_10_down = [CAShapeLayer layer];
        _avg_10_down.strokeColor = [UIColor orangeColor].CGColor;
        _avg_10_down.lineWidth = 1;
        _avg_10_down.lineJoin = kCALineJoinRound;
        _avg_10_down.lineCap = kCALineCapRound;
    }
    return _avg_10_down;
}

- (CAShapeLayer *)avg_20_up{
    
    if (_avg_20_up == nil) {
        _avg_20_up = [CAShapeLayer layer];
        _avg_20_up.strokeColor = [UIColor purpleColor].CGColor;
        _avg_20_up.lineWidth = 1;
        _avg_20_up.lineJoin = kCALineJoinRound;
        _avg_20_up.lineCap = kCALineCapRound;
    }
    return _avg_20_up;
}

- (CAShapeLayer *)avg_20_down{
    
    if (_avg_20_down == nil) {
        _avg_20_down = [CAShapeLayer layer];
        _avg_20_down.strokeColor = [UIColor purpleColor].CGColor;
        _avg_20_down.lineWidth = 1;
        _avg_20_down.lineJoin = kCALineJoinRound;
        _avg_20_down.lineCap = kCALineCapRound;
    }
    return _avg_20_down;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:@"kLinedataChange" object:nil];
        
    }
    return self;
}
- (void)dataChange{
    

    
    [self reloadPillarChart];
    [self reloadAvg_up];
    [self reloadAvg_down];
}

- (void)setShareData:(CCLKLineShareData *)shareData{
    _shareData = shareData;
}

// 基本展示
- (void)setData:(CCLKLineData *)data{
    _data = data;

    if ([[_data.tradedate substringFromIndex:8] isEqualToString:@"01"]) {
        self.isShowDay = YES;
        
        self.textLayer.string = [_data.tradedate substringToIndex:7];
        
        
    }else{
        self.isShowDay = NO;
        [_textLayer removeFromSuperlayer];
        _textLayer = nil;
    }
    
    [self reloadPillarChart];
    
}
- (void)reloadPillarChart{
    // 防止未赋值 就执行通知
    if (_data == nil) {
        return;
    }
    
    if (self.isShowDay) {
        
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(0, self.currHeight * 0.5)];
        [path addLineToPoint:CGPointMake(self.currWidth, self.currHeight * 0.5)];
        [self.contentView.layer addSublayer: self.markLayer];
        self.markLayer.path = path.CGPath;
    }else{
        self.markLayer.path = nil;

    }
    
    
    
    CGFloat openprice = self.data.openprice;
    CGFloat closeprice = self.data.closeprice;
    
    CGFloat leftPillar;
    CGFloat widthPillar;
    
    
    // 开盘大于收盘
    if (openprice >= closeprice) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        self.pillarLayer.fillColor = [UIColor greenColor].CGColor;
        self.lineLayer.strokeColor = [UIColor greenColor].CGColor;
        
        [CATransaction commit];
        
        
        leftPillar = [CCLFrameTool getLeftForValue:openprice
                                          rangeBig:self.visibleMax
                                          rangeSma:self.visibleMin
                                            length:self.currWidth
                                            andGap:self.visibleGap];
        
        widthPillar  = [CCLFrameTool getWidthForValue:openprice - closeprice
                                             rangeBig:self.visibleMax
                                             rangeSma:self.visibleMin
                                               length:self.currWidth
                                               andGap:self.visibleGap];
        
        
    }else{
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        
        self.pillarLayer.fillColor = [UIColor redColor].CGColor;
        self.lineLayer.strokeColor = [UIColor redColor].CGColor;
        
        [CATransaction commit];
        
        leftPillar = [CCLFrameTool getLeftForValue:closeprice
                                          rangeBig:self.visibleMax
                                          rangeSma:self.visibleMin
                                            length:self.currWidth
                                            andGap:self.visibleGap];
        widthPillar  = [CCLFrameTool getWidthForValue:closeprice - openprice
                                             rangeBig:self.visibleMax
                                             rangeSma:self.visibleMin
                                               length:self.currWidth
                                               andGap:self.visibleGap];
    }
    
    
    
    UIBezierPath *pathP = [UIBezierPath bezierPathWithRect:CGRectMake(leftPillar, self.currHeight * 0.05, widthPillar, self.currHeight * 0.9)];
    [self.contentView.layer addSublayer: self.pillarLayer];
    self.pillarLayer.path = pathP.CGPath;

    
    
    
    CGFloat leftLine = [CCLFrameTool getLeftForValue:_data.highestprice
                                            rangeBig:self.visibleMax
                                            rangeSma:self.visibleMin
                                              length:self.currWidth
                                              andGap:self.visibleGap];
    CGFloat rightLine = [CCLFrameTool getLeftForValue:_data.lowestprice
                                             rangeBig:self.visibleMax
                                             rangeSma:self.visibleMin
                                               length:self.currWidth
                                               andGap:self.visibleGap];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(leftLine, self.currHeight * 0.5)];
    [path addLineToPoint:CGPointMake(rightLine, self.currHeight * 0.5)];
    [self.contentView.layer addSublayer: self.lineLayer];
    self.lineLayer.path = path.CGPath;
    

    
}
- (void)setLastData:(CCLKLineData *)lastData{
    
    _lastData = lastData;
    
    [self reloadAvg_up];
    
}

- (void)reloadAvg_up{
    
    
    // 防止未赋值 就执行通知
    if (_data == nil) {
        return;
    }
    if (_lastData == nil) {
        
        self.avg_5_up.path = nil;
        self.avg_10_up.path = nil;
        self.avg_20_up.path = nil;
        
        return;
    }
    
    
    
    CGFloat avg_5_up = [CCLFrameTool getLeftForValue:(_data.avg_5 + _lastData.avg_5) / 2
                                            rangeBig:self.visibleMax
                                            rangeSma:self.visibleMin
                                              length:self.currWidth
                                              andGap:self.visibleGap];
    
    CGFloat avg_5 = [CCLFrameTool getLeftForValue:_data.avg_5
                                         rangeBig:self.visibleMax
                                         rangeSma:self.visibleMin
                                           length:self.currWidth
                                           andGap:self.visibleGap];
    
    UIBezierPath *path_5 = [[UIBezierPath alloc] init];
    [path_5 moveToPoint:CGPointMake(avg_5_up, 0)];
    [path_5 addLineToPoint:CGPointMake(avg_5, self.currHeight / 2)];
    
    self.avg_5_up.path = path_5.CGPath;
    [self.contentView.layer addSublayer: self.avg_5_up];
    
    
    CGFloat avg_10_up = [CCLFrameTool getLeftForValue:(_data.avg_10 + _lastData.avg_10) / 2
                                             rangeBig:self.visibleMax
                                             rangeSma:self.visibleMin
                                               length:self.currWidth
                                               andGap:self.visibleGap];
    
    CGFloat avg_10 = [CCLFrameTool getLeftForValue:_data.avg_10
                                          rangeBig:self.visibleMax
                                          rangeSma:self.visibleMin
                                            length:self.currWidth
                                            andGap:self.visibleGap];
    
    UIBezierPath *path_10 = [[UIBezierPath alloc] init];
    [path_10 moveToPoint:CGPointMake(avg_10_up, 0)];
    [path_10 addLineToPoint:CGPointMake(avg_10, self.currHeight / 2)];
    
    self.avg_10_up.path = path_10.CGPath;
    [self.contentView.layer addSublayer: self.avg_10_up];
    
    
    
    CGFloat avg_20_up = [CCLFrameTool getLeftForValue:(_data.avg_20 + _lastData.avg_20) / 2
                                             rangeBig:self.visibleMax
                                             rangeSma:self.visibleMin
                                               length:self.currWidth
                                               andGap:self.visibleGap];
    
    CGFloat avg_20 = [CCLFrameTool getLeftForValue:_data.avg_20
                                          rangeBig:self.visibleMax
                                          rangeSma:self.visibleMin
                                            length:self.currWidth
                                            andGap:self.visibleGap];
    
    UIBezierPath *path_20 = [[UIBezierPath alloc] init];
    [path_20 moveToPoint:CGPointMake(avg_20_up, 0)];
    [path_20 addLineToPoint:CGPointMake(avg_20, self.currHeight / 2)];
    
    self.avg_20_up.path = path_20.CGPath;
    [self.contentView.layer addSublayer: self.avg_20_up];
    //
    
    
}


- (void)setNextData:(CCLKLineData *)nextData{
    
    _nextData = nextData;
    
    [self reloadAvg_down];
    
}

- (void)reloadAvg_down{
    
    // 防止未赋值 就执行通知
    if (_data == nil) {
        return;
    }
    if (_nextData == nil) {
        
        self.avg_5_down.path = nil;
        self.avg_10_down.path = nil;
        self.avg_20_down.path = nil;
        return;
    }
    
    CGFloat avg_5 = [CCLFrameTool getLeftForValue:_data.avg_5
                                         rangeBig:self.visibleMax
                                         rangeSma:self.visibleMin
                                           length:self.currWidth
                                           andGap:self.visibleGap];
    
    CGFloat avg_5_down = [CCLFrameTool getLeftForValue:(_data.avg_5 + _nextData.avg_5) / 2
                                              rangeBig:self.visibleMax
                                              rangeSma:self.visibleMin
                                                length:self.currWidth
                                                andGap:self.visibleGap];
    
    UIBezierPath *path_5 = [[UIBezierPath alloc] init];
    [path_5 moveToPoint:CGPointMake(avg_5, self.currHeight / 2)];
    [path_5 addLineToPoint:CGPointMake(avg_5_down, self.currHeight)];
    
    self.avg_5_down.path = path_5.CGPath;
    [self.contentView.layer addSublayer: self.avg_5_down];
    
    
    CGFloat avg_10 = [CCLFrameTool getLeftForValue:_data.avg_10
                                          rangeBig:self.visibleMax
                                          rangeSma:self.visibleMin
                                            length:self.currWidth
                                            andGap:self.visibleGap];
    
    CGFloat avg_10_down = [CCLFrameTool getLeftForValue:(_data.avg_10 + _nextData.avg_10) / 2
                                               rangeBig:self.visibleMax
                                               rangeSma:self.visibleMin
                                                 length:self.currWidth
                                                 andGap:self.visibleGap];
    
    UIBezierPath *path_10 = [[UIBezierPath alloc] init];
    [path_10 moveToPoint:CGPointMake(avg_10, self.currHeight / 2)];
    [path_10 addLineToPoint:CGPointMake(avg_10_down, self.currHeight)];
    
    self.avg_10_down.path = path_10.CGPath;
    [self.contentView.layer addSublayer: self.avg_10_down];
    
    
    CGFloat avg_20 = [CCLFrameTool getLeftForValue:_data.avg_20
                                          rangeBig:self.visibleMax
                                          rangeSma:self.visibleMin
                                            length:self.currWidth
                                            andGap:self.visibleGap];
    
    CGFloat avg_20_down = [CCLFrameTool getLeftForValue:(_data.avg_20 + _nextData.avg_20) / 2
                                               rangeBig:self.visibleMax
                                               rangeSma:self.visibleMin
                                                 length:self.currWidth
                                                 andGap:self.visibleGap];
    
    UIBezierPath *path_20 = [[UIBezierPath alloc] init];
    [path_20 moveToPoint:CGPointMake(avg_20, self.currHeight / 2)];
    [path_20 addLineToPoint:CGPointMake(avg_20_down, self.currHeight)];
    
    self.avg_20_down.path = path_20.CGPath;
    [self.contentView.layer addSublayer: self.avg_20_down];
    
}

- (void)dealloc{
    
    if (_textLayer) {
        [_textLayer removeFromSuperlayer];
    }
    
    _textLayer = nil;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
