//
//  DWBankListView.m
//  payView
//
//  Created by DA WENG on 2017/1/9.
//  Copyright © 2017年 DA WENG. All rights reserved.
//

#import "DWBankListView.h"
#import "DWSizeDefined.h"
#import "DWManageData.h"
@interface DWBankListView ()<UITableViewDelegate,UITableViewDataSource,ManageDataDelegate>
{
    UITableView* banklistTableView;
    NSArray* banklistArray;

}
@end


@implementation DWBankListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initContent];
    }
    return self;
}

-(void)initContent{
    self.backgroundColor = [UIColor greenColor];
    
    banklistArray = [[NSArray alloc]init];
    
    UILabel* lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.2)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineLabel];
    
    banklistTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width , self.frame.size.height)];
    banklistTableView.rowHeight = dwBUTTONWIDTH*1.5;
    banklistTableView.dataSource = self;
    banklistTableView.delegate = self;
    [self addSubview:banklistTableView];
    
    DWManageData* manageData = [[DWManageData alloc]init];
    manageData.delegate = self;
    [manageData getBankList];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return banklistArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.textLabel.text = [banklistArray objectAtIndex:[indexPath row]];
    
    return cell;
}

-(void)passArray:(NSArray *)array{
    banklistArray = array;
    [banklistTableView reloadData];

}

@end
