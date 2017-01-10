//
//  DWSizeDefined.h
//  payView
//
//  Created by DA WENG on 2017/1/10.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#define dwDEVICESCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define dwDEVICESCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define dwSCROLLVIEWHEIGHT dwDEVICESCREENHEIGHT*60/100
#define dwBUTTONWIDTH dwDEVICESCREENWIDTH*0.1
#define dwMARGINTOLEFT dwDEVICESCREENWIDTH*0.05
@interface DWSizeDefined : NSObject

@end
