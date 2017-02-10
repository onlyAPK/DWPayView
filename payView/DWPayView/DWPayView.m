//
//  DWPayView.m
//  payView
//
//  Created by DA WENG on 2017/1/9.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWPayView.h"
#import "DWEnterPasswordView.h"
#import "DWBankListView.h"
#import "DWSizeDefined.h"
#import "DWCrossView.h"
#import "DWArrowView.h"
#import "DWManageData.h"
#import "DWViewConvertToImage.h"
@interface DWPayView ()<UITableViewDelegate,UITableViewDataSource,ManageDataDelegate>
@property(nonatomic,strong)NSArray* titleArray;
@property(nonatomic,strong)DWManageData* manageData;
@end

@implementation DWPayView
{
    UIScrollView* scrollView;
    UITableView* payMethodTableView;
    DWEnterPasswordView* enterPasswordView;
    DWBankListView* bankListView;
    UILabel* secondTitle;
    NSDictionary* payMethodDict;
    UIButton* backBtn;
    NSString* orderFeeAmount;
}

/*
 代理传值获取到的默认银行卡信息
 可根据服务器返回信息自行修改
 记得修改-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath中的payMethodDict字典key值，以便正确显示银行卡和姓名
 */
-(void)passData:(id)data{
    NSLog(@"payview%@",data);
    NSDictionary* dict = [[NSDictionary alloc]init];
    dict = data;
    
    payMethodDict = dict;
    [payMethodTableView reloadData];
}


/*
 回传选号的银行卡信息
 可将服务器报文直接转成字典传过来，也可以重新生成字典来传、
 记得修改-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath中的payMethodDict字典key值，以便正确显示银行卡和姓名
 */
-(void)bankCardSelected:(NSNotification *)notification{
    [self backClick];
    payMethodDict = [notification userInfo];
    NSLog(@"%@",payMethodDict);
    [payMethodTableView reloadData];
    
}


#pragma mark 初始化界面
-(instancetype)initWithorderFee:(NSString*)orderFee whomToPay:(NSString*)whomToPay{
    
    self=[super init];
    
    if (self) {
        
        [self initContentWithOrderFee:orderFee whomToPay:whomToPay];
        
    }
    
    return self;
    
}

- (void)initContentWithOrderFee:(NSString*)orderFee whomToPay:(NSString*)whomToPay
{
    payMethodDict = [[NSDictionary alloc]init];
    
    [self getInitPayBankInfo];
    
    self.frame = CGRectMake(0, 0, dwDEVICESCREENWIDTH, dwDEVICESCREENHEIGHT);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    self.titleArray = @[@"支付方式",@"持卡人"];
    
    if(scrollView ==nil){
        
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, dwDEVICESCREENHEIGHT-dwSCROLLVIEWHEIGHT,dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
        scrollView.contentSize = CGSizeMake(dwDEVICESCREENWIDTH*2, dwSCROLLVIEWHEIGHT);
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        [scrollView setBounces:NO];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        scrollView.scrollEnabled = NO;
        
        UIView* firstTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, dwDEVICESCREENWIDTH, dwBUTTONWIDTH)];
        UILabel* firstTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, firstTitleView.frame.size.width, firstTitleView.frame.size.height)];
        firstTitle.text = @"**支付";
        firstTitle.textAlignment = NSTextAlignmentCenter;
        [firstTitleView addSubview:firstTitle];
        [scrollView addSubview:firstTitleView];
        
        UIView* secondTitleView = [[UIView alloc]initWithFrame:CGRectMake(dwDEVICESCREENWIDTH, 0, dwDEVICESCREENWIDTH, dwBUTTONWIDTH)];
        secondTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, secondTitleView.frame.size.width, secondTitleView.frame.size.height)];
        secondTitle.textAlignment = NSTextAlignmentCenter;
        [secondTitleView addSubview:secondTitle];
        [scrollView addSubview:secondTitleView];
        
        
        UIButton* closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, dwBUTTONWIDTH, dwBUTTONWIDTH)];
        DWCrossView* crossView = [[DWCrossView alloc]initWithFrame:closeBtn.frame];
        [scrollView addSubview:crossView];
        UIImage * crossimage = [[DWViewConvertToImage alloc]initWithView:crossView];
        [closeBtn setImage:crossimage forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:closeBtn];
        
        
        UIButton* nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(dwMARGINTOLEFT, scrollView.frame.size.height-dwBUTTONWIDTH*1.1-dwMARGINTOLEFT*1.5, dwDEVICESCREENWIDTH-dwMARGINTOLEFT*2, dwBUTTONWIDTH*1.1)];
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = 5;
        nextBtn.backgroundColor = [UIColor colorWithRed:71.0/255.0 green:37.0/255.0 blue:116.0/255.0 alpha:1];
        [nextBtn setTitle:@"确认付款" forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:nextBtn];
        
        
        backBtn = [[UIButton alloc]initWithFrame:CGRectMake(dwDEVICESCREENWIDTH, 0, dwBUTTONWIDTH, dwBUTTONWIDTH)];
        DWArrowView* arrowView = [[DWArrowView alloc]initWithFrame:backBtn.frame];
        [scrollView addSubview:arrowView];
        UIImage * arrowimage = [[DWViewConvertToImage alloc]initWithView:arrowView];
        [backBtn setImage:arrowimage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:backBtn];
        
        
        UILabel* lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, closeBtn.frame.size.height, dwDEVICESCREENWIDTH, 0.2)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [scrollView addSubview:lineLabel];
        
        UILabel* payToWhomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, closeBtn.frame.size.height*2, dwDEVICESCREENWIDTH, closeBtn.frame.size.height/2)];
        payToWhomLabel.text = [NSString stringWithFormat:@"向%@支付",whomToPay];
        payToWhomLabel.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:payToWhomLabel];
        
        UILabel* moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, payToWhomLabel.frame.origin.y+payToWhomLabel.frame.size.height, dwDEVICESCREENWIDTH, payToWhomLabel.frame.size.height*2.3)];
        moneyLabel.text =orderFee;
        moneyLabel.font = [UIFont systemFontOfSize:36];
        moneyLabel.textAlignment =NSTextAlignmentCenter;
        [scrollView addSubview:moneyLabel];
        
        payMethodTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, moneyLabel.frame.origin.y+moneyLabel.frame.size.height+payToWhomLabel.frame.size.height,dwDEVICESCREENWIDTH , dwBUTTONWIDTH*2)];
        payMethodTableView.rowHeight = dwBUTTONWIDTH;
        payMethodTableView.dataSource = self;
        payMethodTableView.delegate = self;
        payMethodTableView.bounces = NO;
        [scrollView addSubview:payMethodTableView];
        
        UILabel* lineLabe2 = [[UILabel alloc]initWithFrame:CGRectMake(15, payMethodTableView.frame.origin.y, dwDEVICESCREENWIDTH, 0.2)];
        lineLabe2.backgroundColor = [UIColor lightGrayColor];
        [scrollView addSubview:lineLabe2];
        
    }
    
}

