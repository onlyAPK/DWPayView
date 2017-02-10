//
//  DWViewConvertToImage.m
//  payView
//
//  Created by DA WENG on 2017/2/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWViewConvertToImage.h"

@implementation DWViewConvertToImage
-(instancetype)initWithView:(UIView*)view{
    
    self=[super init];
    
    if (self) {
        [self getImageFromView:view];
        
    }
    
    return self;
    
}


- (UIImage *)getImageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
