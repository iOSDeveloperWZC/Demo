//
//  LeftTableViewCell.h
//  HDAPP
//
//  Created by ataw on 16/11/14.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
@interface LeftTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *name;
@property(nonatomic,strong)CategoryModel *model;
@end
