//
//  CCLKLineBelowCell.m
//  KlineChart
//
//  Created by Crisps on 16/9/7.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLKLineBelowCell.h"
#import "CCLFrameTool.h"

@interface CCLKLineBelowCell ()
/**
 *  柱状图
 */
@property (nonatomic, strong) CAShapeLayer *pillarLayer;

/**
 *  当前界面最大值、最小值 (转shareData)
 */
@property (nonatomic, assign) CGFloat visibleMax;

@property (nonatomic, assign) CGFloat currHeight;

@property (nonatomic, assign) CGFloat currWidth;

/**
 * 标志线
 */
@property (nonatomic, strong) CAShapeLayer *markLayer;

@end

@implementation CCLKLineBelowCell

- (CAShapeLayer *)pillarLayer{
    
    if (_pillarLayer == nil) {
        _pillarLayer = [CAShapeLayer layer];
        _pillarLayer.strokeColor = [UIColor clearColor].CGColor;
        _pillarLayer.lineWidth = 1;
    }
    return _pillarLayer;
}

- (CGFloat)visibleMax{
    return self.shareData.belowMax;
}

-(CGFloat)currHeight{
    return self.shareData.currHeight;
}

- (CGFloat)currWidth{
    return self.shareData.belowWidth;
}
- (CAShapeLayer *)markLayer{
    if (_markLayer == nil) {
        _markLayer = [CAShapeLayer layer];
        _markLayer.strokeColor = [UIColor grayColor].CGColor;
        _markLayer.lineWidth = 0.5;
    }
    return _markLayer;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChange) name:@"kLinedataBelowMaxChange" object:nil];
        
    }
    return self;
}

- (void)dataChange{
    [self reloadPillarChart];
}

- (void)setShareData:(CCLKLineShareData *)shareData{
    _shareData = shareData;
}

// 基本展示
- (void)setData:(CCLKLineData *)data{
    _data = data;

    [self reloadPillarChart];
    
}

- (void)reloadPillarChart{
    // 防止未赋值 就执行通知
    if (_data == nil) {
        return;
    }
    
    
    if ([[_data.tradedate substringFromIndex:8] isEqualToString:@"01"]) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:CGPointMake(0, self.currHeight * 0.5)];
        [path addLineToPoint:CGPointMake(self.currWidth, self.currHeight * 0.5)];
        [self.contentView.layer addSublayer: self.markLayer];
        self.markLayer.path = path.CGPath;
        
        
    }else{
        self.markLayer.path = nil;
    }
    
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    // 开盘大于收盘
    if (self.data.openprice >= self.data.closeprice) {
        
        self.pillarLayer.fillColor = [UIColor greenColor].CGColor;
        
    }else{
        
        self.pillarLayer.fillColor = [UIColor redColor].CGColor;
        
    }
    
    [CATransaction commit];
    
    CGFloat leftPillar = [CCLFrameTool getLeftForValue:self.data.turnovervol
                                              rangeBig:self.visibleMax
                                              rangeSma:0
                                             andLength:self.currWidth];
    
    CGFloat widthPillar  = [CCLFrameTool getWidthForValue:self.data.turnovervol
                                         rangeBig:self.visibleMax
                                         rangeSma:0
                                        andLength:self.currWidth];
    
    UIBezierPath *pathP = [UIBezierPath bezierPathWithRect:CGRectMake(leftPillar, self.currHeight * 0.05, widthPillar, self.currHeight * 0.9)];
    
    [self.contentView.layer addSublayer: self.pillarLayer];
    self.pillarLayer.path = pathP.CGPath;
    
    
    
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
