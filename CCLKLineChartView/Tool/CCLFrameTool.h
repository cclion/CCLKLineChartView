//
//  CCLFrameTool.h
//  KlineChart
//
//  Created by Crisps on 16/8/29.
//  Copyright © 2016年 cclion.cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCLFrameTool : NSObject

/**
 *  计算位置坐标（居左边距）
 *
 *  @param value    数值
 *  @param rangeB   范围(极大)
 *  @param rangeSma 范围(极小)
 *  @param length   实际屏幕显示宽度
 *
 *  @return 位置坐标（居左边距）
 */
+ (CGFloat)getLeftForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma andLength:(CGFloat)length;


/**
 *  计算位置坐标（居右边距）
 *
 *  @param value    数值
 *  @param rangeB   范围(极大)
 *  @param rangeSma 范围(极小)
 *  @param length   实际屏幕显示宽度
 *
 *  @return 位置坐标（居左边距）
 */
+ (CGFloat)getRightForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma andLength:(CGFloat)length;


/**
 *  计算位置坐标（宽度）
 *
 *  @param value    数值
 *  @param rangeBig 范围(极大)
 *  @param rangeSma 范围(极小)
 *  @param length   实际屏幕显示宽度
 *
 *  @return 位置宽度
 */
+ (CGFloat)getWidthForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma andLength:(CGFloat)length;




/**
 *  计算位置坐标（居左边距）有边界线的情况
 *
 *  @param value    数值
 *  @param rangeBig 范围(极大)
 *  @param rangeSma 范围(极小)
 *  @param length   实际屏幕显示宽度
 *  @param length   边界线
 *
 *  @return 位置宽度
 */
+ (CGFloat)getLeftForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma length:(CGFloat)length andGap:(CGFloat)gap;


/**
 *  计算位置坐标（居右边距）有边界线的情况
 *
 *  @param value    数值
 *  @param rangeBig 范围(极大)
 *  @param rangeSma 范围(极小)
 *  @param length   实际屏幕显示宽度
 *  @param length   边界线
 *
 *  @return 位置宽度
 */
+ (CGFloat)getRightForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma length:(CGFloat)length andGap:(CGFloat)gap;


/**
 *  计算位置坐标（宽度））有边界线的情况
 *
 *  @param value    数值
 *  @param rangeBig 范围(极大)
 *  @param rangeSma 范围(极小)
 *  @param length   实际屏幕显示宽度
 *  @param length   边界线
 *
 *  @return 位置宽度
 */
+ (CGFloat)getWidthForValue:(CGFloat)value rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma length:(CGFloat)length andGap:(CGFloat)gap;

/**
 *  获取－90旋转前的坐标
 *
 *  @param rectNew 现在的坐标
 *
 *  @return 本质坐标
 */
+ (CGRect)getTransBefore:(CGRect)rectNew;

/**
 *  获取－90旋转前的坐标
 *
 *  @param rectNew 现在的坐标
 *
 *  @return 本质坐标
 */
+ (CGPoint)getOriginBefore:(CGRect)rectNew;

/**
 *  计算位置坐标（时间线）有边界线的情况
 *
 *  @param value    数值
 *  @param index    位置
 *  @param width    父视图宽度
 *  @param rangeBig 范围(极大)
 *  @param rangeSma 范围(极小)
 *  @param length   实际屏幕显示宽度
 *  @param length   边界线
 *
 *  @return 位置宽度
 */
+ (CGPoint)getPointForValue:(CGFloat)value index:(NSUInteger)index width:(CGFloat)width rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma length:(CGFloat)length andGap:(CGFloat)gap;

/**
 *  计算位置坐标（时间线下方交易量）无边界线
 *
 *  @param value    数值
 *  @param index    位置
 *  @param width    父视图宽度
 *  @param rangeBig 范围(极大)
 *  @param rangeSma 范围(极小)
 *  @param length   实际屏幕显示宽度
 *
 *  @return 位置宽度
 */
+ (CGRect)getRectForValue:(CGFloat)value index:(NSUInteger)index width:(CGFloat)width rangeBig:(CGFloat)rangeBig rangeSma:(CGFloat)rangeSma andLength:(CGFloat)length;


@end
