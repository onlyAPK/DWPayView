# DWPayView
支付界面封装
使用scrollView来控制界面的滑动

##使用DWPayView显示界面

```
DWPayView* payView = [[DWPayView alloc]initWithorderFee:@"价格" whomToPay:@"商家姓名"];
[payView showInView:self.view];
```
```
##DWManageData中设置网络请求方法
-(void)getInitPayMethod;//获取默认支付方式
-(void)getBankList;//获取银行卡列表
-(void)payOrderWithPassword:(NSString*)passWord withBankCardInfo:(NSDictionary*)bankCardInfo;//提交交易

```

