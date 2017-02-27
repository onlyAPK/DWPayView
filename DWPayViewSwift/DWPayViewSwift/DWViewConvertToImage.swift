//
//  DWViewConvertToImage.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/20.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit

class DWViewConvertToImage: UIImage {

//    override init() {
//        super.init()
//
//        
//    }
//    
//    convenience init(view:UIView) {
//        
//        self.init(getImageFromView(view: view))
//        
//    }
//    
//    required convenience init(imageLiteralResourceName name: String) {
//        fatalError("init(imageLiteralResourceName:) has not been implemented")
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }



class func getImageFromView(view:UIView) -> UIImage! {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale);
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image;
    }
    
}
