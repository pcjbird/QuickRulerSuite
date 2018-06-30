//
//  QuickSportsRuler.m
//  QuickRulerSuite
//
//  Created by pcjbird on 2018/6/30.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import "QuickSportsRuler.h"
#import "NSString+QuickSportsRulerSeperator.h"

#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define WIDTH6 375.0
#define XX_6(value)     (1.0 * (value) * WIDTH / WIDTH6)
#define QUICKSPORTSRULER_BUNDLE [NSBundle bundleWithPath:[[NSBundle bundleForClass:[QuickSportsRuler class]] pathForResource:@"QuickRulerSuite" ofType:@"bundle"]]

#define kFloatCompareDelta    0.1

#pragma mark QuickSportsRulerScrollView

@interface QuickSportsRulerScrollView : UIScrollView
{
    CGFloat _rulerWidth;
    CGFloat _rulerHeight;
}
@property (nonatomic, strong)NSMutableArray *tempLayers;
@property (nonatomic, strong)NSMutableArray *tempRulerLabels;
@property (nonatomic, strong)NSMutableArray *colorsArray;

@property (nonatomic, weak) QuickSportsRulerStyle *style;
@property (nonatomic, assign) NSInteger  beginTick;
@property (nonatomic, assign) NSUInteger currentTick;
@property (nonatomic, assign) NSUInteger totalTicks;
@end


@implementation QuickSportsRulerScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame])
    {
        [self initVariables];
        _rulerWidth = frame.size.width;
        _rulerHeight = frame.size.height;
        [self initControls];
    }
    return self;
}

-(void) initVariables
{
    _rulerWidth = [UIScreen mainScreen].bounds.size.width;
    _rulerHeight = XX_6(50.0f);
    _tempLayers = [NSMutableArray new];
    _tempRulerLabels = [NSMutableArray new];
    _colorsArray = [NSMutableArray new];
    _beginTick = _currentTick = 0;
}

-(void) initControls
{
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Custom draw.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    // Avoid memory leak.
    for (CALayer *alayer in _tempLayers)
    {
        [alayer removeFromSuperlayer];
    }
    for (UILabel *label in _tempRulerLabels)
    {
        [label removeFromSuperview];
    }
    [_tempLayers removeAllObjects];
    [_tempRulerLabels removeAllObjects];
    
    // Draw the line on the left of marker.
    NSUInteger colorIndex = 0, gradientCount = [_colorsArray count];
    for (NSInteger i = _currentTick; i >= 0; i--)
    {
        @autoreleasepool
        {
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            if (gradientCount > 0 && colorIndex < gradientCount)
            {
                shapeLayer.strokeColor = ((UIColor *)[_colorsArray objectAtIndex:colorIndex++]).CGColor;
            }
            else
            {
                shapeLayer.strokeColor = self.style.tickColor.CGColor;
            }
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            shapeLayer.lineWidth = _style.lineWidth;
            shapeLayer.lineCap = kCALineCapButt;
            
            if ((i+_beginTick) % 10 == 0)
            {
                CGPathMoveToPoint(pathRef, NULL, self.style.stepSpacing * i , _rulerHeight - self.style.lineHeight10);
                CGPathAddLineToPoint(pathRef, NULL, self.style.stepSpacing * i, _rulerHeight);
                
                // Add title text.
                UILabel *ruleLabel = [[UILabel alloc] init];
                ruleLabel.textColor = self.style.tickColor;
                ruleLabel.font = [UIFont systemFontOfSize:ceil(self.style.tickFontSize)];
                ruleLabel.text = [NSString stringWithFormat:@"%.0f", i * self.style.unitValue + self.style.minTickValue];
                CGSize textSize = [ruleLabel.text sizeWithAttributes:@{ NSFontAttributeName : ruleLabel.font }];
                ruleLabel.frame = CGRectMake(self.style.stepSpacing * i - textSize.width / 2, 5, 0, 0);
                [ruleLabel sizeToFit];
                [self addSubview:ruleLabel];
                [_tempRulerLabels addObject:ruleLabel];
            }
            else if ((i+_beginTick) % 5 == 0)
            {
                CGPathMoveToPoint(pathRef, NULL, self.style.stepSpacing * i , _rulerHeight - self.style.lineHeight5);
                CGPathAddLineToPoint(pathRef, NULL, self.style.stepSpacing * i, _rulerHeight);
            }
            else
            {
                CGPathMoveToPoint(pathRef, NULL, self.style.stepSpacing * i , _rulerHeight - self.style.lineHeight1);
                CGPathAddLineToPoint(pathRef, NULL, self.style.stepSpacing * i, _rulerHeight);
            }
            shapeLayer.path = pathRef;
            CGPathRelease(pathRef);
            [self.layer addSublayer:shapeLayer];
            [_tempLayers addObject:shapeLayer];
        }
    }
    
    // Draw line on the right of marker.
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [self.style tickColor].CGColor;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.lineWidth = [self.style lineWidth];
    shapeLayer.lineCap = kCALineCapButt;
    
    for (NSUInteger i = _currentTick; i <= _totalTicks; i++)
    {
        @autoreleasepool
        {
            if ((i+_beginTick) % 10 == 0)
            {
                CGPathMoveToPoint(pathRef, NULL, self.style.stepSpacing * i , _rulerHeight - self.style.lineHeight10);
                CGPathAddLineToPoint(pathRef, NULL, self.style.stepSpacing * i, _rulerHeight);
                
                UILabel *ruleLabel = [[UILabel alloc] init];
                ruleLabel.textColor = [self.style tickColor];
                ruleLabel.font = [UIFont systemFontOfSize:ceil([self.style tickFontSize])];
                ruleLabel.text = [NSString stringWithFormat:@"%.0f", i * self.style.unitValue + self.style.minTickValue];
                CGSize textSize = [ruleLabel.text sizeWithAttributes:@{ NSFontAttributeName : ruleLabel.font }];
                ruleLabel.frame = CGRectMake(self.style.stepSpacing * i - textSize.width / 2, 5, 0, 0);
                [ruleLabel sizeToFit];
                [self addSubview:ruleLabel];
                [_tempRulerLabels addObject:ruleLabel];
            }
            else if ((i+_beginTick) % 5 == 0)
            {
                CGPathMoveToPoint(pathRef, NULL, self.style.stepSpacing * i , _rulerHeight - self.style.lineHeight5);
                CGPathAddLineToPoint(pathRef, NULL, self.style.stepSpacing * i, _rulerHeight);
            }
            else
            {
                CGPathMoveToPoint(pathRef, NULL, self.style.stepSpacing * i , _rulerHeight - self.style.lineHeight1);
                CGPathAddLineToPoint(pathRef, NULL, self.style.stepSpacing * i, _rulerHeight);
            }
        }
    }
    shapeLayer.path = pathRef;
    CGPathRelease(pathRef);
    [self.layer addSublayer:shapeLayer];
    [_tempLayers addObject:shapeLayer];
}

