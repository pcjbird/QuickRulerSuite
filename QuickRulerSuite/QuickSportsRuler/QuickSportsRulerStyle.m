//
//  QuickSportsRulerStyle.m
//  QuickRulerSuite
//
//  Created by pcjbird on 2018/6/30.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#define WIDTH ([UIScreen  mainScreen].bounds.size.width)
#define WIDTH6 375.0
#define XX_6(value)     (1.0 * (value) * WIDTH / WIDTH6)

#import "QuickSportsRulerStyle.h"

@implementation QuickSportsRulerStyle

-(instancetype)init
{
    if(self = [super init])
    {
        [self initVariables];
    }
    return self;
}

-(void) initVariables
{
    _backgroundColor = [UIColor clearColor];
    _markerColor = [UIColor redColor];
    _tickColor = [UIColor colorWithRed:(0xd8/255.0f) green:0xd8/255.0f blue:0xd8/255.0f alpha:1.0f];
    _gradientColors = @[[UIColor colorWithRed:(0x29/255.0f) green:0xb0/255.0f blue:0xe6/255.0f alpha:1.0f], [UIColor colorWithRed:(0xfe/255.0f) green:0x00/255.0f blue:0x58/255.0f alpha:1.0f]];
    _bottomStrokeColor = [UIColor colorWithRed:(0xd8/255.0f) green:0xd8/255.0f blue:0xd8/255.0f alpha:1.0f];
    _minTickValue = 0;
    _maxTickValue = 10000;
    _unitValue = 1;
    _minLimitValue = 0;
    _maxLimitValue = 10000;
    _initValue = 0;
    
    _stepSpacing = XX_6(8);
    _lineWidth = XX_6(2);
    _lineHeight1 = XX_6(12);
    _lineHeight5 = XX_6(28);
    _lineHeight10 = XX_6(28);
    _tickFontSize = XX_6(10);
}

-(void)setMarker:(UIImage *)marker
{
    if([marker isKindOfClass:[UIImage class]])
    {
        _marker = [marker imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
}

-(void)setUnitValue:(CGFloat)unitValue
{
    _unitValue = (unitValue >= 1) ? unitValue : 1;
    [self setInitValue:_initValue];
}

-(void)setMinTickValue:(CGFloat)minTickValue
{
    _minTickValue = minTickValue;
    [self setInitValue:_initValue];
    [self setMinLimitValue:_minTickValue];
}

-(void)setMaxTickValue:(CGFloat)maxTickValue
{
    _maxTickValue = (maxTickValue > _minTickValue) ? maxTickValue : _minTickValue + 10000;
    [self setInitValue:_initValue];
    [self setMaxLimitValue:_maxTickValue];
}

-(void)setMinLimitValue:(CGFloat)minLimitValue
{
    _minLimitValue = (minLimitValue >= _minTickValue) ? minLimitValue : _minTickValue;
    [self setInitValue:_initValue];
}

-(void)setMaxLimitValue:(CGFloat)maxLimitValue
{
    _maxLimitValue = (maxLimitValue <= _maxTickValue) ? maxLimitValue : _maxTickValue;
    [self setInitValue:_initValue];
}

-(void)setInitValue:(CGFloat)initValue
{
    _initValue = (initValue >= _minLimitValue && initValue <= _maxLimitValue) ? initValue : _minLimitValue;
}

-(void)setStepSpacing:(CGFloat)stepSpacing
{
    _stepSpacing = (stepSpacing >= 2.0f) ? stepSpacing : 2.0f;
}

-(void)setGradientColors:(NSArray *)gradientColors
{
    if(!gradientColors || ([gradientColors isKindOfClass:[NSArray<UIColor*> class]] && [gradientColors count] == 2))
    {
        _gradientColors = gradientColors;
    }
    else
    {
        NSLog(@"渐变色数组长度必须为2。");
    }
}

@end
