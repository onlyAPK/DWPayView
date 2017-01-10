//
//  ViewController.m
//  payView
//
//  Created by DA WENG on 16/10/21.
//  Copyright © 2016年 DA WENG. All rights reserved.
//

#import "ViewController.h"

#import "SuccessView.h"
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

    payView = [[DWPayView alloc]init];

    [payView showInView:self.view];
    
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 60, 60, 60)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
//    UIView* backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 300)];
//    backgroundView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:backgroundView];
//    
//    NSString* ccc = @"0x1f9999";
//    UIColor *color = [self colorWithHexString:ccc alpha:1];
//    self.view.backgroundColor = color;
//    
//    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, backgroundView.frame.size.width, backgroundView.frame.size.height)];
//    scrollView.backgroundColor = [UIColor redColor];
//    scrollView.contentSize = CGSizeMake(backgroundView.frame.size.width*2, backgroundView.frame.size.height);
//    [backgroundView addSubview:scrollView];
//    [scrollView setBounces:NO];
//    [scrollView setShowsHorizontalScrollIndicator:NO];
//    [scrollView setShowsVerticalScrollIndicator:NO];
//    scrollView.scrollEnabled = NO;
//    
//    UIButton* closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    closeBtn.backgroundColor = [UIColor blueColor];
//    [scrollView addSubview:closeBtn];
//    
//    
//    
//    UIButton* nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, scrollView.frame.size.height-100, scrollView.frame.size.width-100, 50)];
//    nextBtn.backgroundColor = [UIColor blueColor];
//    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:nextBtn];
//    
//    
//    UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, 50, 50)];
//    backBtn.backgroundColor = [UIColor blueColor];
//    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    [scrollView addSubview:backBtn];
//    
//    NSArray* testarry = @[@"1",@"2"];
//    BankListTableView* listTableView = [[BankListTableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 300)];
//    listTableView.backgroundColor = [UIColor yellowColor];
//    listTableView.dataArray = testarry;
//    [self.view addSubview:listTableView];
}

-(void)show{

  [payView showInView:self.view];
}

- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}


//-(void)nextClick{
//    
//    
//    CGFloat offsetX = scrollView.bounds.size.width;
//    
//    [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
//    
//    
//}
//
//-(void)backClick{
//    
//    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
