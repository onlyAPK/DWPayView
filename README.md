# DWPayView 支付界面封装

![图片](https://raw.githubusercontent.com/onlyAPK/DWPayView/master/pictures/payView.gif
)


包含有随机数字键盘，Loading动画等功能。可以单独提取出来使用<br>
![图片](https://raw.githubusercontent.com/onlyAPK/DWPayView/master/pictures/loading.gif
      )
<br>
<br>


###用DWPayView显示界面，代码如下
```
DWPayView* payView = [[DWPayView alloc]initWithorderFee:@"价格" whomToPay:@"商家姓名"];
[payView showInView:self.view];
```

###DWManageData中设置网络请求方法，方法如下
```
-(void)getInitPayMethod;//获取默认支付方式
-(void)getBankList;//获取银行卡列表
-(void)payOrderWithPassword:(NSString*)passWord withBankCardInfo:(NSDictionary*)bankCardInfo;//提交交易

```

