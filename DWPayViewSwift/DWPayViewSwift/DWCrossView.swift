//
//  DWCrossView.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/20.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit
let LINEWIDTH:CGFloat = 1.0
let MAGRIN:CGFloat = 10.0
class DWCrossView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(LINEWIDTH)
        context?.setAllowsAntialiasing(true)
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        context?.beginPath()
        context?.move(to: CGPoint(x: MAGRIN, y: MAGRIN))
        context?.addLine(to: CGPoint(x: self.frame.size.width - MAGRIN, y: self.frame.size.height - MAGRIN))
        context?.strokePath()
        
        
        let context2 = UIGraphicsGetCurrentContext()
        context2?.setLineCap(CGLineCap.round)
        context2?.setLineWidth(LINEWIDTH)
        context2?.setAllowsAntialiasing(true)
        context2?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        context2?.beginPath()
        context2?.move(to: CGPoint(x: self.frame.size.width - MAGRIN, y: MAGRIN))
        context2?.addLine(to: CGPoint(x: MAGRIN, y: self.frame.size.height - MAGRIN))
        context2?.strokePath()
        
    }
    
    
}
