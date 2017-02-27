//
//  DWSateView.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/15.
//  Copyright © 2017 DA WENG. All rights reserved.
//

import UIKit

enum DWStateDisplayType {
    case drawCircle     //画圆
    case androidLike    //安卓样式
    case arcCircle      //圆弧
    case successTick    //白底打钩
    case successTickWithFullCoolor//满色打钩
    case failCross     //白底打叉
    case failCrossWithFullCoolor//满色打叉
}

var shapeLayer = CAShapeLayer()

class DWSateView: UIView ,CAAnimationDelegate{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    convenience init(frame:CGRect,color:UIColor,type:DWStateDisplayType) {
        self.init(frame:frame)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.frame = self.bounds
        self.layer.addSublayer(shapeLayer)
        
        switch type {
        case DWStateDisplayType.drawCircle:
            drawCircle()
            
        case DWStateDisplayType.androidLike:
            androidLike()
            
        case DWStateDisplayType.arcCircle:
            arcCircle(percentAngle: 1.7)
            
        case DWStateDisplayType.successTick:
            successTick(color: color)
            
        case DWStateDisplayType.successTickWithFullCoolor:
            successTickWithFullColor(color: color)
            
        case DWStateDisplayType.failCross:
            failCross(color: color)
            
        case DWStateDisplayType.failCrossWithFullCoolor:
            failCrossWithFullColor(color: color)

        }
        
    }
    
