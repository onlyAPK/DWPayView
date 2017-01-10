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
#import "DWLineView.h"
#import "DWSizeDefined.h"
#import "DWCrossView.h"
#import "DWArrowView.h"
#import "DWManageData.h"
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
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self initContent];
    }
    return self;
}

- (void)initContent
{
    
    DWManageData* manageData = [[DWManageData alloc]init];
    manageData.delegate = self;
    [manageData getInitPayMethod];
    self.frame = CGRectMake(0, 0, dwDEVICESCREENWIDTH, dwDEVICESCREENHEIGHT);
    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    //    self.userInteractionEnabled = YES;
    //    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
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
        firstTitle.text = @"鸡年大吉吧支付";
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
        UIImage * crossimage = [self getImageFromView:crossView];
        [closeBtn setImage:crossimage forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:closeBtn];
        
        
        UIButton* nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(dwMARGINTOLEFT, scrollView.frame.size.height-dwBUTTONWIDTH*1.1-dwMARGINTOLEFT*1.5, dwDEVICESCREENWIDTH-dwMARGINTOLEFT*2, dwBUTTONWIDTH*1.1)];
        nextBtn.layer.masksToBounds = YES;
        nextBtn.layer.cornerRadius = 5;
        nextBtn.backgroundColor = [UIColor blueColor];
        [nextBtn setTitle:@"确认付款" forState:UIControlStateNormal];
        [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:nextBtn];
        
        
        UIButton* backBtn = [[UIButton alloc]initWithFrame:CGRectMake(dwDEVICESCREENWIDTH, 0, dwBUTTONWIDTH, dwBUTTONWIDTH)];
        DWArrowView* arrowView = [[DWArrowView alloc]initWithFrame:backBtn.frame];
        [scrollView addSubview:arrowView];
        UIImage * arrowimage = [self getImageFromView:arrowView];
        [backBtn setImage:arrowimage forState:UIControlStateNormal];
        backBtn.backgroundColor = [UIColor blueColor];
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:backBtn];
        
        //        DWLineView* lineView = [[DWLineView alloc]initWithFrame:CGRectMake(0, closeBtn.frame.size.height, dwDEVICESCREENWIDTH, 0.5)];
        //        [scrollView addSubview: lineView];
        UILabel* lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, closeBtn.frame.size.height, dwDEVICESCREENWIDTH, 0.2)];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [scrollView addSubview:lineLabel];
        
        UILabel* payToWhomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, closeBtn.frame.size.height*2, dwDEVICESCREENWIDTH, closeBtn.frame.size.height/2)];
        payToWhomLabel.text = @"向大喆棒棒糖支付";
        payToWhomLabel.textAlignment = NSTextAlignmentCenter;
        [scrollView addSubview:payToWhomLabel];
        
        
        UILabel* moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, payToWhomLabel.frame.origin.y+payToWhomLabel.frame.size.height, dwDEVICESCREENWIDTH, payToWhomLabel.frame.size.height*2.3)];
        moneyLabel.text = @"$100";
        moneyLabel.font = [UIFont systemFontOfSize:36];
        moneyLabel.textAlignment =NSTextAlignmentCenter;
        [scrollView addSubview:moneyLabel];
        
        payMethodTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, moneyLabel.frame.origin.y+moneyLabel.frame.size.height+payToWhomLabel.frame.size.height,dwDEVICESCREENWIDTH , dwBUTTONWIDTH*2)];
        payMethodTableView.rowHeight = dwBUTTONWIDTH;
        payMethodTableView.dataSource = self;
        payMethodTableView.delegate = self;
        payMethodTableView.bounces = NO;
        [scrollView addSubview:payMethodTableView];
        
    }
    
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
        cell.detailTextLabel.text = [payMethodDict objectForKey:@"付款方式"];
        
    }else if (indexPath.row == 1){
        
        cell.detailTextLabel.text = [payMethodDict objectForKey:@"持卡人"];
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self bankList];
    }
}


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
        
        [scrollView setFrame:CGRectMake(0, dwDEVICESCREENHEIGHT - dwSCROLLVIEWHEIGHT, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
        
    } completion:nil];
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView
{
    [scrollView setFrame:CGRectMake(0, dwDEVICESCREENHEIGHT - dwSCROLLVIEWHEIGHT, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [scrollView setFrame:CGRectMake(0, dwDEVICESCREENHEIGHT, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         [scrollView removeFromSuperview];
                         
                     }];
    
}

- (UIImage *)getImageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


-(void)nextClick{
    CGFloat offsetX = scrollView.bounds.size.width;
    [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    secondTitle.text = @"输入数字支付密码";
    enterPasswordView = [[DWEnterPasswordView alloc]initWithFrame:CGRectMake(dwDEVICESCREENWIDTH, dwBUTTONWIDTH, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
    [scrollView addSubview:enterPasswordView];
    
    
}

-(void)backClick{
    
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [enterPasswordView.textField resignFirstResponder];
    
}

-(void)bankList{
    CGFloat offsetX = scrollView.bounds.size.width;
    [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    secondTitle.text = @"选择支付方式";
    bankListView = [[DWBankListView alloc]initWithFrame:CGRectMake(dwDEVICESCREENWIDTH, dwBUTTONWIDTH, dwDEVICESCREENWIDTH, dwSCROLLVIEWHEIGHT)];
    [scrollView addSubview:bankListView];
    
}

-(void)passDict:(NSDictionary *)dict{
    NSLog(@"1111%@",dict);

    payMethodDict = dict;
    [payMethodTableView reloadData];
}

@end
