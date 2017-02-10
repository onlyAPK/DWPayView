//
//  DWStateView.h
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,DWStateDisplayType){
    DWStateDisplayTypeDrawCircle = 0,
    DWStateDisplayTypeAndroidLike,
    DWStateDisplayTypeArcCircle,
    DWStateDisplayTypeSuccessTick,
    DWStateDisplayTypeFailCross,
};
@interface DWStateView : UIView

- (instancetype)initWithFrame:(CGRect)frame withType:(DWStateDisplayType)type withColor:(UIColor*)color;
@end