#pragma mark - Public.
-(void)setCurrentTick:(NSUInteger)currentTick
{
    _currentTick = currentTick;
    if ([_style gradientColors])
    {
        [self p_getGradientColors];
        [self setNeedsDisplay];
    }
}

- (void)p_getGradientColors
{
    
    if (!_style.gradientColors || _style.gradientColors.count != 2) return;
    
    CGFloat lRed, lGreen, lBlue, rRed, rGreen, rBlue, alpha;
    
    UIColor *leftColor = [_style gradientColors][0];
    UIColor *rightColor = [_style gradientColors][1];
    
    BOOL leftValid = [leftColor getRed:&lRed green:&lGreen blue:&lBlue alpha:&alpha];
    BOOL rightValid = [rightColor getRed:&rRed green:&rGreen blue:&rBlue alpha:&alpha];
    
    if (!leftValid || !rightValid) return;
    
    // Check how many colors will need.
    CGFloat space = _currentTick * _style.stepSpacing;
    CGFloat halfWidth = WIDTH / 2.f;
    if (space > halfWidth)
    {
        space = halfWidth;
    }
    NSUInteger colorCount = space / _style.stepSpacing;
    if (colorCount == 0) return;
    
    // R.G.B steps
    CGFloat redStep = 0.f, greenStep = 0.f, blueStep = 0.f;
    
    redStep = (lRed - rRed) / colorCount;
    greenStep = (lGreen - rGreen) / colorCount;
    blueStep = (lBlue - rBlue) / colorCount;
    
    [_colorsArray removeAllObjects];
    
    // Gradient colors.
    [_colorsArray addObject:[_style.gradientColors objectAtIndex:1]];
    for (int i = 0; i < colorCount; ++i)
    {
        rRed += redStep;
        rGreen += greenStep;
        rBlue += blueStep;
        [_colorsArray addObject:[UIColor colorWithRed:rRed green:rGreen blue:rBlue alpha:1.f]];
    }
    [_colorsArray addObject:[_style gradientColors][0]];;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
}

