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
#import "SuccessView.h"
#import "DWManageData.h"
#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数
#define K_Field_Height 45  //每一个输入框的高度
@interface DWEnterPasswordView ()<UITextFieldDelegate,SafeKeyBoardDelegate,ManageDataDelegate>


@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点
@property(nonatomic,strong)DWNumberKeyboardView* numberKeyboard;
@property(nonatomic,strong)UIView* passWordView;

@end

@implementation DWEnterPasswordView

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
    
    //    //生成分割线
    //    for (int i = 0; i < kDotCount - 1; i++) {
    //        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i + 1) * width, CGRectGetMinY(self.textField.frame), 1, K_Field_Height)];
    //        lineView.backgroundColor = [UIColor grayColor];
    //        [self addSubview:lineView];
    //    }
    //
    //    self.dotArray = [[NSMutableArray alloc] init];
    //    //生成中间的点
    //    for (int i = 0; i < kDotCount; i++) {
    //        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - kDotCount) / 2 + i * width, CGRectGetMinY(self.textField.frame) + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
    //        dotView.backgroundColor = [UIColor blackColor];
    //        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
    //        dotView.clipsToBounds = YES;
    //        dotView.hidden = YES; //先隐藏
    //        [self addSubview:dotView];
    //        //把创建的黑色点加入到数组中
    //        [self.dotArray addObject:dotView];
    //    }
}


#pragma mark - init

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
        [_textField addTarget:self action:@selector(inputtext:) forControlEvents:UIControlEventEditingChanged];
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
        NSLog(@"输入完毕,%@",inputtext);
        DWManageData* manageData = [[DWManageData alloc]init];
        manageData.delegate = self;
        [manageData payOrder];
        
        [self.numberKeyboard removeFromSuperview];
        [self.textField removeFromSuperview];
        [self.passWordView removeFromSuperview];
        SuccessView* successView = [[SuccessView alloc]initWithFrame:CGRectMake(30, 30,self.frame.size.width-60,self.frame.size.height-60)];
        [self addSubview:successView];
        
    }
    
}

-(void)passDict:(NSDictionary *)dict{
    NSLog(@"1111%@",dict);
    
    
    
}






//使用系统自带键盘
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSLog(@"变化%@", string);
//    if([string isEqualToString:@"\n"]) {
//        //按回车关闭键盘
//        [textField resignFirstResponder];
//        return NO;
//    } else if(string.length == 0) {
//        //判断是不是删除键
//        return YES;
//    }
//    else if(textField.text.length >= kDotCount) {
//        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
//        NSLog(@"输入的字符个数大于6，忽略输入");
//        return NO;
//    } else {
//        return YES;
//    }
//}

/**
 *  重置显示的点
 */
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    NSLog(@"%@", textField.text);
//    for (UIView *dotView in self.dotArray) {
//        dotView.hidden = YES;
//    }
//    for (int i = 0; i < textField.text.length; i++) {
//        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
//    }
//    if (textField.text.length == kDotCount) {
//        NSLog(@"输入完毕");
//    }
//}


@end
