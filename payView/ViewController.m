//
//  ViewController.m
//  payView
//
//  Created by DA WENG on 16/10/21.
//  Copyright © 2016年 DA WENG. All rights reserved.
//

#import "ViewController.h"
#import "DWPayView.h"
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]
@interface ViewController ()
{
    UIScrollView* scrollView;
    
    NSTimer* timer;
    NSInteger seconds;
    DWPayView* payView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    payView = [[DWPayView alloc]initWithorderFee:@"200" whomToPay:@"大鸡"];
    
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(80,self.view.frame.size.height - 160, self.view.frame.size.width-160, 30)];
    [btn setTitle:@"确认付款" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:91.0/255.0 green:46.0/255.0 blue:123.0/255.0 alpha:1];
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self show];
}

-(void)show{

  [payView showInView:self.view];
}

//- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
//{
//    //删除字符串中的空格
//    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    // String should be 6 or 8 characters
//    if ([cString length] < 6)
//    {
//        return [UIColor clearColor];
//    }
//    // strip 0X if it appears
//    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
//    if ([cString hasPrefix:@"0X"])
//    {
//        cString = [cString substringFromIndex:2];
//    }
//    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
//    if ([cString hasPrefix:@"#"])
//    {
//        cString = [cString substringFromIndex:1];
//    }
//    if ([cString length] != 6)
//    {
//        return [UIColor clearColor];
//    }
//    
//    // Separate into r, g, b substrings
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    //r
//    NSString *rString = [cString substringWithRange:range];
//    //g
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    //b
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    
//    // Scan values
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
