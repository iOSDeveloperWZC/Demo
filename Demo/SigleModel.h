//
//  SigleModel.h
//  HDAPP
//
//  Created by ataw on 16/11/14.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SigleModel : NSObject

@property(nonatomic,copy)NSString *num;
@property(nonatomic,copy)NSString *allPrice;
@property(nonatomic,strong)NSMutableArray *selectArr;
+(SigleModel *)defaultModel;
@end
