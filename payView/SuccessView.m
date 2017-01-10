//
//  SuccessView.m
//  payView
//
//  Created by DA WENG on 2017/1/6.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "SuccessView.h"

@implementation SuccessView
{
    UIView *_logoView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self drawSuccessLine];
        
    }
    return self;
}

- (void)drawSuccessLine{
    
    [_logoView removeFromSuperview];
    _logoView = [[UIView alloc] initWithFrame:self.frame];
    //曲线建立开始点和结束点
    //1. 曲线的中心
    //2. 曲线半径
    //3. 开始角度
    //4. 结束角度
    //5. 顺/逆时针方向
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:self.frame.size.width/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    //对拐角和中点处理
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    //对号第一部分直线的起始
    [path moveToPoint:CGPointMake(self.frame.size.width/5, self.frame.size.width/2)];
    CGPoint p1 = CGPointMake(self.frame.size.width/5.0*2, self.frame.size.width/4.0*3);
    [path addLineToPoint:p1];
    
    //对号第二部分起始
    CGPoint p2 = CGPointMake(self.frame.size.width/8.0*7, self.frame.size.width/4.0+8);
    [path addLineToPoint:p2];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    //内部填充颜色
    layer.fillColor = [UIColor clearColor].CGColor;
    //线条颜色
    layer.strokeColor = [UIColor orangeColor].CGColor;
    //线条宽度
    layer.lineWidth = 1;
    layer.path = path.CGPath;
    //动画设置
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [_logoView.layer addSublayer:layer];
    [self addSubview:_logoView];
}

@end
