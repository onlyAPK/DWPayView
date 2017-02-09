//
//  DWStateView.m
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWStateView.h"

@interface DWStateView()<CAAnimationDelegate>

@end


@implementation DWStateView

{
    CAShapeLayer *shapeLayer;
}
- (instancetype)initWithFrame:(CGRect)frame withType:(DWStateDisplayType)type withColor:(UIColor*)color{
    if (self = [super initWithFrame:frame]) {
        
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 3;
        shapeLayer.strokeColor = color.CGColor;
        [self.layer addSublayer:shapeLayer];
        
        if (type == DWStateDisplayTypeDrawCircle) {
            [self drawCircle];
        }else if (type == DWStateDisplayTypeAndroidLike){
            
            [self androidLike];
        }else if (type == DWStateDisplayTypeArcCircle){
            
            [self arcCircle];
        }else if (type == DWStateDisplayTypeSuccessTick){
            
            [self successTickWithColor:color];
        }else if (type == DWStateDisplayTypeFailCross){
            
            [self failCrossWithColor:color];
        }
    }
    
    
    return self;
}

- (void)drawCircle{
    
    
    shapeLayer.lineCap = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    
    
    CABasicAnimation *pathAnima2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima2.duration = 1.0f;
    pathAnima2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima2.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima2.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima2.removedOnCompletion = NO;
    pathAnima2.fillMode =kCAFillModeBoth;
    pathAnima2.delegate = self;
    
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    pathAnima.duration = 1.0f;
    pathAnima.beginTime = 1.00f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.removedOnCompletion = NO;
    pathAnima.fillMode =kCAFillModeBoth;
    pathAnima.delegate = self;
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[pathAnima2,pathAnima];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeBoth;
    group.duration = 1.9;
    group.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:group forKey:@"nil"];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 2;
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
    
}


-(void)androidLike{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    
    
    CAKeyframeAnimation* keyAnima = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    keyAnima.keyTimes = @[@0.0f,@0.6f,@1.0f];
    keyAnima.values = @[@0,@0.3,@1];
    keyAnima.duration = 2;
    keyAnima.fillMode = kCAFillModeForwards;
    keyAnima.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:keyAnima forKey:nil];
    
    
    
    CAKeyframeAnimation* keyAnima2 = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    keyAnima2.keyTimes = @[@0.0f,@0.5f,@1.0f];
    keyAnima2.values = @[@0.03,@1,@1];
    keyAnima2.duration = 2;
    keyAnima2.fillMode = kCAFillModeForwards;
    keyAnima2.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:keyAnima2 forKey:nil];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 2;
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
    
    
}


-(void)arcCircle{
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.width/2 startAngle:0 endAngle:1.7*M_PI clockwise:YES];
    
    shapeLayer.path = path.CGPath;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 1.5;
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
}

