//
//  DWCrossView.m
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWCrossView.h"


#define LINEWIDTH 1
#define MAGRIN  10
@implementation DWCrossView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
         self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
   
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, LINEWIDTH);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 0/255.0, 0/255.0, 0/255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, MAGRIN, MAGRIN);  //起点坐标
    CGContextAddLineToPoint(context, self.frame.size.width-MAGRIN, self.frame.size.height-MAGRIN);   //终点坐标
    
    CGContextStrokePath(context);
    
    
    
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context2, kCGLineCapRound);
    CGContextSetLineWidth(context2, LINEWIDTH);  //线宽
    CGContextSetAllowsAntialiasing(context2, true);
    CGContextSetRGBStrokeColor(context2, 0/255.0, 0/255.0, 0/255.0, 1.0);  //线的颜色
    CGContextBeginPath(context2);
    
    CGContextMoveToPoint(context2, self.frame.size.width-MAGRIN, MAGRIN);  //起点坐标
    CGContextAddLineToPoint(context2, MAGRIN, self.frame.size.height-MAGRIN);   //终点坐标
    
    CGContextStrokePath(context2);
}

@end
