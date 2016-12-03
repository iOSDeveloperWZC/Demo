//
//  CategoryModel.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "CategoryModel.h"

@implementation CategoryModel
-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        
        _name = dic[@"T_Name"];
        _spus = dic[@"Shop_Goods"];
    }
    
    return self;
}
-(void)defaultVale:(NSInteger)i
{
    _name = [NSString stringWithFormat:@"分类%ld",(long)i];
//    _spus = @[];
}

@end
