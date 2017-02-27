//
//  DWBankListView.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/24.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit
var banklistArray = NSArray()
let banklistTableView = UITableView()
class DWBankListView: UIView ,UITableViewDataSource,UITableViewDelegate,DWManageDataDelegate{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initContent(){
        
        let lineLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0.2))
        lineLabel.backgroundColor = UIColor.lightGray
        self.addSubview(lineLabel)
        
        let banklistTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        banklistTableView.rowHeight = dwBUTTONWIDTH*1.5
        banklistTableView.dataSource = self
        banklistTableView.delegate = self
        self.addSubview(banklistTableView)
        
        let manageData = DWManageData()
        manageData.delegate = self
        manageData.getBankList()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banklistArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cellIdentifier")
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.textLabel?.text = (banklistArray.object(at: indexPath.row) as! NSDictionary).object(forKey:"bankCard") as? String
        cell.detailTextLabel?.text = (banklistArray.object(at: indexPath.row) as! NSDictionary).object(forKey:"userName") as? String
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let bankCardStr = (banklistArray.object(at: indexPath.row) as! NSDictionary).object(forKey:"bankCard") as? String
        let name = (banklistArray.object(at: indexPath.row) as! NSDictionary).object(forKey:"userName") as? String
        let bankcardDict = NSMutableDictionary()
        bankcardDict.setValue(bankCardStr, forKey: "bankCard")
        bankcardDict.setValue(name, forKey: "userName")
        let dict:NSDictionary = bankcardDict
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "bankCardSelected"), object: nil, userInfo: dict as? [AnyHashable : Any])
        self.removeFromSuperview()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "bankCardSelected"), object: nil)
    }
    
    func passData(data: Any) {
        banklistArray = data as! NSArray
        banklistTableView.reloadData()
    }
}