    convenience init(frame:CGRect,color:UIColor,arcAnglePercent:Float) {
        self.init(frame:frame)
        
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.frame = self.bounds
        self.layer.addSublayer(shapeLayer)
        
        arcCircle(percentAngle: arcAnglePercent)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawCircle() {
        
        let path = UIBezierPath(ovalIn: self.bounds)
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = kCALineCapRound
        
        let strokeEndAnimation = basicAnimation(keypath: "strokeEnd", fromValue: 0.0, toValue: 1.0, repeatCount: 1.0, beginTime: 0, duration: 1.0, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
        
        
        let strokeStartAnimation = basicAnimation(keypath: "strokeStart", fromValue: 0.0, toValue: 1.0, repeatCount: 1.0, beginTime: 1.0, duration: 1.0, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [strokeEndAnimation,strokeStartAnimation]
        groupAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.fillMode = kCAFillModeBoth
        groupAnimation.duration = 2.0
        groupAnimation.repeatCount = MAXFLOAT
        shapeLayer.add(groupAnimation, forKey: nil)
        
        let rotate = rotationAnimationFromValue(fromValue: 0, toValue: 2*M_PI, repearCount: MAXFLOAT, duration: 2)
        shapeLayer.add(rotate, forKey: nil)
        
        
    }
    
    func androidLike(){
        
        let path = UIBezierPath(ovalIn: self.bounds)
        shapeLayer.path = path.cgPath
        let strokeStartAni = CAKeyframeAnimation(keyPath: "strokeStart")
        strokeStartAni.keyTimes = [0.0,0.6,1.0]
        strokeStartAni.values = [0,0.3,1]
        strokeStartAni.duration = 2
        strokeStartAni.fillMode = kCAFillModeForwards
        strokeStartAni.repeatCount = MAXFLOAT
        shapeLayer.add(strokeStartAni, forKey: nil)
        
        let strokeEndAni = CAKeyframeAnimation(keyPath: "strokeEnd")
        strokeEndAni.keyTimes = [0.0,0.5,1.0]
        strokeEndAni.values = [0.03,1,1]
        strokeEndAni.duration = 2
        strokeEndAni.fillMode = kCAFillModeForwards
        strokeEndAni.repeatCount = MAXFLOAT
        shapeLayer.add(strokeEndAni, forKey: nil)
        
        let rotation = rotationAnimationFromValue(fromValue: 0, toValue: 2.0*M_PI, repearCount: MAXFLOAT, duration: 2)
        shapeLayer.add(rotation, forKey: nil)
        
        
    }
    
    func successTick(color:UIColor) {
        
        shapeLayer.lineCap = kCALineCapRound
        let path = UIBezierPath(ovalIn: self.bounds)
        shapeLayer.path = path.cgPath
        
        let strokeEndAnimation = basicAnimation(keypath: "strokeEnd", fromValue: 0.0, toValue: 1.0, repeatCount: 1, beginTime: 0, duration: 0.8, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
        
        shapeLayer.add(strokeEndAnimation, forKey: nil)
        
        let rotationAni = rotationAnimationFromValue(fromValue: 0, toValue: 2.0*M_PI, repearCount: 1, duration: 0.8)
        shapeLayer.add(rotationAni, forKey: nil)
        
        let tickShapeLayer = CAShapeLayer()
        tickShapeLayer.frame = self.bounds
        tickShapeLayer.fillColor = UIColor.clear.cgColor
        tickShapeLayer.lineWidth = 3
        tickShapeLayer.strokeColor = color.cgColor
        self.layer.addSublayer(tickShapeLayer)
        
        let W = self.bounds.width
        let H = self.bounds.height
        let tickPath = UIBezierPath()
        tickPath.move(to: CGPoint(x:W/8,y:H/2))
        tickPath.addLine(to: CGPoint(x: W/2.5, y:(H/2)+H/4))
        tickPath.addLine(to: CGPoint(x: W-(W/6),y:H/4))
        tickShapeLayer.path = tickPath.cgPath
        
        let tickAni = basicAnimation(keypath: "strokeEnd", fromValue: 0, toValue: 1, repeatCount: 1, beginTime: 0.8, duration: 2.5, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
        let emtyAnima = CABasicAnimation()
        emtyAnima.duration = 0.8
        
        let group = CAAnimationGroup()
        group.animations = [emtyAnima,tickAni]
        group.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        group.repeatCount = 1
        group.duration = 3.2
        tickShapeLayer.add(group, forKey: nil)
        
        
    }
    
    func successTickWithFullColor(color:UIColor) {
        
        shapeLayer.lineCap = kCALineCapRound;
        let path = UIBezierPath(ovalIn: self.bounds)
        shapeLayer.path = path.cgPath;
        
        let strokeEndAnimaiton = basicAnimation(keypath: "strokeEnd", fromValue: 0, toValue: 1, repeatCount: 1, beginTime: 0, duration: 0.8, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
        shapeLayer.add(strokeEndAnimaiton, forKey: "successTick")
        
        let rotationAni = rotationAnimationFromValue(fromValue: 0, toValue: 2.0*M_PI, repearCount: 1, duration: 0.8)
        shapeLayer.add(rotationAni, forKey: nil)
        
    }
    
    func failCross(color:UIColor){
        
        shapeLayer.lineCap = kCALineCapRound;
        let path = UIBezierPath(ovalIn: self.bounds)
        shapeLayer.path = path.cgPath;
        
        let strokeAnimation = basicAnimation(keypath: "strokeEnd", fromValue: 0, toValue: 1, repeatCount: 1, beginTime: 0, duration: 0.8, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
        shapeLayer.add(strokeAnimation, forKey: nil)
        
        let rotationAnimation = rotationAnimationFromValue(fromValue: 0, toValue: 2.0*M_PI, repearCount: 1, duration: 0.8)
        shapeLayer.add(rotationAnimation, forKey: nil)
        
        let crossShapeLayer = CAShapeLayer()
        crossShapeLayer.frame = self.bounds
        crossShapeLayer.fillColor = UIColor.clear.cgColor
        crossShapeLayer.lineWidth = 3
        crossShapeLayer.strokeColor = color.cgColor
        self.layer.addSublayer(crossShapeLayer)
        
        let W = self.bounds.width
        let H = self.bounds.height
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x:W/5,y:H/5))
        crossPath.addLine(to: CGPoint(x: 4*W/5, y:4*H/5))
        
        let crossPath2 = UIBezierPath()
        crossPath2.move(to: CGPoint(x:4*W/5,y:H/5))
        crossPath2.addLine(to: CGPoint(x: W/5, y:4*H/5))
        crossPath.append(crossPath2)
        crossShapeLayer.path = crossPath.cgPath
        
        let crossAni = basicAnimation(keypath: "strokeEnd", fromValue: 0, toValue: 1, repeatCount: 1, beginTime: 0, duration: 2.0, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
        crossShapeLayer.add(crossAni, forKey: nil)
        
        let emtyAni = CABasicAnimation()
        emtyAni.duration = 0.8
        
        let group = CAAnimationGroup()
        group.animations = [emtyAni,crossAni]
        group.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        group.repeatCount = 1
        group.duration = 3.2
        crossShapeLayer.add(group, forKey: nil)

    }
    
    
    func failCrossWithFullColor(color:UIColor){
    
        shapeLayer.lineCap = kCALineCapRound
        let path = UIBezierPath(ovalIn: self.bounds)
        shapeLayer.path = path.cgPath
        
        let strokeEndAnima = basicAnimation(keypath: "strokeEnd", fromValue: 0, toValue: 1, repeatCount: 1, beginTime: 0, duration: 0.8, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
        
        shapeLayer.add(strokeEndAnima, forKey: "failCross")
        
        let rotationAnimation = rotationAnimationFromValue(fromValue: 0, toValue: 2.0*M_PI, repearCount: 1, duration: 0.8)
        shapeLayer.add(rotationAnimation, forKey: nil)
        
    }
    
    func arcCircle(percentAngle:Float){
        let path = UIBezierPath(arcCenter: CGPoint(x:self.bounds.width/2,y:self.bounds.height/2), radius:self.bounds.width/2, startAngle: 0, endAngle:CGFloat(percentAngle*Float(M_PI)) , clockwise: true)
        shapeLayer.path = path.cgPath
        let ani = rotationAnimationFromValue(fromValue:0.0, toValue:2.0*M_PI, repearCount: MAXFLOAT, duration: 3)
        shapeLayer.add(ani, forKey: nil)
        
        
    }
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if anim.isEqual(shapeLayer.animation(forKey: "successTick")) {
            shapeLayer.fillColor = shapeLayer.strokeColor
            
            let whiteLayer = CAShapeLayer()
            whiteLayer.frame = self.bounds
            whiteLayer.fillColor = UIColor.white.cgColor
            whiteLayer.lineWidth = 3
            whiteLayer.strokeColor = shapeLayer.strokeColor
            self.layer.addSublayer(whiteLayer)
            
            let path = UIBezierPath(ovalIn: self.bounds)
            whiteLayer.path = path.cgPath
            
            let scaleAni = basicAnimation(keypath: "transform.scale", fromValue: 1.0, toValue: 0.0, repeatCount: 1, beginTime: 0, duration: 1, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
            scaleAni.setValue("successTickAnimation", forKey: "animationKey")
            whiteLayer.add(scaleAni, forKey: nil)
            
        }else if anim.value(forKey: "animationKey") as? String == "successTickAnimation"{
            
            let tickshapeLayer = CAShapeLayer()
            tickshapeLayer.frame = self.bounds;
            tickshapeLayer.fillColor = UIColor.clear.cgColor;
            tickshapeLayer.lineWidth = 3;
            tickshapeLayer.strokeColor = UIColor.white.cgColor;
            self.layer.addSublayer(tickshapeLayer)
            
            let W = self.bounds.width
            let H = self.bounds.height
            let tickPath = UIBezierPath()
            tickPath.move(to: CGPoint(x:W/8,y:H/2))
            tickPath.addLine(to: CGPoint(x: W/2.5, y:(H/2)+H/4))
            tickPath.addLine(to: CGPoint(x: W-(W/6),y:H/4))
            tickshapeLayer.path = tickPath.cgPath
            
            let tickAni = basicAnimation(keypath: "strokeEnd", fromValue: 0, toValue: 1, repeatCount: 1, beginTime: 0, duration: 2.0, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
            tickshapeLayer.add(tickAni, forKey: nil)
            
        }else if anim.isEqual(shapeLayer.animation(forKey: "failCross")){
            shapeLayer.fillColor = shapeLayer.strokeColor
            
            let whiteLayer = CAShapeLayer()
            whiteLayer.frame = self.bounds
            whiteLayer.fillColor = UIColor.white.cgColor
            whiteLayer.lineWidth = 3
            whiteLayer.strokeColor = shapeLayer.strokeColor
            self.layer.addSublayer(whiteLayer)
            
            let path = UIBezierPath(ovalIn: self.bounds)
            whiteLayer.path = path.cgPath
            
            let scaleAni = basicAnimation(keypath: "transform.scale", fromValue: 1.0, toValue: 0.0, repeatCount: 1, beginTime: 0, duration: 1, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
            scaleAni.setValue("failCrossScaleAnimation", forKey: "animationKey")
            whiteLayer.add(scaleAni, forKey: nil)
            
        }else if anim.value(forKey: "animationKey") as? String == "failCrossScaleAnimation"{
            
            let crossShapeLayer = CAShapeLayer()
            crossShapeLayer.frame = self.bounds;
            crossShapeLayer.fillColor = UIColor.clear.cgColor;
            crossShapeLayer.lineWidth = 3;
            crossShapeLayer.strokeColor = UIColor.white.cgColor;
            self.layer.addSublayer(crossShapeLayer)
            
            let W = self.bounds.width
            let H = self.bounds.height
            let crossPath = UIBezierPath()
            crossPath.move(to: CGPoint(x:W/5,y:H/5))
            crossPath.addLine(to: CGPoint(x: 4*W/5, y:4*H/5))
            
            let crossPath2 = UIBezierPath()
            crossPath2.move(to: CGPoint(x:4*W/5,y:H/5))
            crossPath2.addLine(to: CGPoint(x: W/5, y:4*H/5))
            crossPath.append(crossPath2)
            crossShapeLayer.path = crossPath.cgPath
            
            let crossAni = basicAnimation(keypath: "strokeEnd", fromValue: 0, toValue: 1, repeatCount: 1, beginTime: 0, duration: 2.0, timingFunction: CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut), removedOnCompletion: false, fillMode: kCAFillModeBoth)
            crossShapeLayer.add(crossAni, forKey: nil)
            
            
        }
    }
    
    func basicAnimation(keypath:String,fromValue:Any,toValue:Any,repeatCount:Float,beginTime:CFTimeInterval,duration:CFTimeInterval,timingFunction:CAMediaTimingFunction,removedOnCompletion:Bool,fillMode:String) -> CABasicAnimation {
        
        let animation = CABasicAnimation(keyPath: keypath)
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.repeatCount = repeatCount
        animation.beginTime = beginTime
        animation.duration = duration
        animation.timingFunction = timingFunction
        animation.isRemovedOnCompletion = removedOnCompletion
        animation.fillMode = fillMode
        animation.delegate = self
        
        return animation
        
    }
    
    func rotationAnimationFromValue(fromValue:Any,toValue:Any,repearCount:Float,duration:CFTimeInterval) -> CABasicAnimation {
        let rotationAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotationAnimation.fromValue = fromValue
        rotationAnimation.toValue = toValue
        rotationAnimation.repeatCount = repearCount
        rotationAnimation.duration = duration
        
        return rotationAnimation
        
    }
    
    
}



