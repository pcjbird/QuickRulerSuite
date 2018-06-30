//
//  ViewController.m
//  QuickRulerSuiteDemo
//
//  Created by pcjbird on 2018/6/30.
//  Copyright © 2018年 Zero Status. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<QuickSportsRulerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *valLabel;
@property (weak, nonatomic) IBOutlet QuickSportsRuler *ruler;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.ruler.delegate = self;
    self.ruler.rulerStyle.unitValue = 1000;
    self.ruler.rulerStyle.minTickValue = -1000;
    self.ruler.rulerStyle.maxTickValue = 30000;
    self.ruler.rulerStyle.minLimitValue = 2000;
    self.ruler.rulerStyle.maxLimitValue = 28000;
    self.ruler.rulerStyle.stepSpacing = 16.0f;
    self.ruler.rulerStyle.initValue = 8000;
    [self.ruler setNeedsReloadStyle];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)quickSportsRulerDidScroll:(QuickSportsRuler *)ruler resolvedValue:(NSString *)value
{
    self.valLabel.text = value;
}
@end
