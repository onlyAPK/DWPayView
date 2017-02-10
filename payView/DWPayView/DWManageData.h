//
//  DWManageData.h
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ManageDataDelegate <NSObject>

-(void)passData:(id)data;

@end
@interface DWManageData : NSObject
@property(nonatomic,weak)id<ManageDataDelegate>delegate;
-(void)getInitPayMethod;
-(void)getBankList;
-(void)payOrderWithPassword:(NSString*)passWord withBankCardInfo:(NSDictionary*)bankCardInfo;

@end
