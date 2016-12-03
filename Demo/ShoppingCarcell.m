//
//  ShoppingCarcell.m
//  HDAPP
//
//  Created by ataw on 16/11/15.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import "ShoppingCarcell.h"

@implementation ShoppingCarcell
{
    UILabel *numberLable;
    UIButton *reduceBtn;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

-(void)setModel:(FoodModel *)model
{
    _model = model;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self creatView];
}

-(void)creatView
{
    if (_model == nil) {
        
        return;
    }

    [self removeAllView];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"addbtnImage"] forState:UIControlStateNormal];
    [self.contentView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
    }];
    
    numberLable = [UILabel new];
    numberLable.textColor = [self RGBHaveSpaceString:@"51 51 51"];
    numberLable.font = Font(11);
    numberLable.text = _model.itemNum;
    numberLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:numberLable];
    [numberLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(addBtn.mas_centerY);
        make.width.mas_equalTo(38);
        make.right.mas_equalTo(addBtn.mas_left);
    }];
    
    reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceBtn setImage:[UIImage imageNamed:@"reducebtnImage"] forState:UIControlStateNormal];
    [reduceBtn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:reduceBtn];
    
    [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(numberLable.mas_left);
    }];
    
    UILabel *priceLable = [UILabel new];
    priceLable.textColor = [self RGBHaveSpaceString:@"255 68 0"];
    priceLable.font = [UIFont boldSystemFontOfSize:16];
    priceLable.text = _model.price;
    [self.contentView addSubview:priceLable];
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    UILabel *leftLable = [UILabel new];
    leftLable.text = _model.name;
    leftLable.textAlignment = NSTextAlignmentLeft;
    leftLable.textColor = [self RGBHaveSpaceString:@"51 51 51"];
    leftLable.font = Font(13);
    [self.contentView addSubview:leftLable];
    [leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.right.mas_lessThanOrEqualTo(priceLable.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(priceLable.mas_centerY);
    }];
  
}

-(void)btnaction:(UIButton *)button
{
    SigleModel *sigleModel = [SigleModel defaultModel];
    NSInteger allNum = [sigleModel.num integerValue];
    NSInteger num = [numberLable.text integerValue];
    NSString *sumString = sigleModel.allPrice;
    //减
    if (button == reduceBtn) {
        
        num--;
        
        
        numberLable.text = [NSString stringWithFormat:@"%lu",num];
        
        if (allNum == 0) {
            
            return;
        }
        allNum--;
        sigleModel.num = [NSString stringWithFormat:@"%lu",allNum];
        
        NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"-%@",_model.price]];
        NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:sumString];
        NSDecimalNumber *product = [multiplicandNumber decimalNumberByAdding:multiplierNumber];
        
        sigleModel.allPrice = [product stringValue];
        
    }//加
    else
    {
       
        num++;
        numberLable.text = [NSString stringWithFormat:@"%lu",num];
        
        allNum++;
        sigleModel.num = [NSString stringWithFormat:@"%lu",allNum];
        NSString *sum = nil;
        sum = [self string1:sumString andString2:_model.price];
        sigleModel.allPrice = sum;
        
    }
    
    _model.itemNum = [NSString stringWithFormat:@"%lu",num];
    if ([_model.itemNum integerValue] != 0) {
        
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateCar" object:nil];
        _model.itemAllPrice = @"0";
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRightTable" object:nil];
}
@end
