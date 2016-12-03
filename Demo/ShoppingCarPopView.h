//
//  ShoppingCarPopView.h
//  HDAPP
//
//  Created by ataw on 16/11/15.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarPopView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UITableView *tableView;
-(instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)dataArr;
@end
