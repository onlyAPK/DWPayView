//
//  DWArrowView.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/21.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit

class DWArrowView: UIView {

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
        context?.move(to: CGPoint(x: MAGRIN+7, y: MAGRIN+3))
        context?.addLine(to: CGPoint(x: MAGRIN, y: self.frame.size.height/2-LINEWIDTH/2))
        context?.addLine(to: CGPoint(x: MAGRIN+7, y: self.frame.size.height-MAGRIN-3))
        context?.strokePath()
        
        
    }


}
