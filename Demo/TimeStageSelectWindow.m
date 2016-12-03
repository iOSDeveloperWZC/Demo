//
//  TimeStageSelectWindow.m
//  HDAPP
//
//  Created by ataw on 16/11/2.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import "TimeStageSelectWindow.h"

static TimeStageSelectWindow *winds = nil;
@implementation TimeStageSelectWindow
{
    UIPickerView *picker;
    NSMutableDictionary *mutableDic;
    NSInteger selectRow;
    NSInteger rowCount;
    NSInteger secondRow;
}
+(TimeStageSelectWindow *)defaultStageSelectWindow
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        winds = [[TimeStageSelectWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        winds.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    });
    winds.hidden = YES;
    winds.windowLevel = UIWindowLevelNormal;
    return winds;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        secondRow = 0;
        rowCount = 0;
        selectRow = 0;
        _dateArr = [NSMutableArray array];
        _timeStageArr = @[@"08:00-09:00",@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"12:00-13:00",@"13:00-14:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00"];
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, 260));
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        topView.backgroundColor = [self RGBHaveSpaceString:@"246 246 246"];
        [bottomView addSubview:topView];
        
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(20, 0, 60, 40);
        [btn1 setTitle:@"取消" forState:UIControlStateNormal];
        [topView addSubview:btn1];
        [btn1 addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = 110;
        
        [btn1 setTitleColor:[UIColor colorWithRed:0 green:134.0/255 blue:207.0/255 alpha:1] forState:UIControlStateNormal];
        
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(kScreenWidth - 60 - 20, 0, 60, 40);
        [btn2 setTitle:@"完成" forState:UIControlStateNormal];
        [topView addSubview:btn2];
        [btn2 setTitleColor:[UIColor colorWithRed:0 green:134.0/255 blue:207.0/255 alpha:1] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = 120;
        
        UILabel *alertLble = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame), 0, CGRectGetMinX(btn2.frame)-CGRectGetMaxX(btn1.frame), 40)];
        alertLble.text = @"选择上门时间";
        alertLble.font = Font(17);
        alertLble.textAlignment = NSTextAlignmentCenter;
        [topView addSubview:alertLble];
        
        
        picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 216)];
        picker.delegate = self;
        picker.dataSource = self;
        picker.showsSelectionIndicator = YES;
        picker.backgroundColor = [UIColor whiteColor];
        [bottomView addSubview:picker];
    }
    
    return self;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return kScreenWidth/2;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        
        return _dateArr.count;
    }
    return rowCount;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        return  _dateArr[row];
    }
    
    NSArray *arrayt = mutableDic[_dateArr[selectRow]];
    return arrayt[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        NSArray *tem = mutableDic[_dateArr[row]];
        selectRow = row;
        rowCount = tem.count;
        //让选择之后 第二列每次都回到第一行
        secondRow = 0;
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
    }
    secondRow = row;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 
    self.hidden = YES;
}

-(void)BtnAction:(UIButton *)button
{
    
    self.hidden = YES;
    
    if (button.tag == 110) {
        
        return;
    }
    
    NSArray *keys = _dateArr;
    
    NSString *mon = keys[selectRow];
    
    NSArray *valeus = [mutableDic objectForKey:mon];
    NSString *h = valeus[secondRow];
    NSString *string = [NSString stringWithFormat:@"%@ %@",mon,h];
    NSDictionary *dic = @{@"time":string};
    
    [_delegate selectTime:dic];

}

-(void)showTimeStageWindow
{
    
    selectRow = 0;
    secondRow = 0;
    winds.hidden = NO;
    [_dateArr removeAllObjects];
     NSMutableArray *secondArr = [NSMutableArray array];
    //半个月 key
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"MM月dd日";
    
    NSString *currentHours = [NSDate fetchYearMonthDayStrAccording:Hours];
    
    if ([currentHours integerValue] < 8 ) {
        //没到上班时间 可全选
        rowCount =_timeStageArr.count;
        [_dateArr addObject:@"今天"];
        [secondArr addObject:_timeStageArr];
    }//不是上班时间
    else if([currentHours integerValue] >= 17)
    {
        
        rowCount = _timeStageArr.count;
    }
    else
    {
        NSArray *firstArr = [_timeStageArr subarrayWithRange:NSMakeRange([currentHours integerValue] - 8, _timeStageArr.count - [currentHours integerValue]+8)];
        rowCount = firstArr.count;
        [_dateArr addObject:@"今天"];
        [secondArr addObject:firstArr];
    }
    
    for (int i = 1; i < 15; i++) {
        
        NSDate *nextDate = [NSDate dateWithTimeIntervalSinceNow:+i*24*60*60];
        NSString *s = [format stringFromDate:nextDate];
        
        [_dateArr addObject:s];
        [secondArr addObject:_timeStageArr];
    }

    mutableDic = [NSMutableDictionary dictionaryWithObjects:secondArr forKeys:_dateArr];
    
    [picker reloadAllComponents];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
