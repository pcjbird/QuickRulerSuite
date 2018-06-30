![logo](logo.png)
[![Build Status](http://img.shields.io/travis/pcjbird/QuickRulerSuite/master.svg?style=flat)](https://travis-ci.org/pcjbird/QuickRulerSuite)
[![Pod Version](http://img.shields.io/cocoapods/v/QuickRulerSuite.svg?style=flat)](http://cocoadocs.org/docsets/QuickRulerSuite/)
[![Pod Platform](http://img.shields.io/cocoapods/p/QuickRulerSuite.svg?style=flat)](http://cocoadocs.org/docsets/QuickRulerSuite/)
[![Pod License](http://img.shields.io/cocoapods/l/QuickRulerSuite.svg?style=flat)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![CocoaPods](https://img.shields.io/cocoapods/at/QuickRulerSuite.svg)](https://github.com/pcjbird/QuickRulerSuite)
[![CocoaPods](https://img.shields.io/cocoapods/dt/QuickRulerSuite.svg)](https://github.com/pcjbird/QuickRulerSuite)
[![GitHub release](https://img.shields.io/github/release/pcjbird/QuickRulerSuite.svg)](https://github.com/pcjbird/QuickRulerSuite/releases)
[![GitHub release](https://img.shields.io/github/release-date/pcjbird/QuickRulerSuite.svg)](https://github.com/pcjbird/QuickRulerSuite/releases)
[![Website](https://img.shields.io/website-pcjbird-down-green-red/https/shields.io.svg?label=author)](https://pcjbird.github.io)

# QuickRulerSuite
### A suite to quick create ruler control on iOS, which seems to be attractive. iOS上标尺控件的集合。


##  安装 / Installation

方法一：`QuickRulerSuite` is available through CocoaPods. To install it, simply add the following line to your Podfile:

```
pod 'QuickRulerSuite'
```

## 使用 / Usage
  
  ```
 @property (weak, nonatomic) IBOutlet QuickSportsRuler *ruler;
 ```
  
  ```
 self.ruler.delegate = self;
 self.ruler.rulerStyle.unitValue = 1000;
 self.ruler.rulerStyle.minTickValue = -1000;
 self.ruler.rulerStyle.maxTickValue = 30000;
 self.ruler.rulerStyle.minLimitValue = 2000;
 self.ruler.rulerStyle.maxLimitValue = 28000;
 self.ruler.rulerStyle.stepSpacing = 16.0f;
 self.ruler.rulerStyle.initValue = 8000;
 [self.ruler setNeedsReloadStyle];
 ```
     
 ```
 -(void)quickSportsRulerDidScroll:(QuickSportsRuler *)ruler resolvedValue:(NSString *)value
 {
    self.valLabel.text = value;
 }
 ``` 
  
  
  ## 关注我们 / Follow us
  
  <a href="https://itunes.apple.com/cn/app/iclock-一款满足-挑剔-的翻页时钟与任务闹钟/id1128196970?pt=117947806&ct=com.github.pcjbird.QuickRulerSuite&mt=8"><img src="https://github.com/pcjbird/AssetsExtractor/raw/master/iClock.gif" width="400" title="iClock - 一款满足“挑剔”的翻页时钟与任务闹钟"></a>
  
  [![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/pcjbird/QuickRulerSuite)
  [![Twitter Follow](https://img.shields.io/twitter/follow/pcjbird.svg?style=social)](https://twitter.com/pcjbird)

