//
//  RightTableViewCell.m
//  HDAPP
//
//  Created by ataw on 16/11/14.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import "RightTableViewCell.h"
#import "ShoppingDetailHtmlViewController.h"
@implementation RightTableViewCell
{
    UILabel *numberLable;
    UIButton *reduceBtn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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
    UIImageView *headImageView = [[UIImageView alloc]init];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_model.picture]];
    headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [headImageView addGestureRecognizer:tap];
    [self.contentView addSubview:headImageView];
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    UILabel *titleLable = [UILabel new];
    titleLable.textColor = [self RGBHaveSpaceString:@"51 51 51"];
    titleLable.text = _model.name;
    titleLable.font = Font(14);
    [self.contentView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    UILabel *priceLable = [UILabel new];
    priceLable.textColor = [self RGBHaveSpaceString:@"255 68 0"];
    priceLable.text = [NSString stringWithFormat:@"¥ %@",_model.price];
    priceLable.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:priceLable];
    
    [priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(34.5);
        
    }];
    
    UILabel *numLable = [UILabel new];
    numLable.text = [NSString stringWithFormat:@"已售 %@笔",_model.month_saled];
    numLable.textColor = [self RGBHaveSpaceString:@"102 102 102"];
    numLable.font = Font(12);
    [self.contentView addSubview:numLable];
    [numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(priceLable.mas_bottom).mas_offset(9);
    }];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"addbtnImage"] forState:UIControlStateNormal];
    [self.contentView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(btnaction:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(21, 21));
        make.bottom.mas_equalTo(numLable.mas_bottom);
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
        make.bottom.mas_equalTo(numLable.mas_bottom);
        make.right.mas_equalTo(numberLable.mas_left);
    }];
    if ([_model.itemNum integerValue] == 0) {
        
        [self hidenBtn];
    }
    else
    {
//        for (int i = 0; i < [_model.itemNum integerValue]; i++) {
//            
//            [self btnaction:addBtn];
//        }
    }
    
    UIView *endLine = [[UIView alloc]init];
    endLine.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    [self.contentView addSubview:endLine];
    
    [endLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.contentView);
    }];

}

-(void)tap{
    
    ShoppingDetailHtmlViewController *vc = [[ShoppingDetailHtmlViewController alloc]init];
    vc.fid = _model.foodId;
    vc.delegate = self.viewController;
    [self.viewController presentViewController:vc animated:NO completion:nil];
}

-(void)hidenBtn
{
    numberLable.hidden = YES;
    reduceBtn.hidden = YES;
}

-(void)showBtn
{
    numberLable.hidden = NO;
    reduceBtn.hidden = NO;
}

-(void)btnaction:(UIButton *)button
{
    SigleModel *model = [SigleModel defaultModel];
    NSInteger allNum = [model.num integerValue];
    NSInteger num = [numberLable.text integerValue];
    NSString *sumString = model.allPrice;
    //减
    if (button == reduceBtn) {
        
        num--;
        
        if (num == 0) {
            
            [self hidenBtn];
            
        }
        numberLable.text = [NSString stringWithFormat:@"%lu",num];
        
        if (allNum == 0) {
            
            return;
        }
        allNum--;
        model.num = [NSString stringWithFormat:@"%lu",allNum];
        
        NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"-%@",_model.price]];
        NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:sumString];
        NSDecimalNumber *product = [multiplicandNumber decimalNumberByAdding:multiplierNumber];
        
        model.allPrice = [product stringValue];
        
    }//加
    else
    {
        [self showBtn];
        num++;
        numberLable.text = [NSString stringWithFormat:@"%lu",num];
        
        allNum++;
        model.num = [NSString stringWithFormat:@"%lu",allNum];
        NSString *sum = nil;
        sum = [self string1:sumString andString2:_model.price];
        model.allPrice = sum;
        
    }
    
    
    _model.itemNum = [NSString stringWithFormat:@"%lu",num];
    if ([_model.itemNum integerValue] != 0) {
        
    }
    else
    {
        _model.itemAllPrice = @"0";
    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
