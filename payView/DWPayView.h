//
//  DWPayView.h
//  payView
//
//  Created by DA WENG on 2017/1/9.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWPayView : UIView
- (void)showInView:(UIView *)view;
- (void)disMissView;
-(instancetype)initWithorderFee:(NSString*)orderFee whomToPay:(NSString*)whomToPay;

@end
