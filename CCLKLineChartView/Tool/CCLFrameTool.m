//
//  CCLFrameTool.m
//  KlineChart
//
//  Created by Crisps on 16/8/29.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import "CCLFrameTool.h"

@implementation CCLFrameTool

+ (CGFloat)getLeftForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma andLength:(CGFloat)length{
    
    CGFloat left = (rangeBig - value) / (rangeBig - rangeSma) * length;
    return left;
}

+ (CGFloat)getRightForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma andLength:(CGFloat)length{
    CGFloat right = (value - rangeSma) / (rangeBig - rangeSma) * length;
    return right;
}

+ (CGFloat)getWidthForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma andLength:(CGFloat)length{

    CGFloat width = value / (rangeBig - rangeSma) * length;
    return width;
}

+ (CGFloat)getLeftForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma length:(CGFloat)length andGap:(CGFloat)gap{
    CGFloat left = (rangeBig - value) / (rangeBig - rangeSma) * (length - 2 * gap) + gap;
    return left;
}

+ (CGFloat)getRightForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma length:(CGFloat)length andGap:(CGFloat)gap{
    CGFloat left = (rangeBig - value) / (rangeBig - rangeSma) * (length - 2 * gap) + gap;
    return left;
}

+ (CGFloat)getWidthForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma length:(CGFloat)length andGap:(CGFloat)gap{
    CGFloat width = value / (rangeBig - rangeSma) * (length - 2 * gap);
    return width;
}

+ (CGRect)getTransBefore:(CGRect)rectNew{
    
    CGFloat x = rectNew.origin.x;
    CGFloat y = rectNew.origin.y;
    CGFloat w= rectNew.size.width;
    CGFloat h = rectNew.size.height;

    return CGRectMake(x + w * 0.5 - h * 0.5, y + h * 0.5 - w * 0.5, w, h);

}

+ (CGPoint)getOriginBefore:(CGRect)rectNew{
    CGFloat x = rectNew.origin.x;
    CGFloat y = rectNew.origin.y;
    CGFloat w= rectNew.size.width;
    CGFloat h = rectNew.size.height;
    
    return CGPointMake(x + w * 0.5 + h * 0.5, y + h * 0.5 - w * 0.5);
}

+ (CGPoint)getPointForValue:(CGFloat)value index:(NSUInteger)index width:(CGFloat)width rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma length:(CGFloat)length andGap:(CGFloat)gap{
    
    CGFloat itemW = width / 241;
    CGFloat x = itemW * 0.5 + itemW * index;
    CGFloat y = [self getRightForValue:value rangeBig:rangeBig rangeSma:rangeSma length:length andGap:gap];

    return CGPointMake(x, y);
}

+ (CGRect)getRectForValue:(CGFloat)value index:(NSUInteger)index width:(CGFloat)width rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma andLength:(CGFloat)length{
    
    CGFloat itemW = width / 241;
    CGFloat gap = itemW * 0.1;

    CGFloat x = gap + itemW * index;
    
    CGFloat y = [self getRightForValue:value rangeBig:rangeBig rangeSma:rangeSma length:length andGap:0];
    CGFloat h = length - y;
    CGFloat w = itemW - gap * 2;
    
    return CGRectMake(x, y, w, h);
}


@end
