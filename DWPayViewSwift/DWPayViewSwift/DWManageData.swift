//
//  DWManageData.swift
//  DWPayViewSwift
//
//  Created by DA WENG on 2017/2/27.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

import UIKit
protocol DWManageDataDelegate {
    func passData(data:Any)
}

class DWManageData: NSObject {
    var delegate: DWManageDataDelegate?
    
    
    func getInitPayMethod() {
        
        //模拟数据
        let dict:NSDictionary =  ["merSignNo":"MR211111111148","userPhone":"135***5506","bankName":"平安银行","bankCard":"621626*********0018","userName":"*达"]
        
        //完成网络请求后，使用代理传参，在DWPayView中回调,可去类里修改相关数据排序
        self.delegate?.passData(data: dict)
    }
    
    
    func getBankList() {
        //模拟数据
        let banklistArray:NSArray = [["merSignNo":"MR211111111148","userPhone":"135***5506","bankName":"平安银行","bankCard":"621626*********0099","userName":"*达"],["merSignNo":"MR21222211148","userPhone":"135***1106","bankName":"农业银行","bankCard":"622841*********0011","userName":"*五"],["merSignNo":"MR213331111148","userPhone":"134***5306","bankName":"中国银行","bankCard":"988430*********0228","userName":"*四"],["merSignNo":"MR211444411148","userPhone":"133***5566","bankName":"建设银行","bankCard":"955880*********0334","userName":"*三"],["merSignNo":"MR212131123148","userPhone":"186***5576","bankName":"工商银行","bankCard":"633412*********0136","userName":"*呵哒"]];
        
        //完成网络请求后，使用代理传参，在DWBankListView.m中回调，可去类里修改相关数据排序
        self.delegate?.passData(data: banklistArray)
    }
    
    func payOrder(withPassword password:String, bankCardInfo:NSDictionary) {
        
        
        //模拟数据
        var dict = NSDictionary()
        dict = password == "111111" ? ["result":"success"] : ["result":"fail"]
        
        /*完成网络请求后，使用代理传参,在DWEnterPasswordView.m中回调，
         只需要传一个字典表示结果:
         NSDictionary* dict  = @{@"result":@"success"};
         或者NSDictionary* dict = @{@"result":@"fail"};
         界面会自己判断动画
         */
        self.delegate?.passData(data: dict)

    }
    
}
