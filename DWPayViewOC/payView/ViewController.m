//
//  ViewController.m
//  payView
//
//  Created by DA WENG on 16/10/21.
//  Copyright © 2016年 DA WENG. All rights reserved.
//

#import "ViewController.h"
#import "DWPayView.h"

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

    payView = [[DWPayView alloc]initWithorderFee:@"200" whomToPay:@"某某"];
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
