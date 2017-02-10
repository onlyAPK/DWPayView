//
//  DWManageData.m
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWManageData.h"

@implementation DWManageData
-(void)payOrderWithPassword:(NSString*)passWord{
//    NSDictionary* dict = @{@"1":@"2"};
//    
//    if ([_delegate respondsToSelector:@selector(passData:)]) {
//        
//        [_delegate passData:dict];
//        
//    }
    _testPassword = passWord;
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0f];
}

-(void)delayMethod{
    NSDictionary* dict = [[NSDictionary alloc]init];
    if ([_testPassword isEqualToString:@"111111"]) {
        dict  = @{@"result":@"success"};
    }else  {
        dict = @{@"result":@"fail"};
    }
   
    
    if ([_delegate respondsToSelector:@selector(passData:)]) {
        
        [_delegate passData:dict];
        
    }
}

-(void)getBankList{
    
    NSArray* banklistArray = @[@{@"merSignNo":@"MR211111111148",@"userPhone":@"135***5506",@"bankName":@"平安银行",@"bankCard":@"621626*********0018",@"userName":@"*达"},@{@"merSignNo":@"MR21222211148",@"userPhone":@"135***1106",@"bankName":@"农业银行",@"bankCard":@"622841*********0018",@"userName":@"*五"},@{@"merSignNo":@"MR213331111148",@"userPhone":@"134***5306",@"bankName":@"中国银行",@"bankCard":@"988430*********0018",@"userName":@"*四"},@{@"merSignNo":@"MR211444411148",@"userPhone":@"133***5566",@"bankName":@"建设银行",@"bankCard":@"955880*********0018",@"userName":@"*三"},@{@"merSignNo":@"MR212131123148",@"userPhone":@"186***5576",@"bankName":@"工商银行",@"bankCard":@"633412*********0018",@"userName":@"*呵哒"}];//模拟数据
    
    
    //完成网络请求后，使用代理传参
    if ([_delegate respondsToSelector:@selector(passData:)]) {
        
        [_delegate passData:banklistArray];
        
    }
    

}

//获取默认支付方式
-(void)getInitPayMethod{

    NSDictionary* dict =  @{@"merSignNo":@"MR211111111148",@"userPhone":@"135***5506",@"bankName":@"平安银行",@"bankCard":@"621626*********0018",@"userName":@"*达"};//模拟数据
    
    //完成网络请求后，使用代理传参
    if ([_delegate respondsToSelector:@selector(passData:)]) {
        
        [_delegate passData:dict];
        
    }
    
}
@end
    
