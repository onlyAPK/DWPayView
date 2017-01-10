//
//  DWManageData.h
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ManageDataDelegate <NSObject>

-(void)passDict:(NSDictionary*)dict;
-(void)passArray:(NSArray*)array;
@end
@interface DWManageData : NSObject
@property(nonatomic,weak)id<ManageDataDelegate>delegate;
-(void)payOrder;
-(void)getBankList;
-(void)getInitPayMethod;
@end
