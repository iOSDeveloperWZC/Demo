//
//  FoodModel.h
//  HDAPP
//
//  Created by ataw on 16/11/14.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *foodId;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, strong) NSNumber *month_saled;
@property (nonatomic, copy) NSString *price;

@property(nonatomic,copy)NSString *itemNum;
@property(nonatomic,copy)NSString *itemAllPrice;
@property(nonatomic,assign)BOOL isSelect;

-(instancetype)initWithDic:(NSDictionary *)dic;
-(void)defaultValue;
-(NSDictionary *)dicFormModel1;
-(NSDictionary *)dicFormModel;
@end
