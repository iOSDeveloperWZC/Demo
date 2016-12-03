//
//  FoodModel.m
//  HDAPP
//
//  Created by ataw on 16/11/14.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import "FoodModel.h"
/*
 @property (nonatomic, copy) NSString *name;
 @property (nonatomic, copy) NSString *foodId;
 @property (nonatomic, copy) NSString *picture;
 @property (nonatomic, strong) NSNumber *month_saled;
 @property (nonatomic, copy) NSString *price;
 
 FID = 20161114151313153AAA69F0B017CE4A2F906450538123162F;
 "S_Money" = 99;
 "S_Name" = "\U6309\U6469\U68d2";
 "S_Photo" = "http://imghz.ataw.cn/Estate/Reservation/Image/2016/11/14/File/20161114151313153AAA69F0B017CE4A2F906450538123162F.jpg";
 "S_Sell" = 0;
 */
@implementation FoodModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self == [super init]) {
        _isSelect = NO;
        _foodId = dic[@"FID"];
        _name = dic[@"S_Name"];
        _picture = dic[@"S_Photo"];
        _month_saled = dic[@"S_Sell"];
        if ([dic[@"S_Money"] isKindOfClass:[NSNull class]]) {
            
            _price = @"0";
        }
        else
        {
            _price = [NSString stringWithFormat:@"%@",dic[@"S_Money"]];
        }
        
        _itemNum = @"0";
        [self nullDeal];
        
        NSArray *as = [_price componentsSeparatedByString:@"."];
        NSString *s = @"";
        //有小数
        if (as.count > 1) {
            s = as[1];
            if ([as[1] length] > 2) {
                
                s = [s substringToIndex:2];
                _price = [NSString stringWithFormat:@"%@.%@",as[0],s];
            }
        }

        
    }
    
    return self;
}

-(NSDictionary *)dicFormModel1
{
    NSDictionary *dic = @{@"FID":_foodId,@"S_Name":_name,@"S_Photo":_picture,@"S_Sell":@([_itemNum integerValue]),@"S_Money":_price};
    return dic;
}

-(NSDictionary *)dicFormModel
{
    NSDictionary *dic = @{@"foodId":_foodId,@"foodName":_name,@"foodNum":_itemNum};
    return dic;
}
-(void)defaultValue
{
    _name = @"土鸡蛋";
    _picture = @"http://i.epetbar.com/2013-08/11/32472b0bb9556672ec6c0afb6b502661.jpg";
    _month_saled = @1000;
    _price = @"25.9";
}
@end
