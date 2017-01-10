//
//  DWLineView.m
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWLineView.h"

@implementation DWLineView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.frame.size.height);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, 0);  //起点坐标
    CGContextAddLineToPoint(context, self.frame.size.width, 0);   //终点坐标
    
    CGContextStrokePath(context);
}

@end
