//
//  ShoppingCarPopView.m
//  HDAPP
//
//  Created by ataw on 16/11/15.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import "ShoppingCarPopView.h"
#import "ShoppingCarcell.h"
@implementation ShoppingCarPopView
{
    UIView *bottonView;
}

-(instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)dataArr;
{
    if (self == [super initWithFrame:frame]) {
        _dataArr = [NSMutableArray array];
        for (FoodModel *model in dataArr) {
            
            if ([model.itemNum integerValue] != 0) {
                
                [_dataArr addObject:model];
            }
        }
        
        [self creatTable];
    }
    
    return self;
}

-(void)creatTable
{
    if (_dataArr.count == 0) {
        [XHToast showCenterWithText:@"购物车是空的"];
        return;
    }
    CGFloat height =  44*_dataArr.count+40;
    if (height > CGRectGetHeight(self.frame)-100) {
        height = CGRectGetHeight(self.frame) - 100;
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.frame)-height, kScreenWidth,  height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 44;
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
    
    [_tableView registerClass:[ShoppingCarcell class] forCellReuseIdentifier:@"ShoppingCarcell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updataTable) name:@"updateCar" object:nil];
}
#pragma mark -清除购物车
-(void)clearAction
{
    SigleModel *mo = [SigleModel defaultModel];
    for (FoodModel *model in _dataArr) {
        
        model.itemNum = @"0";
    }
    
    mo.allPrice = @"0.00";
    mo.num = @"0";
    [self saveData];
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateRightTable" object:nil];
}

-(void)saveData
{
    NSMutableArray  *arr ;
    arr = [NSMutableArray array];
    
    for (FoodModel *mode in [SigleModel defaultModel].selectArr) {
        //20161114133220550A17D0112481E8426B8DDE9599EB08D9C5
        if ([mode.itemNum integerValue] != 0) {
            
            [arr addObject:[mode dicFormModel]];
        }
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//文件管理器
    [fileManager removeItemAtPath:[self filePath] error:nil];
    [arr writeToFile:[self filePath] atomically:YES];
}

-(NSString *)filePath
{
    //程序包路径
    //    NSString *string = [[NSBundle mainBundle] pathForResource:@"SearchHistory" ofType:@"plist"];
    //    return string;
    //获取沙盒目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"ShoppingCar.plist"];
    
    return filename;
}
//减少到0处理
-(void)updataTable
{
    NSMutableArray *datas = [NSMutableArray arrayWithArray:_dataArr];
    
    [_dataArr removeAllObjects];
    
    for (FoodModel *model in datas) {
        
        if ([model.itemNum integerValue] != 0) {
            
            [_dataArr addObject:model];
        }
    }
    CGFloat height =  44*_dataArr.count+40;
    if (height > CGRectGetHeight(self.frame)-100) {
        height = CGRectGetHeight(self.frame) - 100;
    }
    if (_dataArr.count == 0) {
        
        [self removeFromSuperview];
    }
    else
    {
        _tableView.frame = CGRectMake(0,CGRectGetHeight(self.frame)-height, kScreenWidth,  height);
    }
    [_tableView reloadData];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (bottonView != nil) {
        
        return bottonView;
    }
    
    bottonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    bottonView.backgroundColor = [self RGBHaveSpaceString:@"238 237 247"];
    UILabel *lable1 = [UILabel new];
    lable1.text = @"购物车";
    lable1.font = Font(15);
    lable1.textColor = [self RGBHaveSpaceString:@"51 51 51"];
    [bottonView addSubview:lable1];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(18);
        make.centerY.mas_equalTo(bottonView.mas_centerY);
    }];
    
    UILabel *lable2 = [UILabel new];
    lable2.text = @"清空";
    lable2.font = Font(15);
    lable2.textColor = [self RGBHaveSpaceString:@"51 51 51"];
    [bottonView addSubview:lable2];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-18);
        make.centerY.mas_equalTo(bottonView.mas_centerY);
    }];
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"deleacar"];
    [bottonView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.mas_equalTo(bottonView.mas_centerY);
        make.right.mas_equalTo(lable2.mas_left).mas_offset(-9);
    }];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottonView addSubview:clearBtn];
    [clearBtn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left);
        make.right.mas_equalTo(lable2.mas_right);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(bottonView.mas_centerY);
    }];
    return bottonView;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCarcell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCarcell" forIndexPath:indexPath];
    
    cell.model = _dataArr[indexPath.row];
    return cell;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}


@end