#pragma mark 获取默认的支付方式
-(void)getInitPayBankInfo{
    
    DWManageData* manageData = [[DWManageData alloc]init];
    manageData.delegate = self;
    [manageData getInitPayMethod];
    
}

#pragma mark tableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.textLabel.text = [self.titleArray objectAtIndex:[indexPath row]];
    
    
    
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.detailTextLabel.text = [payMethodDict objectForKey:@"bankCard"];//根据获取数据修改
        
    }else if (indexPath.row == 1){
        
        cell.detailTextLabel.text = [payMethodDict objectForKey:@"userName"];//根据获取数据修改
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self bankListClick];
    }
}

#pragma mark 弹出页面
- (void)showInView:(UIView *)view
{
    if (!view)
    {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:scrollView];
    
    [scrollView setFrame:CGRectMake(0, dwDEVICESCREENHEIGHT, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        backBtn.enabled = YES;
        [self getInitPayBankInfo];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disMissView) name:@"finishPay" object:nil];//完成交易后，页面消失观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableBackBtn) name:@"disableBackBtn" object:nil];//输入密码，使返回按钮失效观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bankCardSelected:) name:@"bankCardSelected" object:nil];//选择完银行卡，返回传值观察者
        
        
        [scrollView setFrame:CGRectMake(0, dwDEVICESCREENHEIGHT - dwSCROLLVIEWHEIGHT, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
        
    } completion:nil];
}

#pragma mark 回收页面
- (void)disMissView
{
    [scrollView setFrame:CGRectMake(0, dwDEVICESCREENHEIGHT - dwSCROLLVIEWHEIGHT, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [scrollView setFrame:CGRectMake(0, dwDEVICESCREENHEIGHT, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
                     }
                     completion:^(BOOL finished){
                         [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
                         [self removeFromSuperview];
                         [scrollView removeFromSuperview];
                         [[NSNotificationCenter defaultCenter] removeObserver:self name:@ "finishPay"  object:nil];//移除通知
                         [[NSNotificationCenter defaultCenter] removeObserver:self name:@ "disableBackBtn"  object:nil];//移除通知
                         [[NSNotificationCenter defaultCenter] removeObserver:self name:@ "bankCardSelected"  object:nil];//移除通知
                         
                     }];
    
}

#pragma mark 按钮操作
-(void)nextClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bankInfoForPay" object:nil userInfo:payMethodDict];//将银行卡信息传到DWManageData中，方便最后提交交易使用
    NSLog(@"lalalla%@",payMethodDict);
    CGFloat offsetX = scrollView.bounds.size.width;
    [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    secondTitle.text = @"输入数字支付密码";
    enterPasswordView = [[DWEnterPasswordView alloc]initWithFrame:CGRectMake(dwDEVICESCREENWIDTH, dwBUTTONWIDTH, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
    enterPasswordView.payBankInfo = payMethodDict;
    [scrollView addSubview:enterPasswordView];
    
}

-(void)backClick{
    
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [enterPasswordView.textField resignFirstResponder];
    
}

-(void)bankListClick{
    CGFloat offsetX = scrollView.bounds.size.width;
    [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    secondTitle.text = @"选择支付方式";
    bankListView = [[DWBankListView alloc]initWithFrame:CGRectMake(dwDEVICESCREENWIDTH, dwBUTTONWIDTH, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
    [scrollView addSubview:bankListView];
    
}




//输入完密码后禁用返回键
-(void)disableBackBtn{
    
    backBtn.enabled = NO;
    backBtn.adjustsImageWhenDisabled = NO;
    
}



@end
