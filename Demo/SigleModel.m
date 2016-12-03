//
//  SigleModel.m
//  HDAPP
//
//  Created by ataw on 16/11/14.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import "SigleModel.h"
static SigleModel *model= nil;
@implementation SigleModel
+(SigleModel *)defaultModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        model = [[SigleModel alloc]init];
        model.num = [NSString stringWithFormat:@"%@",@"0"];
        model.allPrice = [NSString stringWithFormat:@"%@",@"0"];
        model.selectArr = [NSMutableArray array];
    });
    
    return model;
}
@end
