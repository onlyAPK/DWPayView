//
//  DWPayView.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/20.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit

class DWPayView: UIView ,UITableViewDelegate,UITableViewDataSource,DWManageDataDelegate{
    
    var payMethodDict = NSDictionary()
    let titleArray = ["支付方式","持卡人"]
    var scrollView = UIScrollView()
    var secondTitle = UILabel()
    var payMethodTableView = UITableView()
    var backBtn = UIButton()
    var enterPasswordView = DWEnterPasswordView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(orderFee:String,whomToPay:String) {
        
        self.init()

        initContent(orderFee: orderFee, whomToPay: whomToPay)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initContent(orderFee:String,whomToPay:String) {
        self.frame = CGRect(x: 0, y: 0, width: dwDEVICESCREENWIDTH, height: dwDEVICESCREENHEIGHT)
        self.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.2)
        
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: dwDEVICESCREENHEIGHT-dwSCROLLVIEWHEIGHT, width: dwDEVICESCREENWIDTH, height: dwSCROLLVIEWHEIGHT))
        scrollView.contentSize = CGSize(width: dwDEVICESCREENWIDTH*2, height: dwSCROLLVIEWHEIGHT)
        scrollView.backgroundColor = UIColor.white
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        self.addSubview(scrollView)
        
        let firstTitleView = UIView(frame: CGRect(x: 0, y: 0, width: dwDEVICESCREENWIDTH, height: dwBUTTONWIDTH))
        let firstTitle = UILabel(frame: CGRect(x: 0, y: 0, width: firstTitleView.frame.size.width, height:  firstTitleView.frame.size.height))
        firstTitle.text = "安全支付"
        firstTitle.textAlignment = NSTextAlignment.center
        firstTitleView .addSubview(firstTitle)
        scrollView.addSubview(firstTitleView)
        
        let secondTitleView = UIView(frame: CGRect(x: dwDEVICESCREENWIDTH, y: 0, width: dwDEVICESCREENWIDTH, height: dwBUTTONWIDTH))
        secondTitle = UILabel(frame: CGRect(x: 0, y: 0, width: secondTitleView.frame.size.width, height: secondTitleView.frame.size.height))
        secondTitle.textAlignment = NSTextAlignment.center
        secondTitleView.addSubview(secondTitle)
        scrollView.addSubview(secondTitleView)
        
        let closeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: dwBUTTONWIDTH, height: dwBUTTONWIDTH))
        let crossView = DWCrossView(frame: closeBtn.frame)
        scrollView.addSubview(crossView)
        let crossImage = DWViewConvertToImage.getImageFromView(view: crossView)
        closeBtn.setImage(crossImage, for: UIControlState.normal)
        closeBtn.backgroundColor = UIColor.red
        closeBtn.addTarget(self, action:#selector(DWPayView.disMissView) , for:UIControlEvents.touchUpInside)
        scrollView.addSubview(closeBtn)
        
        let nextBtn = UIButton(frame: CGRect(x: dwMARGINTOLEFT, y: scrollView.frame.size.height-dwBUTTONWIDTH*1.1-dwMARGINTOLEFT*1.5, width: dwDEVICESCREENWIDTH-dwMARGINTOLEFT*2, height: dwBUTTONWIDTH*1.1))
        nextBtn.layer.masksToBounds = false
        nextBtn.layer.cornerRadius = 5
        nextBtn.backgroundColor = UIColor.init(red: 71.0/255.0, green: 37.0/255.0, blue: 116.0/255.0, alpha: 1)
        nextBtn.setTitle("确认付款", for: UIControlState.normal)
        nextBtn.addTarget(self, action: #selector(nextClick), for: UIControlEvents.touchUpInside)
        scrollView.addSubview(nextBtn)
        
        backBtn = UIButton(frame: CGRect(x: dwDEVICESCREENWIDTH, y: 0, width: dwBUTTONWIDTH, height: dwBUTTONWIDTH))
        let arrowView = DWArrowView(frame: backBtn.frame)
        scrollView.addSubview(arrowView)
        let arrowimage = DWViewConvertToImage.getImageFromView(view: arrowView)
        backBtn.setImage(arrowimage, for: UIControlState.normal)
        backBtn.addTarget(self, action: #selector(backClick), for: UIControlEvents.touchUpInside)
        scrollView.addSubview(backBtn)
        
        let lineLabel = UILabel(frame: CGRect(x: 0, y: closeBtn.frame.size.height, width: dwDEVICESCREENWIDTH, height: 0.2))
        lineLabel.backgroundColor = UIColor.lightGray
        scrollView.addSubview(lineLabel)
        
        let payToWhomLabel = UILabel(frame: CGRect(x: 0, y: closeBtn.frame.size.height*2, width: dwDEVICESCREENWIDTH, height: closeBtn.frame.size.height/2))
        payToWhomLabel.text = "向\(whomToPay)支付"
        payToWhomLabel.textAlignment = NSTextAlignment.center
        scrollView.addSubview(payToWhomLabel)
        
        
        let moneyLabel = UILabel(frame: CGRect(x: 0, y: payToWhomLabel.frame.origin.y+payToWhomLabel.frame.size.height, width: dwDEVICESCREENWIDTH, height: payToWhomLabel.frame.size.height*2.3))
        moneyLabel.text = orderFee
        moneyLabel.font = UIFont.systemFont(ofSize: 36)
        moneyLabel.textAlignment = NSTextAlignment.center
        scrollView.addSubview(moneyLabel)
        
        
        payMethodTableView = UITableView(frame: CGRect(x: 0, y: moneyLabel.frame.origin.y+moneyLabel.frame.size.height+payToWhomLabel.frame.size.height, width: dwDEVICESCREENWIDTH, height: dwBUTTONWIDTH*2))
        payMethodTableView.rowHeight = dwBUTTONWIDTH
        payMethodTableView.dataSource = self
        payMethodTableView.delegate = self
        payMethodTableView.bounces = false
        scrollView.addSubview(payMethodTableView)
        
        
        let lineLabel2 = UILabel(frame: CGRect(x: 15, y: payMethodTableView.frame.origin.y, width: dwDEVICESCREENWIDTH, height: 0.2))
        lineLabel2.backgroundColor = UIColor.lightGray
        scrollView.addSubview(lineLabel2)
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellIdentifier")
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.textLabel?.text = titleArray[indexPath.row]
        
        if indexPath.row == 0 {
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.detailTextLabel?.text = payMethodDict.object(forKey: "bankCard") as! String?
        }else if indexPath.row == 1 {
            
            cell.detailTextLabel?.text = payMethodDict.object(forKey: "userName") as! String?
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.bankListClick()
        }
    }
    
    func disMissView() {
        
        
        scrollView.frame = CGRect(x: 0, y: dwDEVICESCREENHEIGHT - dwSCROLLVIEWHEIGHT, width: dwDEVICESCREENWIDTH, height: dwSCROLLVIEWHEIGHT)
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
            self.scrollView.frame = CGRect(x: 0, y: dwDEVICESCREENHEIGHT, width: dwDEVICESCREENWIDTH, height: dwSCROLLVIEWHEIGHT)
        }) { (finished) in
            self.scrollView.setContentOffset(CGPoint(x:0,y:0), animated: false)
            self.removeFromSuperview()
            self.scrollView.removeFromSuperview()
            
            
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "finishPay"), object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "disableBackBtn"), object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "bankCardSelected"), object: nil)
        }
        
        
    }
    
    func nextClick() {
        var dict = NSDictionary()
        dict = payMethodDict
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "bankInfoForPay"), object: nil, userInfo: dict as? [AnyHashable : Any] )//将银行卡信息传到DWManageData中，方便最后提交交易使用
        
        let offsetX = scrollView.bounds.size.width
        scrollView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
        secondTitle.text = "输入数字支付密码"
        
        enterPasswordView = DWEnterPasswordView(frame: CGRect(x: dwDEVICESCREENWIDTH, y: dwBUTTONWIDTH, width: dwDEVICESCREENWIDTH, height: dwSCROLLVIEWHEIGHT))
        enterPasswordView.payBankInfo = payMethodDict
        scrollView.addSubview(enterPasswordView)
        
    }
    
    func backClick() {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        
        enterPasswordView.textField.resignFirstResponder()
        
    }
    
    //输入完密码后禁用返回键
    func disableBackBtn(){
        
        backBtn.isEnabled = false
        backBtn.adjustsImageWhenDisabled = false
        
    }
    
    
    /*
     回传选号的银行卡信息
     可将服务器报文直接转成字典传过来，也可以重新生成字典来传、
     记得修改-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath中的payMethodDict字典key值，以便正确显示银行卡和姓名
     */
    func bankCardSelected(notification:Notification){
        
        self.backClick()
        let userInfo = notification.userInfo
        
        
        let dict = userInfo as? Dictionary<String,String>
        payMethodDict = NSMutableDictionary(dictionary: dict!)
        payMethodTableView.reloadData()
        
    }
    
    func bankListClick(){
        
        let offsetX = scrollView.bounds.size.width
        scrollView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
        secondTitle.text = "选择支付方式"
        
        let bankListView = DWBankListView(frame: CGRect(x: dwDEVICESCREENWIDTH, y: dwBUTTONWIDTH, width: dwDEVICESCREENWIDTH, height: dwSCROLLVIEWHEIGHT))
        scrollView.addSubview(bankListView)
        
    }
    
    
    
    func showInView(view:UIView) {
        
        view.addSubview(self)
        view.addSubview(scrollView)
        
        scrollView.frame = CGRect(x: 0, y: dwDEVICESCREENHEIGHT, width: dwDEVICESCREENWIDTH, height: dwSCROLLVIEWHEIGHT)
        
        UIView.animate(withDuration: 0.3) {
            
            self.alpha = 1.0
            self.backBtn.isEnabled = true;
            self.scrollView.frame = CGRect(x: 0, y: dwDEVICESCREENHEIGHT - dwSCROLLVIEWHEIGHT, width: dwDEVICESCREENWIDTH, height: dwSCROLLVIEWHEIGHT)
            self.getInitPayBankInfo()
            
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.disMissView), name: NSNotification.Name(rawValue: "finishPay"), object: nil)//完成交易后，页面消失观察者
            NotificationCenter.default.addObserver(self, selector: #selector(self.disableBackBtn), name: NSNotification.Name(rawValue: "disableBackBtn"), object: nil)//输入密码，使返回按钮失效观察者
            NotificationCenter.default.addObserver(self, selector: #selector(self.bankCardSelected), name: NSNotification.Name(rawValue: "bankCardSelected"), object: nil)//选择完银行卡，返回传值观察者
            
            
        }
        
    }
    
    func getInitPayBankInfo() {
        let manageData = DWManageData()
        manageData.delegate = self
        manageData.getInitPayMethod()
    }
    
    /*
     代理传值获取到的默认银行卡信息
     可根据服务器返回信息自行修改
     记得修改-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath中的payMethodDict字典key值，以便正确显示银行卡和姓名
     */
    func passData(data: Any) {
        
        payMethodDict = data as! NSDictionary
        
        payMethodTableView.reloadData()
    }
    
    
}
