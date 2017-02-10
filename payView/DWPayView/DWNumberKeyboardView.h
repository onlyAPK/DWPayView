//
//  DWNumberKeyboardView.h
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SafeKeyBoardDelegate <NSObject>

-(void)inputtext:(NSString*)inputtext;

@end
@interface DWNumberKeyboardView : UIView
@property(nonatomic,weak)id<SafeKeyBoardDelegate>delegate;
@end
