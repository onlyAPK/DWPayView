//
//  DWNumberKeyboardView.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/24.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit

protocol DWNumberKeyBoardDelegate {
    func inputText(inputText:String)
}

class DWNumberKeyboardView: UIView {
    let dwKEYBOADHEIGHT = dwSCROLLVIEWHEIGHT*0.5
    var tempString = NSMutableString()
    var numarray = NSArray()
    var delegate: DWNumberKeyBoardDelegate?
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.initContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numBtnClick(numBtn:UIButton) {
        
        if tempString.length < 6 {
            tempString.append(numBtn.currentTitle!)
            
            self.delegate?.inputText(inputText: tempString as String)
            
        }
    }
    
    func deleteBtnClick() {
        if tempString.length > 0 {
            tempString.deleteCharacters(in: NSRange(location: tempString.length-1, length: 1))
            self.delegate?.inputText(inputText: tempString as String)
        }
    }
    
    func initContent() {
        
        self.backgroundColor = UIColor.groupTableViewBackground
        self.setNumberLayout()
        self.setNumberTitle()
        self.frame = CGRect(x: 0, y: dwSCROLLVIEWHEIGHT/3-dwKEYBOADHEIGHT/5, width: dwDEVICESCREENWIDTH, height: dwKEYBOADHEIGHT+dwKEYBOADHEIGHT/5)
        let keyboardTitleView = UIView(frame: CGRect(x: 0, y: 0, width:dwDEVICESCREENWIDTH , height: dwKEYBOADHEIGHT/5))
        keyboardTitleView.backgroundColor = UIColor.white
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: keyboardTitleView.frame.width, height: keyboardTitleView.frame.height))
        let lineLabel = UILabel(frame: CGRect(x: 0, y: 0, width: dwDEVICESCREENWIDTH, height: 1))
        lineLabel.backgroundColor = UIColor.groupTableViewBackground
        keyboardTitleView.addSubview(lineLabel)
        titleLabel.text = "安全键盘"
        titleLabel.textAlignment = NSTextAlignment.center
        keyboardTitleView.addSubview(titleLabel)
        self.addSubview(keyboardTitleView)
        
        
    }
    
    func setNumberLayout(){
        
        let array = NSMutableArray()
        for i in 0..<4 {
            for j in 0..<3 {
                let x = CGFloat(1)+((dwDEVICESCREENWIDTH-CGFloat(4))/CGFloat(3)+CGFloat(1))*CGFloat(j)
                let y = CGFloat(1)+dwKEYBOADHEIGHT/CGFloat(5)+((dwKEYBOADHEIGHT-CGFloat(5))/CGFloat(4)+CGFloat(1))*CGFloat(i)
                let width = (dwDEVICESCREENWIDTH-CGFloat(4))/CGFloat(3)
                let height = (dwKEYBOADHEIGHT-CGFloat(5))/CGFloat(4)
                let btn = UIButton(frame: CGRect(x: x, y:y , width: width , height:height ))
                btn.backgroundColor = UIColor.white
                btn.setTitleColor(UIColor.black, for: UIControlState.normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
                self.addSubview(btn)
                array.add(btn)
            }
        }
        numarray = array;
    }
    
    func setNumberTitle() {
        
        let arrM = NSMutableArray()
        arrM.removeAllObjects()
        var  i = 0
        while (i<10){
            let j = arc4random_uniform(10)
            let number = NSNumber(value: j)
            if arrM.contains(number) {
                continue
            }
            i += 1
            arrM.add(number)
            
        }
        
        for k in 0..<12 {
            if k < 9 {
                let btn = numarray.object(at: k) as! UIButton
                let number = arrM.object(at: k) as! NSNumber
                let title = number.stringValue
                btn.setTitle(title, for: UIControlState.normal)
                btn.addTarget(self, action: #selector(numBtnClick), for: UIControlEvents.touchUpInside)
            }else if k == 9 {
                
                let btn = numarray.object(at: k+1) as! UIButton
                let number = arrM.object(at: k) as! NSNumber
                let title = number.stringValue
                btn.setTitle(title, for: UIControlState.normal)
                btn.addTarget(self, action: #selector(numBtnClick), for: UIControlEvents.touchUpInside)
                
            }else if k == 10 {
                
                let btn = numarray.object(at: k-1) as! UIButton
                btn.backgroundColor = UIColor.groupTableViewBackground
                
            }else if k == 11 {
                
                let btn = numarray.object(at: k) as! UIButton
                btn.backgroundColor = UIColor.groupTableViewBackground
                btn.setTitle("删除", for: UIControlState.normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                btn.addTarget(self, action: #selector(deleteBtnClick), for: UIControlEvents.touchUpInside)
                
            }
        }
        
    }
    
    
}
