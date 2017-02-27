//
//  DWEnterPasswordView.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/24.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit

let DOTSIZE = CGSize(width:10, height:10) //密码点的大小
let DOTCOUNT = 6  //密码个数
let FIELDHEIGHT = 45  //每一个输入框的高度

class DWEnterPasswordView: UIView ,DWNumberKeyBoardDelegate,DWManageDataDelegate{
    var loadingView = DWSateView()
    var stateLabel = UILabel()
    var dotArray = NSMutableArray()
    let numberKeyboard = DWNumberKeyboardView()
    let passWordView = UIView()
    var payBankInfo = NSDictionary()
    
    override init(frame:CGRect){
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.numberKeyboard.delegate = self
        textField.inputView = self.numberKeyboard
        textField .becomeFirstResponder()
        self.addSubview(textField)
        self.initPwdTextField()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func passData(data: Any) {
        
        var dict = NSDictionary()
        dict = data as! NSDictionary
        loadingView.removeFromSuperview()
        let result = dict.object(forKey: "result") as! String
        if result == "success" {
            let tickState = DWSateView(frame: CGRect(x: self.frame.size.width*3/8, y: self.frame.size.width/4, width: self.frame.size.width/4, height: self.frame.size.width/4), color: UIColor.init(red: 53.0/255.0, green: 203.0/255.0, blue: 75.0/255.0, alpha: 1), type: DWStateDisplayType.successTickWithFullCoolor)
            self.addSubview(tickState)
            stateLabel.text = "支付成功"
            self.perform(#selector(successDelayMethod), with: nil, afterDelay: 2.8)
        }else if result == "fail"{
        
            let crossState = DWSateView(frame: CGRect(x: self.frame.size.width*3/8, y: self.frame.size.width/4, width: self.frame.size.width/4, height: self.frame.size.width/4), color: UIColor.init(red: 252.0/255.0, green: 99.0/255.0, blue: 94.0/255.0, alpha: 1), type: DWStateDisplayType.failCrossWithFullCoolor)
            self.addSubview(crossState)
            stateLabel.text = "支付失败"
            self.perform(#selector(failDelayMethod), with: nil, afterDelay: 2.8)
            
        }

    }
    
    func successDelayMethod(){
    self.perform(#selector(postNotification), with: nil, afterDelay: 1.5)
    
    }
    
    func failDelayMethod(){
    
        self.perform(#selector(postNotification), with: nil, afterDelay: 1.5)
    }
    
    func postNotification(){

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "finishPay"), object: nil)
    }
    
    let textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: dwMARGINTOLEFT, y: dwMARGINTOLEFT, width: dwDEVICESCREENWIDTH - dwMARGINTOLEFT*2, height: CGFloat(FIELDHEIGHT)))
        textField.backgroundColor = UIColor.white
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.addTarget(self, action: #selector(inputText), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    
    func inputText(inputText: String) {
        
        
        for dotView in self.dotArray {
            (dotView as! UIView).isHidden = true
        }
        for i in 0..<inputText.characters.count {
            (self.dotArray.object(at: i) as! UIView).isHidden = false
        }
        if inputText.characters.count == DOTCOUNT {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableBackBtn"), object: nil)
            self.numberKeyboard.removeFromSuperview()
            self.textField.removeFromSuperview()
            self.passWordView.removeFromSuperview()
            
            loadingView = DWSateView(frame: CGRect(x: self.frame.size.width*3/8, y: self.frame.size.width/4, width: self.frame.size.width/4, height: self.frame.size.width/4), color: UIColor.init(red: 53.0/255.0, green: 203.0/255.0, blue: 75.0/255.0, alpha: 1), type: DWStateDisplayType.drawCircle)
            self.addSubview(loadingView)
            
            self.stateLabel = UILabel(frame: CGRect(x: self.frame.size.width*3/8, y: self.frame.size.width/4+self.frame.size.width/4+10, width: self.frame.size.width/4, height: self.frame.size.width/16))
            stateLabel.text = "正在支付"
            stateLabel.textAlignment = NSTextAlignment.center
            self.addSubview(stateLabel)
        
            let manageData = DWManageData()
            manageData.delegate = self
            manageData.payOrder(withPassword: inputText, bankCardInfo: self.payBankInfo)
   
        }
    }
    
    func initPwdTextField(){
        
        let width:CGFloat = (dwDEVICESCREENWIDTH - dwMARGINTOLEFT*2)/CGFloat(DOTCOUNT)
        self.passWordView.frame = self.textField.frame
        self.addSubview(self.passWordView)
        
        for i in 0..<DOTCOUNT-1 {
            let lineView = UIView(frame: CGRect(x: (i + 1) * Int(width), y: 0, width: 1, height: FIELDHEIGHT))
            lineView.backgroundColor = UIColor.gray
            self.passWordView.addSubview(lineView)
        }
        for i in 0...DOTCOUNT {
            let dotView = UIView(frame: CGRect(x: (width - CGFloat(DOTCOUNT)) / 2 + CGFloat(i) * width, y: (CGFloat(FIELDHEIGHT) - DOTSIZE.height) / 2, width: DOTSIZE.width, height:  DOTSIZE.height))
            dotView.backgroundColor = UIColor.black
            dotView.layer.cornerRadius = DOTSIZE.width/2
            dotView.clipsToBounds = true
            dotView.isHidden = true
            self.passWordView.addSubview(dotView)
            self.dotArray.add(dotView)
        }
        
    }

    
    
}
