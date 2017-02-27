//
//  ViewController.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/15.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit

var gagag = DWPayView()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    gagag = DWPayView(orderFee: "200", whomToPay: "hello")
  
        let btn = UIButton(frame: CGRect(x: 60, y: 60, width: 60, height: 60))
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action: #selector(showww), for: UIControlEvents.touchUpInside)
        self.view .addSubview(btn)
        
        let lallal = DWSateView(frame: CGRect(x: 60, y: 160, width: 100, height: 100), color: UIColor.init(red: 53.0/255.0, green: 203.0/255.0, blue: 75.0/255.0, alpha: 1), type: DWStateDisplayType.successTickWithFullCoolor)
        self.view.addSubview(lallal)
        
    }

   
    
    func showww(){
        gagag.showInView(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

