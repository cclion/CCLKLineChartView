//
//  CCLTimeBelowView.m
//  KlineChart
//
//  Created by Crisps on 16/9/28.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLTimeBelowView.h"
#import "CCLTimeModel.h"
#import "MJExtension.h"
#import "CCLFrameTool.h"

@interface CCLTimeBelowView ()
<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *dataArr;

/**
 * 最高价
 */
@property (nonatomic, assign) CGFloat maxVol;

@property (nonatomic, strong) NSMutableArray *volArr;
/**
 * 长按信息纵向
 */
@property (nonatomic, strong) CAShapeLayer *verticalLine;
/**
 *  选中的row
 */
@property (nonatomic, assign) NSUInteger selIndex;

@end

@implementation CCLTimeBelowView

- (NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)volArr{
    if (_volArr == nil) {
        _volArr = [NSMutableArray array];
    }
    return _volArr;
}

- (CAShapeLayer *)verticalLine{
    
    if (_verticalLine == nil) {
        _verticalLine = [CAShapeLayer layer];
        _verticalLine.strokeColor = [UIColor blueColor].CGColor;
        _verticalLine.lineWidth = 0.5;
    }
    return _verticalLine;
}

- (instancetype)initWithFrame:(CGRect)frame andShareData:(CCLTimeShareData *)shareData{
    if (self = [super initWithFrame:frame]) {
        _shareData = shareData;
        
        NSString * path =[[NSBundle mainBundle]pathForResource:@"timeData.plist" ofType:nil];
        NSDictionary *dataDict = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"data"];
        NSArray *sourceArray = dataDict[@"barBodys"];
        self.dataArr = [CCLTimeModel mj_objectArrayWithKeyValuesArray:sourceArray];
        NSLog(@"%@",self.dataArr);
        
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
    
    CGFloat itemW = _shareData.allWidth / 241;
    CGFloat x = itemW * 0.5 + itemW * index;
    
    // 计算出中心点
 
    UIBezierPath *path_v = [[UIBezierPath alloc] init];
    [path_v moveToPoint:CGPointMake(x, 0)];
    [path_v addLineToPoint:CGPointMake(x, _shareData.belowHeight)];
    
    self.verticalLine.path =path_v.CGPath;
    [self.layer addSublayer: self.verticalLine];
    
}




- (void)drawDataLine{
 
    if (self.dataArr.count == 0) {
        return;
    }
 
    
    CGFloat maxVol = 0.0;
    
   
    
    for (int i = 0; i < self.dataArr.count; i++) {
        
        CCLTimeModel *model = self.dataArr[i];
        
        if (i == 0) {
            maxVol = model.totalVolume;
           
        }else{
            if ( model.totalVolume > maxVol) {
                maxVol = model.totalVolume;
            }
        }
    }

    self.maxVol = maxVol;
    
    [self removeSubLayrs];
    
    NSMutableArray *muVolArr = [NSMutableArray array];
    
    for (int i = 0; i < self.dataArr.count; i++) {
        
        CCLTimeModel *model = self.dataArr[i];
        

        CGRect rect = [CCLFrameTool getRectForValue:model.totalVolume
                                              index:i
                                              width:_shareData.allWidth
                                           rangeBig:self.maxVol
                                           rangeSma:0
                                          andLength:_shareData.belowHeight];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor redColor].CGColor;
        layer.lineWidth = 0.1;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
        layer.path = path.CGPath;
        
        
        NSLog(@"%@",NSStringFromCGRect(rect));
        [self.layer addSublayer:layer];

        [muVolArr addObject:layer];
    }
    
    self.volArr = muVolArr;
    
    
    
}

- (void)removeSubLayrs{
    
    if (self.volArr.count == 0) {
        return;
    }
    
    for (CAShapeLayer *layer in self.volArr) {
        [layer removeFromSuperlayer];
    }
    
}

@end
