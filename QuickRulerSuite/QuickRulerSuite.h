//
//  QuickRulerSuite.h
//  QuickRulerSuite
//
//  Created by pcjbird on 2018/6/30.
//  Copyright © 2018年 Zero Status. All rights reserved.
//
//  框架名称:QuickRulerSuite
//  框架功能:A suite to quick create ruler control on iOS, which seems to be attractive. iOS上标尺控件的集合。
//  修改记录:
//     pcjbird    2018-09-18  Version:1.0.3 Build:201809180001
//                            1.xcode 10 support
//
//     pcjbird    2018-07-08  Version:1.0.2 Build:201807080001
//                            1.修复屏幕设配的问题
//
//     pcjbird    2018-07-01  Version:1.0.1 Build:201807010002
//                            1.修复默认资源bundle加载失败的问题
//
//     pcjbird    2018-07-01  Version:1.0.0 Build:201807010001
//                            1.首次发布SDK版本
//

#import <UIKit/UIKit.h>

//! Project version number for QuickRulerSuite.
FOUNDATION_EXPORT double QuickRulerSuiteVersionNumber;

//! Project version string for QuickRulerSuite.
FOUNDATION_EXPORT const unsigned char QuickRulerSuiteVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <QuickRulerSuite/PublicHeader.h>


#if __has_include("QuickSportsRuler.h")
#import "QuickSportsRuler.h"
#endif
