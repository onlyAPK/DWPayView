//
//  DWNumberKeyboardView.m
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWNumberKeyboardView.h"
#import "DWSizeDefined.h"
#define dwKEYBOADHEIGHT dwSCROLLVIEWHEIGHT*0.5
@implementation DWNumberKeyboardView
{
    NSArray* numarray;
    NSMutableString* tempString;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self setNumberLayout];
        [self setNumberTitle];
        tempString = [[NSMutableString alloc]init];
        self.frame = CGRectMake(0, dwSCROLLVIEWHEIGHT/3-dwKEYBOADHEIGHT/5 , dwDEVICESCREENWIDTH, dwKEYBOADHEIGHT+dwKEYBOADHEIGHT/5);
        UIView* keyboardTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, dwDEVICESCREENWIDTH, dwKEYBOADHEIGHT/5)];
        keyboardTitleView.backgroundColor = [UIColor whiteColor];
        UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, keyboardTitleView.frame.size.width, keyboardTitleView.frame.size.height)];
        UILabel* lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, dwDEVICESCREENWIDTH, 1)];
        lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [keyboardTitleView addSubview:lineLabel];
        titleLabel.text = @"安全键盘";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [keyboardTitleView addSubview:titleLabel];
        [self addSubview:keyboardTitleView];
    }
    return self;
}



-(void)setNumberTitle{
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM removeAllObjects];
    for (int i = 0 ; i < 10; i++) {
        int j = arc4random_uniform(10);
        NSNumber *number = [[NSNumber alloc] initWithInt:j];
        if ([arrM containsObject:number]) {
            i--;
            NSLog(@"%d",i);
            continue;
        }
        NSLog(@"he");
        [arrM addObject:number];
    }
    for (int k = 0; k<12; k++) {
        if (k<9) {
            UIButton* btn = [numarray objectAtIndex:k];
            NSNumber *number = arrM[k];
            NSString *title = number.stringValue;
            [btn setTitle:title forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else if (k==9){
            UIButton* btn = [numarray objectAtIndex:k+1];
            NSNumber *number = arrM[k];
            NSString *title = number.stringValue;
            [btn setTitle:title forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (k==10){
            UIButton* btn = [numarray objectAtIndex:k-1];
            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
        }else if (k==11){
            UIButton* btn = [numarray objectAtIndex:k];
            btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [btn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}



-(void)setNumberLayout{
    
    NSMutableArray* array= [[NSMutableArray alloc]init];
    for (int i=0; i<4; i++) {
        for (int j=0; j<3; j++) {
            UIButton* btn;
            btn = [[UIButton alloc]initWithFrame:CGRectMake(1+((dwDEVICESCREENWIDTH-4)/3+1)*j, 1+dwKEYBOADHEIGHT/5+((dwKEYBOADHEIGHT-5)/4+1)*i, (dwDEVICESCREENWIDTH-4)/3, (dwKEYBOADHEIGHT-5)/4)];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:25];
            [self addSubview:btn];
            [array addObject:btn];
            
        }
        
    }
    numarray = array;
    
}

- (void)numBtnClick:(UIButton *)numBtn {
    
    if (tempString.length<6) {
        [tempString appendString:numBtn.currentTitle];
        if ([_delegate respondsToSelector:@selector(inputtext:)]) {
            
            [_delegate inputtext:tempString];

        }
    }
    
}


-(void)deleteBtnClick{
    if (tempString.length>0) {
        [tempString deleteCharactersInRange:NSMakeRange(tempString.length - 1, 1)];
        
        if ([_delegate respondsToSelector:@selector(inputtext:)]) {
            
            [_delegate inputtext:tempString];

            
        }
    }
    
}

@end
