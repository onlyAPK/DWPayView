//
//  DWEnterPasswordView.m
//  payView
//
//  Created by DA WENG on 2017/1/9.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWEnterPasswordView.h"
#import "DWSizeDefined.h"
#import "DWNumberKeyboardView.h"
#import "DWManageData.h"
#import "DWStateView.h"
#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height 45  //每一个输入框的高度
@interface DWEnterPasswordView ()<UITextFieldDelegate,SafeKeyBoardDelegate,ManageDataDelegate>
{
    DWStateView* stateView;
    UILabel* stateLabel;
    
}

@property (nonatomic,strong) NSMutableArray *dotArray; //用于存放黑色的点点
@property(nonatomic,strong)DWNumberKeyboardView* numberKeyboard;
@property(nonatomic,strong)UIView* passWordView;

@end

@implementation DWEnterPasswordView


/*
 代理传值获取到的交易结果
 只判断success或者fail来显示动画。
 */
-(void)passData:(id)data{
    NSLog(@"DWEnterPasswordView:%@",data);
    NSDictionary* dict = [[NSDictionary alloc]init];
    dict = data;
    stateView.hidden = YES;
    NSString* result = [dict objectForKey:@"result"];
    if ([result isEqualToString:@"success"]) {
        DWStateView* tickState = [[DWStateView alloc]initWithFrame:CGRectMake(self.frame.size.width*3/8, self.frame.size.width/4,self.frame.size.width/4,self.frame.size.width/4) withType:DWStateDisplayTypeSuccessTick withColor:[UIColor colorWithRed:53.0/255.0 green:203.0/255.0 blue:75.0/255.0 alpha:1]];
        [self addSubview:tickState];
        stateLabel.text = @"支付成功";
        [self performSelector:@selector(successDelayMethod) withObject:nil afterDelay:2.8f];
    }else if ([result isEqualToString:@"fail"]){
        
        DWStateView* tickState = [[DWStateView alloc]initWithFrame:CGRectMake(self.frame.size.width*3/8, self.frame.size.width/4,self.frame.size.width/4,self.frame.size.width/4) withType:DWStateDisplayTypeFailCross withColor:[UIColor colorWithRed:252.0/255.0 green:99.0/255.0 blue:94.0/255.0 alpha:1]];
        [self addSubview:tickState];
        stateLabel.text = @"支付失败";
        [self performSelector:@selector(failDelayMethod) withObject:nil afterDelay:2.8f];
        
    }
    
}

//动画显示完成后，等0.8秒整个页面消失
-(void)successDelayMethod{
//    stateLabel.text = @"支付成功";
    [self performSelector:@selector(postNotification) withObject:nil afterDelay:0.8f];
    
}

//动画显示完成后，等0.8秒整个页面消失
-(void)failDelayMethod{
//    stateLabel.text = @"支付失败";
    [self performSelector:@selector(postNotification) withObject:nil afterDelay:0.8f];
}

//通知DWPayView，回收页面
-(void)postNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finishPay" object:nil userInfo:nil];
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.numberKeyboard = [[DWNumberKeyboardView alloc]init];
        self.numberKeyboard.delegate = self;
        self.textField.inputView = self.numberKeyboard;
        [self addSubview:self.textField];
        [self.textField becomeFirstResponder];
        [self initPwdTextField];
        
        
    }
    return self;
}

- (void)initPwdTextField
{
    //每个密码输入框的宽度
    CGFloat width = (dwDEVICESCREENWIDTH - dwMARGINTOLEFT*2) / kDotCount;
    self.passWordView = [[UIView alloc]initWithFrame:self.textField.frame];
    [self addSubview:self.passWordView];
    //生成分割线
    for (int i = 0; i < kDotCount - 1; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0 + (i + 1) * width, 0, 1, K_Field_Height)];
        lineView.backgroundColor = [UIColor grayColor];
        [self.passWordView addSubview:lineView];
    }
    
    self.dotArray = [[NSMutableArray alloc] init];
    //生成中间的点
    for (int i = 0; i < kDotCount; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(0 + (width - kDotCount) / 2 + i * width, 0 + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self.passWordView addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
    
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(dwMARGINTOLEFT, dwMARGINTOLEFT, dwDEVICESCREENWIDTH - dwMARGINTOLEFT*2, K_Field_Height)];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(inputtext:) forControlEvents:UIControlEventEditingChanged];//使用自定义键盘
        //         [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];使用系统键盘
    }
    return _textField;
}

-(void)inputtext:(NSString *)inputtext{
    self.textField.text = inputtext;
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < self.textField.text.length; i++) {
        
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (self.textField.text.length == kDotCount) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"disableBackBtn" object:nil userInfo:nil];//禁用返回键通知
        
        [self.numberKeyboard removeFromSuperview];
        [self.textField removeFromSuperview];
        [self.passWordView removeFromSuperview];
        
        stateView = [[DWStateView alloc]initWithFrame:CGRectMake(self.frame.size.width*3/8, self.frame.size.width/4,self.frame.size.width/4,self.frame.size.width/4) withType:DWStateDisplayTypeDrawCircle withColor:[UIColor colorWithRed:53.0/255.0 green:203.0/255.0 blue:75.0/255.0 alpha:1]];
        [self addSubview:stateView];
        stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(stateView.frame.origin.x, stateView.frame.origin.y+stateView.frame.size.height+10, stateView.frame.size.width, stateView.frame.size.height/4)];
        stateLabel.text = @"正在支付";
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:stateLabel];
        
        
        DWManageData* manageData = [[DWManageData alloc]init];
        manageData.delegate = self;
        [manageData payOrderWithPassword:inputtext withBankCardInfo:self.payBankInfo];
    }
    
}


//使用系统自带键盘
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}


- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
    }
}


@end