-(void)successTickWithColor:(UIColor*)color{
    
    shapeLayer.lineCap = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    
    
    CABasicAnimation *pathAnima2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima2.duration = 0.8f;
    pathAnima2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima2.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima2.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima2.removedOnCompletion = NO;
    pathAnima2.fillMode =kCAFillModeBoth;
    pathAnima2.delegate = self;
    
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    pathAnima.duration = 0.80f;
    pathAnima.beginTime = 0.80f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.removedOnCompletion = NO;
    pathAnima.fillMode =kCAFillModeBoth;
    pathAnima.delegate = self;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = 1;
    rotationAnimation.duration = 0.8;
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[pathAnima2,pathAnima];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeBoth;
    group.repeatCount = 1;
    group.duration = 0.8;
    [shapeLayer addAnimation:group forKey:@"nil"];
    
    CAShapeLayer*tickshapeLayer = [CAShapeLayer layer];
    tickshapeLayer.frame = self.bounds;
    tickshapeLayer.fillColor = [UIColor clearColor].CGColor;
    tickshapeLayer.lineWidth = 3;
    tickshapeLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:tickshapeLayer];
    
    CGFloat W = self.bounds.size.width ;
    CGFloat H = self.bounds.size.height;
    UIBezierPath *tickPath  = [UIBezierPath bezierPath];
    [tickPath moveToPoint:CGPointMake(W/8,H/2)];
    [tickPath addLineToPoint:CGPointMake(W/2.5,(H/2)+ H/4)];
    [tickPath addLineToPoint:CGPointMake(W-(W/6),H/4)];
    tickshapeLayer.path = tickPath.CGPath;
    
    CABasicAnimation *tickAnima= [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tickAnima.duration = 2.5f;
    tickAnima.beginTime = 0.8f;
    tickAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tickAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    tickAnima.toValue = [NSNumber numberWithFloat:1.0f];
    tickAnima.removedOnCompletion = NO;
    tickAnima.fillMode =kCAFillModeBoth;
    tickAnima.delegate = self;
    
    CABasicAnimation* emtyAnima = [[CABasicAnimation alloc]init];
    emtyAnima.duration = 0.8f;
    
    CAAnimationGroup *tickGroup = [CAAnimationGroup animation];
    tickGroup.animations =@[emtyAnima,tickAnima];
    tickGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tickGroup.repeatCount = 1;
    tickGroup.duration = 3.2;
    
    [tickshapeLayer addAnimation:tickGroup forKey:nil];
    
}

-(void)failCrossWithColor:(UIColor*)color{
    
    
    shapeLayer.lineCap = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    
    
    CABasicAnimation *pathAnima2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima2.duration = 0.8f;
    pathAnima2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima2.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima2.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima2.removedOnCompletion = NO;
    pathAnima2.fillMode =kCAFillModeBoth;
    pathAnima2.delegate = self;
    
    
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    pathAnima.duration = 0.80f;
    pathAnima.beginTime = 0.80f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnima.removedOnCompletion = NO;
    pathAnima.fillMode =kCAFillModeBoth;
    pathAnima.delegate = self;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = 1;
    rotationAnimation.duration = 0.8;
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[pathAnima2,pathAnima];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeBoth;
    group.repeatCount = 1;
    group.duration = 0.8;
    [shapeLayer addAnimation:group forKey:@"nil"];
    
    CAShapeLayer*tickshapeLayer = [CAShapeLayer layer];
    tickshapeLayer.frame = self.bounds;
    tickshapeLayer.fillColor = [UIColor clearColor].CGColor;
    tickshapeLayer.lineWidth = 3;
    tickshapeLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:tickshapeLayer];
    
    CGFloat W = self.bounds.size.width ;
    CGFloat H = self.bounds.size.height;
    UIBezierPath *tickPath  = [UIBezierPath bezierPath];
    [tickPath moveToPoint:CGPointMake(W/5,H/5)];
    [tickPath addLineToPoint:CGPointMake(4*W/5,4*H/5)];
    UIBezierPath *tickPath1  = [UIBezierPath bezierPath];
    [tickPath1 moveToPoint:CGPointMake(4*W/5,H/5)];
    [tickPath1 addLineToPoint:CGPointMake(W/5,4*H/5)];
    [tickPath appendPath:tickPath1];
    tickshapeLayer.path = tickPath.CGPath;
    
    CABasicAnimation *tickAnima= [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tickAnima.duration = 2.5f;
    tickAnima.beginTime = 0.8f;
    tickAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tickAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    tickAnima.toValue = [NSNumber numberWithFloat:1.0f];
    tickAnima.removedOnCompletion = NO;
    tickAnima.fillMode =kCAFillModeBoth;
    tickAnima.delegate = self;
    
    CABasicAnimation* emtyAnima = [[CABasicAnimation alloc]init];
    emtyAnima.duration = 0.8f;
    
    CAAnimationGroup *tickGroup = [CAAnimationGroup animation];
    tickGroup.animations =@[emtyAnima,tickAnima];
    tickGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tickGroup.repeatCount = 1;
    tickGroup.duration = 3.2;
    
    [tickshapeLayer addAnimation:tickGroup forKey:nil];
    
    
}

@end
