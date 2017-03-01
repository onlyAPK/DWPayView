//
//  DWStateView.h
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,DWStateDisplayType){
    DWStateDisplayTypeDrawCircle = 0, //画圆
    DWStateDisplayTypeAndroidLike,    //安卓样式
    DWStateDisplayTypeArcCircle,      //圆弧
    DWStateDisplayTypeSuccessTick,    //白底打钩
    DWStateDisplayTypeSuccessTickWithFullCoolor,//满色打钩
    DWStateDisplayTypeFailCross,     //白底打叉
    DWStateDisplayTypeFailCrossWithFullCoolor,//满色打叉
};

@interface DWStateView : UIView

- (instancetype)initWithFrame:(CGRect)frame withType:(DWStateDisplayType)type withColor:(UIColor*)color;
@end
