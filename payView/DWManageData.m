//
//  DWManageData.m
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWManageData.h"

@implementation DWManageData
-(void)payOrder{
    NSDictionary* dict = @{@"1":@"2"};
    
    if ([_delegate respondsToSelector:@selector(passDict:)]) {
        
        [_delegate passDict:dict];

    }
}


-(void)getBankList{
    
   NSArray* banklistArray = @[@"中国工行银行(9557)",@"中国银行(9517)",@"中国农业银行(9157)",@"中国建设银行(1117)",@"上海招商银行(9957)"];
    
    if ([_delegate respondsToSelector:@selector(passArray:)]) {
        
        [_delegate passArray:banklistArray];
        
    }
    

}

-(void)getInitPayMethod{

    NSDictionary* dict =  @{@"付款方式":@"中国工行银行(9557)",@"持卡人":@"*达"};
    
    if ([_delegate respondsToSelector:@selector(passDict:)]) {
        
        [_delegate passDict:dict];
        
    }
    
}
@end
    
