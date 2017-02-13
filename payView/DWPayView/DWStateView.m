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
        }else if (type == DWStateDisplayTypeSuccessTickWithFullCoolor){
            
            [self successTickWithFullColor:color];
        }else if (type == DWStateDisplayTypeFailCrossWithFullCoolor){
            
            [self failCrossWithFullColor:color];
        }
    }
    
    
    return self;
}

- (void)drawCircle{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineCap = kCALineCapRound;
    
    CABasicAnimation* strokeEndAnimation =[self basicAnimationWithKeyPath:@"strokeEnd" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0 duration:1.0f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CABasicAnimation* strokeStartAnimation = [self basicAnimationWithKeyPath:@"strokeStart" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:1.0f duration:1.0f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[strokeEndAnimation,strokeStartAnimation];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeBoth;
    group.duration = 1.9;
    group.repeatCount = MAXFLOAT;
    [shapeLayer addAnimation:group forKey:@"nil"];
    
    CABasicAnimation *rotationAnimation = [self rotationAnimationFromValue:[NSNumber numberWithFloat:0] toValue:[NSNumber numberWithFloat:2.0*M_PI] repeatCount:MAXFLOAT duration:2];
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
    
    CABasicAnimation *rotationAnimation = [self rotationAnimationFromValue:[NSNumber numberWithFloat:0] toValue:[NSNumber numberWithFloat:2.0*M_PI] repeatCount:MAXFLOAT duration:1.5];
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
}

-(void)successTickWithColor:(UIColor*)color{
    
    shapeLayer.lineCap = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    
    
    CABasicAnimation* strokeEndAnimation = [self basicAnimationWithKeyPath:@"strokeEnd" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0 duration:0.8f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CABasicAnimation* strokeStartAnimation = [self basicAnimationWithKeyPath:@"strokeStart" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0.80f duration:0.80f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[strokeEndAnimation,strokeStartAnimation];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeBoth;
    group.repeatCount = 1;
    group.duration = 0.8;
    [shapeLayer addAnimation:group forKey:@"nil"];
    
    CABasicAnimation *rotationAnimation = [self rotationAnimationFromValue:[NSNumber numberWithFloat:0] toValue:[NSNumber numberWithFloat:2.0*M_PI] repeatCount:1 duration:0.8];
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
    
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
    
    CABasicAnimation *tickAnima = [self basicAnimationWithKeyPath:@"strokeEnd" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0.8f duration:2.5f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
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
    
    CABasicAnimation *strokeEndAnima = [self basicAnimationWithKeyPath:@"strokeEnd" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0 duration:0.8f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CABasicAnimation* strokeStartAnima = [self basicAnimationWithKeyPath:@"strokeStart" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0.80f duration:0.80f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[strokeEndAnima,strokeStartAnima];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeBoth;
    group.repeatCount = 1;
    group.duration = 0.8;
    [shapeLayer addAnimation:group forKey:@"nil"];
    
    CABasicAnimation* rotationAnimation = [self rotationAnimationFromValue:[NSNumber numberWithFloat:0] toValue:[NSNumber numberWithFloat:2.0*M_PI] repeatCount:1 duration:0.8];
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
    
    
    CAShapeLayer*crossShapeLayer = [CAShapeLayer layer];
    crossShapeLayer.frame = self.bounds;
    crossShapeLayer.fillColor = [UIColor clearColor].CGColor;
    crossShapeLayer.lineWidth = 3;
    crossShapeLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:crossShapeLayer];
    
    CGFloat W = self.bounds.size.width ;
    CGFloat H = self.bounds.size.height;
    UIBezierPath *crossPath  = [UIBezierPath bezierPath];
    [crossPath moveToPoint:CGPointMake(W/5,H/5)];
    [crossPath addLineToPoint:CGPointMake(4*W/5,4*H/5)];
    UIBezierPath *crossPath1  = [UIBezierPath bezierPath];
    [crossPath1 moveToPoint:CGPointMake(4*W/5,H/5)];
    [crossPath1 addLineToPoint:CGPointMake(W/5,4*H/5)];
    [crossPath appendPath:crossPath1];
    crossShapeLayer.path = crossPath.CGPath;
    
    CABasicAnimation *tickAnima = [self basicAnimationWithKeyPath:@"strokeEnd" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0.8f duration:2.0f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CABasicAnimation* emtyAnima = [[CABasicAnimation alloc]init];
    emtyAnima.duration = 0.8f;
    
    CAAnimationGroup *tickGroup = [CAAnimationGroup animation];
    tickGroup.animations =@[emtyAnima,tickAnima];
    tickGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tickGroup.repeatCount = 1;
    tickGroup.duration = 3.2;
    
    [crossShapeLayer addAnimation:tickGroup forKey:nil];
    
    
}

-(void)successTickWithFullColor:(UIColor*)color{
    
    shapeLayer.lineCap = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    
    
    CABasicAnimation* strokeEndAnimation = [self basicAnimationWithKeyPath:@"strokeEnd" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0 duration:0.8f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CABasicAnimation* strokeStartAnimation = [self basicAnimationWithKeyPath:@"strokeStart" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0.80f duration:0.80f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[strokeEndAnimation,strokeStartAnimation];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeBoth;
    group.repeatCount = 1;
    group.duration = 0.8;
    group.delegate = self;
    group.removedOnCompletion = NO;
    [shapeLayer addAnimation:group forKey:@"successTickGroup"];
    
    CABasicAnimation *rotationAnimation = [self rotationAnimationFromValue:[NSNumber numberWithFloat:0] toValue:[NSNumber numberWithFloat:2.0*M_PI] repeatCount:1 duration:0.8];
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
    
    
}

-(void)failCrossWithFullColor:(UIColor*)color{
    
    
    shapeLayer.lineCap = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    shapeLayer.path = path.CGPath;
    
    CABasicAnimation *strokeEndAnima = [self basicAnimationWithKeyPath:@"strokeEnd" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0 duration:0.8f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CABasicAnimation* strokeStartAnima =  [self basicAnimationWithKeyPath:@"strokeStart" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0.80f duration:0.80f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[strokeEndAnima,strokeStartAnima];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeBoth;
    group.repeatCount = 1;
    group.duration = 0.8;
    group.delegate = self;
    group.removedOnCompletion = NO;
    [shapeLayer addAnimation:group forKey:@"failCrossGroup"];
    
    CABasicAnimation* rotationAnimation = [self rotationAnimationFromValue:[NSNumber numberWithFloat:0] toValue:[NSNumber numberWithFloat:2.0*M_PI] repeatCount:1 duration:0.8];
    [shapeLayer addAnimation:rotationAnimation forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    
    
    if ([theAnimation isEqual:[shapeLayer animationForKey:@"successTickGroup"]]) {
        
        shapeLayer.fillColor = shapeLayer.strokeColor;
        
        CAShapeLayer* whiteLayer = [[CAShapeLayer alloc]init];
        whiteLayer.frame = self.bounds;
        whiteLayer.fillColor = [UIColor whiteColor].CGColor;
        whiteLayer.lineWidth = 3;
        whiteLayer.strokeColor =shapeLayer.strokeColor;
        [self.layer addSublayer:whiteLayer];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        whiteLayer.path = path.CGPath;
        
        CABasicAnimation *scaleAnimation = [self basicAnimationWithKeyPath:@"transform.scale" fromValue:[NSNumber numberWithFloat:1.0] toValue:[NSNumber numberWithFloat:0.0] repeatCount:0 beginTime:0 duration:1.0f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeForwards delegate:self];
        [scaleAnimation setValue:@"successTickAnimation" forKey:@"animationKey"];
        [whiteLayer addAnimation:scaleAnimation forKey:nil];
        
    }else if ([[theAnimation valueForKey:@"animationKey"]isEqualToString:@"successTickAnimation"]){
        
        CAShapeLayer*tickshapeLayer = [CAShapeLayer layer];
        tickshapeLayer.frame = self.bounds;
        tickshapeLayer.fillColor = [UIColor clearColor].CGColor;
        tickshapeLayer.lineWidth = 3;
        tickshapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:tickshapeLayer];
        
        CGFloat W = self.bounds.size.width ;
        CGFloat H = self.bounds.size.height;
        UIBezierPath *tickPath  = [UIBezierPath bezierPath];
        [tickPath moveToPoint:CGPointMake(W/8,H/2)];
        [tickPath addLineToPoint:CGPointMake(W/2.5,(H/2)+ H/4)];
        [tickPath addLineToPoint:CGPointMake(W-(W/6),H/4)];
        tickshapeLayer.path = tickPath.CGPath;
        
        CABasicAnimation *tickAnima = [self basicAnimationWithKeyPath:@"strokeEnd" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0 duration:2.0f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
        
        [tickshapeLayer addAnimation:tickAnima forKey:nil];
        
        
    }else if ([theAnimation isEqual:[shapeLayer animationForKey:@"failCrossGroup"]]) {
        
        shapeLayer.fillColor = shapeLayer.strokeColor;
        
        CAShapeLayer* whiteLayer = [[CAShapeLayer alloc]init];
        whiteLayer.frame = self.bounds;
        whiteLayer.fillColor = [UIColor whiteColor].CGColor;
        whiteLayer.lineWidth = 3;
        whiteLayer.strokeColor = shapeLayer.strokeColor;
        [self.layer addSublayer:whiteLayer];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        whiteLayer.path = path.CGPath;
        
        CABasicAnimation *scaleAnimation = [self basicAnimationWithKeyPath:@"transform.scale" fromValue:[NSNumber numberWithFloat:1.0] toValue:[NSNumber numberWithFloat:0.0] repeatCount:0 beginTime:0 duration:1.0f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeForwards delegate:self];
        [scaleAnimation setValue:@"failCrossScaleAnimation" forKey:@"animationKey"];
        [whiteLayer addAnimation:scaleAnimation forKey:nil];
        
    }else if ([[theAnimation valueForKey:@"animationKey"]isEqualToString:@"failCrossScaleAnimation"]){
        
        CAShapeLayer*crossshapeLayer = [CAShapeLayer layer];
        crossshapeLayer.frame = self.bounds;
        crossshapeLayer.fillColor = [UIColor clearColor].CGColor;
        crossshapeLayer.lineWidth = 3;
        crossshapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:crossshapeLayer];
        
        CGFloat W = self.bounds.size.width ;
        CGFloat H = self.bounds.size.height;
        UIBezierPath *crossPath  = [UIBezierPath bezierPath];
        [crossPath moveToPoint:CGPointMake(W/5,H/5)];
        [crossPath addLineToPoint:CGPointMake(4*W/5,4*H/5)];
        UIBezierPath *crossPath1  = [UIBezierPath bezierPath];
        [crossPath1 moveToPoint:CGPointMake(4*W/5,H/5)];
        [crossPath1 addLineToPoint:CGPointMake(W/5,4*H/5)];
        [crossPath appendPath:crossPath1];
        crossshapeLayer.path = crossPath.CGPath;
        
        CABasicAnimation *tickAnima = [self basicAnimationWithKeyPath:@"strokeEnd" fromValue:[NSNumber numberWithFloat:0.0f] toValue:[NSNumber numberWithFloat:1.0f] repeatCount:1 beginTime:0 duration:2.0f timingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] removedOnCompletion:NO fillMode:kCAFillModeBoth delegate:self];
        
        [crossshapeLayer addAnimation:tickAnima forKey:nil];
        
    }
}


-(CABasicAnimation*)basicAnimationWithKeyPath:(NSString*)keypath
                                    fromValue:(id)fromValue
                                      toValue:(id)toValue
                                  repeatCount:(float)repeatCount
                                    beginTime:(CFTimeInterval)beginTime
                                     duration:(CFTimeInterval)duration
                               timingFunction:(CAMediaTimingFunction*)timingFunction
                          removedOnCompletion:(BOOL)removedOnCompletion
                                     fillMode:(NSString*)fillMode
                                     delegate:(id <CAAnimationDelegate>)delegate {
    
    CABasicAnimation *strokeEndAnimation= [CABasicAnimation animationWithKeyPath:keypath];
    strokeEndAnimation.duration = duration;
    strokeEndAnimation.beginTime = beginTime;
    strokeEndAnimation.timingFunction = timingFunction;
    strokeEndAnimation.fromValue = fromValue;
    strokeEndAnimation.toValue = toValue;
    strokeEndAnimation.removedOnCompletion = removedOnCompletion;
    strokeEndAnimation.fillMode =fillMode;
    strokeEndAnimation.delegate = delegate;
    
    return strokeEndAnimation;
    
}


-(CABasicAnimation*)rotationAnimationFromValue:(id)fromValue toValue:(id)toValue repeatCount:(float)repeatCount duration:(CFTimeInterval)duration{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = fromValue;
    rotationAnimation.toValue = toValue;
    rotationAnimation.repeatCount = repeatCount;
    rotationAnimation.duration = duration;
    
    return rotationAnimation;
}
@end