-(void) updateUI
{
    _rulerWidth = CGRectGetWidth(self.bounds);
    _rulerHeight = CGRectGetHeight(self.bounds);
    CGFloat rulerHalfWidth = _rulerWidth / 2.f;
    if([_style isKindOfClass:[QuickSportsRulerStyle class]])
    {
        _totalTicks = (_style.maxTickValue - _style.minTickValue)/_style.unitValue;
        _currentTick = (_style.initValue - _style.minTickValue)/_style.unitValue;
        _beginTick = _style.minTickValue/_style.unitValue;
        
        self.contentInset = UIEdgeInsetsMake(0, rulerHalfWidth, 0, rulerHalfWidth);
        self.contentSize = CGSizeMake(_totalTicks * _style.stepSpacing, _rulerHeight);
        self.contentOffset = CGPointMake((_style.stepSpacing * (self.currentTick)) - rulerHalfWidth, 0);
    }
}

#pragma mark - Setter.
-(void)setStyle:(QuickSportsRulerStyle *)style
{
    _style = style;
    if(![_style isKindOfClass:[QuickSportsRulerStyle class]])
    {
        NSLog(@"QuickSportsRulerScrollView 未正确设置 SportsRulerStyle。");
        return;
    }
    _totalTicks = (_style.maxTickValue - _style.minTickValue)/_style.unitValue;
    _currentTick = (_style.initValue - _style.minTickValue)/_style.unitValue;
    _beginTick = _style.minTickValue/_style.unitValue;
    
    CGFloat rulerHalfWidth = _rulerWidth / 2.f;
    self.contentInset = UIEdgeInsetsMake(0, rulerHalfWidth, 0, rulerHalfWidth);
    self.contentSize = CGSizeMake(_totalTicks * _style.stepSpacing, _rulerHeight);
     self.contentOffset = CGPointMake((_style.stepSpacing * (self.currentTick)) - rulerHalfWidth, 0);
}
@end


#pragma mark QuickSportsRuler

@interface QuickSportsRuler()<UIScrollViewDelegate>

@property (nonatomic, strong) QuickSportsRulerScrollView *scrollView;
@property (nonatomic, strong) CAShapeLayer *bottomLineView;
@property (nonatomic, strong) UIImageView *marker;

@end

@implementation QuickSportsRuler

-(instancetype)init
{
    if(self = [super init])
    {
        [self initVariables];
        [self addChildControls];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self initVariables];
        [self addChildControls];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self initVariables];
        [self addChildControls];
    }
    return self;
}

/**
 * @brief 初始化
 */
- (instancetype) initWithRulerStyle:(QuickSportsRulerStyle*)style
{
    if(self = [super init])
    {
        [self initVariables];
        if([style isKindOfClass:[QuickSportsRulerStyle class]])
        {
            self.rulerStyle = style;
        }
        [self addChildControls];
    }
    return self;
}

-(void)setRulerStyle:(QuickSportsRulerStyle *)rulerStyle
{
    _rulerStyle = rulerStyle;
    if(self.scrollView && _rulerStyle)
    {
        self.scrollView.style = _rulerStyle;
    }
}

- (void)setNeedsReloadStyle
{
    if(self.rulerStyle)
    {
        self.marker.tintColor = self.rulerStyle.markerColor;
        self.backgroundColor = self.rulerStyle.backgroundColor;
        if(self.rulerStyle.marker)
        {
            self.marker.image = [self.rulerStyle.marker imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.marker sizeToFit];
        }
    }
    [self setNeedsLayout];
    if(self.scrollView && _rulerStyle)
    {
        self.scrollView.style = _rulerStyle;
        [self.scrollView setNeedsLayout];
        [self.scrollView setNeedsDisplay];
    }
}

-(void) initVariables
{
    self.rulerStyle = [QuickSportsRulerStyle new];
}

- (void) addChildControls
{
    self.backgroundColor = self.rulerStyle.backgroundColor;
    [self addSubview:self.scrollView];
    [self addSubview:self.marker];
    [self p_drawBottomLineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = CGRectMake(0, self.frame.size.height - XX_6(50), self.frame.size.width, XX_6(50));
    self.marker.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame) - (CGRectGetHeight(self.marker.frame)/2.0f));
}

