//
//  DWManageData.m
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWManageData.h"
#import <UIKit/UIKit.h>
@implementation DWManageData


//获取默认支付方式
-(void)getInitPayMethod{
    //模拟数据
    NSDictionary* dict =  @{@"merSignNo":@"MR211111111148",@"userPhone":@"135***5506",@"bankName":@"平安银行",@"bankCard":@"621626*********0018",@"userName":@"*达"};
    
    
    
    //完成网络请求后，使用代理传参，在DWPayView.m中回调,可去类里修改相关数据排序
    if ([_delegate respondsToSelector:@selector(passData:)]) {
        
        [_delegate passData:dict];
        
    }
    
}

-(void)getBankList{
    
    //模拟数据
    NSArray* banklistArray = @[@{@"merSignNo":@"MR211111111148",@"userPhone":@"135***5506",@"bankName":@"平安银行",@"bankCard":@"621626*********0018",@"userName":@"*达"},@{@"merSignNo":@"MR21222211148",@"userPhone":@"135***1106",@"bankName":@"农业银行",@"bankCard":@"622841*********0018",@"userName":@"*五"},@{@"merSignNo":@"MR213331111148",@"userPhone":@"134***5306",@"bankName":@"中国银行",@"bankCard":@"988430*********0018",@"userName":@"*四"},@{@"merSignNo":@"MR211444411148",@"userPhone":@"133***5566",@"bankName":@"建设银行",@"bankCard":@"955880*********0018",@"userName":@"*三"},@{@"merSignNo":@"MR212131123148",@"userPhone":@"186***5576",@"bankName":@"工商银行",@"bankCard":@"633412*********0018",@"userName":@"*呵哒"}];
    
    
    //完成网络请求后，使用代理传参，在DWBankListView.m中回调，可去类里修改相关数据排序
    if ([_delegate respondsToSelector:@selector(passData:)]) {
        
        [_delegate passData:banklistArray];
        
    }
    
    
}


//提交交易请求
-(void)payOrderWithPassword:(NSString*)passWord withBankCardInfo:(NSDictionary*)bankCardInfo{
    
    NSLog(@"DWManageData_bankCardInfo:%@",bankCardInfo);
    NSLog(@"%@",passWord);
    
    
    //模拟数据
    NSDictionary* dict = [[NSDictionary alloc]init];
    dict = [passWord isEqualToString:@"111111"]?@{@"result":@"success"}:@{@"result":@"fail"};
    
    /*完成网络请求后，使用代理传参,在DWEnterPasswordView.m中回调，
     只需要传一个字典表示结果:
     NSDictionary* dict  = @{@"result":@"success"};
     或者NSDictionary* dict = @{@"result":@"fail"};
     界面会自己判断动画
     */
    if ([_delegate respondsToSelector:@selector(passData:)]) {
        
        [_delegate passData:dict];
        
    }
}






@end

