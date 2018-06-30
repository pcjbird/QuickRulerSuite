//
//  QuickSportsRulerStyle.h
//  QuickRulerSuite
//
//  Created by pcjbird on 2018/6/30.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

/**
 * @brief 运动尺样式  Style of the Sports Ruler
 */
@interface QuickSportsRulerStyle : NSObject

/**
 * @brief 背景色, 默认 [UIColor clearColor].   background color of ruler
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 * @brief 标记颜色, 默认 [UIColor redColor].   marker color of ruler
 */
@property (nonatomic, strong) UIColor *markerColor;

/**
 * @brief 标记图片, 默认为自带的图片
 */
@property (nonatomic, strong) UIImage *marker;

/**
 * @brief 刻度颜色，默认 0xd8d8d8. every tick color of ruler
 */
@property (nonatomic, strong) UIColor *tickColor;

/**
 * @brief 底部线条着色，默认 0xd8d8d8. bottom line stroke color
 */
@property (nonatomic, strong) UIColor *bottomStrokeColor;

/**
 * @brief 渐变色数组，默认 [0x29b0e6, 0xfe0058]
 * @note If this value is nil, every tick line have the same color. Or, ticks before marker will stroke by these colors. count must be 2
 */
@property (nonatomic, strong) NSArray<UIColor*> *gradientColors;

/**
 * @brief 运动尺最小刻度值，默认0. The minimum value of the ruler. Default is 0.
 */
@property (nonatomic, assign) CGFloat minTickValue;

/**
 * @brief 运动尺最大刻度值，默认10000. The maximum value of the ruler. Default is 10000.
 */
@property (nonatomic, assign) CGFloat maxTickValue;

/**
 * @brief 基础测量单位，basic measurement unit, every unit may be represent 100 RMB, or 10 cm, and so on.
 * @note must >= 1
 */
@property (nonatomic, assign) CGFloat unitValue;

/**
 * @brief 最小限度值，默认为minTickValue.
 */
@property (nonatomic, assign) CGFloat minLimitValue;

/**
 * @brief 最大限度值，默认为maxTickValue.
 */
@property (nonatomic, assign) CGFloat maxLimitValue;

/**
 * @brief 初始值，必须在minLimitValue和maxLimitValue之间
 */
@property (nonatomic, assign) CGFloat initValue;

/**
 * @brief 两个基本刻度之间的间距, 用于绘制, 默认为 8pt （基于 iPhone 6S 缩放）
 */
@property (nonatomic, assign) CGFloat stepSpacing;

/**
 * @brief 刻度线宽度, 默认为 2pt （基于 iPhone 6S 缩放）
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 * @brief 基本刻度线高度, 默认为 12pt （基于 iPhone 6S 缩放）
 */
@property (nonatomic, assign) CGFloat lineHeight1;

/**
 * @brief 每第5个刻度线的高度, 默认为 28pt （基于 iPhone 6S 缩放）
 */
@property (nonatomic, assign) CGFloat lineHeight5;

/**
 * @brief 每第10个刻度线的高度, 默认为 28pt （基于 iPhone 6S 缩放）
 */
@property (nonatomic, assign) CGFloat lineHeight10;

/**
 * @brief 刻度标记字体大小, 默认为 10pt （基于 iPhone 6S 缩放）
 */
@property (nonatomic, assign) CGFloat tickFontSize;


@end