-(QuickSportsRulerScrollView *)scrollView
{
    if (!_scrollView)
    {
        CGRect frame = CGRectMake(0, self.frame.size.height - XX_6(50), self.frame.size.width, XX_6(50));
        _scrollView = [[QuickSportsRulerScrollView alloc] initWithFrame:frame];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.delegate = self;
        _scrollView.style = self.rulerStyle;
        _scrollView.accessibilityLabel = @"SportsRulerScrollView";
    }
    return _scrollView;
}

- (UIImageView *)marker
{
    if (!_marker)
    {
        UIImage *markerImage = [UIImage imageNamed:@"marker" inBundle:QUICKSPORTSRULER_BUNDLE compatibleWithTraitCollection:nil];
        if(!markerImage) markerImage = [UIImage imageNamed:@"marker"];
        if(self.rulerStyle && self.rulerStyle.marker)
        {
            markerImage = self.rulerStyle.marker;
        }
        _marker = [[UIImageView alloc] initWithImage:[markerImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _marker.tintColor = self.rulerStyle ? self.rulerStyle.markerColor : [UIColor redColor];
        _marker.backgroundColor = [UIColor clearColor];
        _marker.frame = CGRectMake(0, self.frame.size.height - XX_6(71), XX_6(16), XX_6(71));
    }
    return _marker;
}

- (CGFloat)value
{
    return self.scrollView.currentTick * _rulerStyle.unitValue + _rulerStyle.minTickValue;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(QuickSportsRulerScrollView *)scrollView
{
    
    CGFloat ticks = (scrollView.contentOffset.x + self.frame.size.width / 2) / self.rulerStyle.stepSpacing;
    if (ticks < 0 || ticks > scrollView.totalTicks + kFloatCompareDelta)
    {
        return;
    }
    ticks = [self p_roundWithValue:ticks];
    [scrollView setCurrentTick:(NSUInteger)ticks];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(quickSportsRulerDidScroll:resolvedValue:)])
    {
        NSString* resolvedVal = [[NSString stringWithFormat:@"%0.f", self.value] quickSportsStringBySeperator:@"," withDistance:3];
        [self.delegate quickSportsRulerDidScroll:self resolvedValue:resolvedVal];
    }
}

- (void)scrollViewDidEndDecelerating:(QuickSportsRulerScrollView *)scrollView
{
    
    [self p_animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(QuickSportsRulerScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self p_animationRebound:scrollView];
}

#pragma mark - Private.
- (void)p_animationRebound:(QuickSportsRulerScrollView *)scrollView
{
    
    CGFloat ticks = (scrollView.contentOffset.x + self.frame.size.width / 2) / self.rulerStyle.stepSpacing;
    ticks = [self p_roundWithValue:ticks];
    
    [UIView animateWithDuration:.15f animations:^{
        scrollView.contentOffset = CGPointMake(ticks * self.rulerStyle.stepSpacing - self.frame.size.width / 2, 0);
    }];
}

- (CGFloat)p_roundWithValue:(CGFloat)value
{
    if(value < (self.rulerStyle.minLimitValue-self.rulerStyle.minTickValue)/self.rulerStyle.unitValue) value = (self.rulerStyle.minLimitValue-self.rulerStyle.minTickValue)/self.rulerStyle.unitValue;
    if(value > (self.rulerStyle.maxLimitValue-self.rulerStyle.minTickValue)/self.rulerStyle.unitValue) value = (self.rulerStyle.maxLimitValue-self.rulerStyle.minTickValue)/self.rulerStyle.unitValue;
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler
                                                decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                scale:0
                                                raiseOnExactness:NO
                                                raiseOnOverflow:NO
                                                raiseOnUnderflow:NO
                                                raiseOnDivideByZero:NO];
    NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithFloat:value];
    NSDecimalNumber *roundedDecimal = [decimalNumber decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [roundedDecimal floatValue];
}

#pragma mark - private
- (void)p_drawBottomLineView
{
    if(!_bottomLineView)
    {
        CAShapeLayer *line = [CAShapeLayer layer];
        line.strokeColor = [self.rulerStyle.bottomStrokeColor CGColor];
        line.fillColor = [self.rulerStyle.bottomStrokeColor CGColor];
        line.lineWidth = 0.5f;
        line.lineCap = kCALineCapSquare;
        line.accessibilityLabel = @"SportsRuleBottomLine";
        [self.layer addSublayer:line];
        _bottomLineView = line;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat xPoint = CGRectGetWidth(self.frame);
    
    CGPathMoveToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    CGPathAddLineToPoint(path, NULL, xPoint, CGRectGetHeight(self.frame));
    self.bottomLineView.path = path;
    CGPathRelease(path);
}

@end
