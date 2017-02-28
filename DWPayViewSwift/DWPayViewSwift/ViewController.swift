//
//  ViewController.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/15.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
var gagag = DWPayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    gagag = DWPayView(orderFee: "200", whomToPay: "hello")
  
        let btn = UIButton(frame: CGRect(x: 60, y: 60, width: 60, height: 60))
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(showww), for: UIControlEvents.touchUpInside)
        self.view .addSubview(btn)
        
    }

   
    
    func showww(){
        gagag.showInView(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

