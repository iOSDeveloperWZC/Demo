//
//  LeftTableViewCell.m
//  HDAPP
//
//  Created by ataw on 16/11/14.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import "LeftTableViewCell.h"

@implementation LeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        self.name.numberOfLines = 0;
        self.name.font = [UIFont systemFontOfSize:14];
        self.name.textAlignment = NSTextAlignmentCenter;
        self.name.textColor = [self RGBHaveSpaceString:@"102 102 102"];
        self.name.highlightedTextColor = [self RGBHaveSpaceString:@"238 58 58"];
        [self.contentView addSubview:self.name];
        
    }
    return self;
}
-(void)setModel:(CategoryModel *)model
{
    self.name.text = model.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
    self.contentView.backgroundColor = selected ? [UIColor whiteColor] : [self RGBHaveSpaceString:@"238 237 247"];
    self.highlighted = selected;
    self.name.highlighted = selected;
}

@end
