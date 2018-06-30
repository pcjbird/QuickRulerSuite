//
//  QuickSportsRuler.h
//  QuickRulerSuite
//
//  Created by pcjbird on 2018/6/30.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#if __has_include(<QuickRulerSuite/QuickSportsRulerStyle.h>)
#import <QuickRulerSuite/QuickSportsRulerStyle.h>
#else
#import "QuickSportsRulerStyle.h"
#endif

@class QuickSportsRuler;

/**
 * @brief 运动尺子代理  Sports Ruler Delegate∫
 */
@protocol QuickSportsRulerDelegate <NSObject>

@optional
/**
 * @brief 运动尺滚动回调
 * @param ruler 运动尺子
 * @param value 经过处理的值 如：1000 -> 1,000
 */
- (void)quickSportsRulerDidScroll:(QuickSportsRuler *)ruler resolvedValue:(NSString*)value;

@end

/**
 * @brief 运动尺子  Sports Ruler
 */
IB_DESIGNABLE
@interface QuickSportsRuler : UIView

/**
 * @brief 当前值
 */
@property (nonatomic, readonly) CGFloat value;

/**
 * @brief 运动尺样式
 */
@property (nonatomic, strong) QuickSportsRulerStyle* rulerStyle;

/**
 * @brief delegate
 */
@property (nonatomic, weak) id<QuickSportsRulerDelegate> delegate;

/**
 * @brief 初始化
 */
- (instancetype) initWithRulerStyle:(QuickSportsRulerStyle*)style;

/**
 * 设置需要刷新样式
 */
- (void)setNeedsReloadStyle;
@end
