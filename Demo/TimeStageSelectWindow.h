//
//  TimeStageSelectWindow.h
//  HDAPP
//
//  Created by ataw on 16/11/2.
//  Copyright © 2016年 王宗成. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol timeSelectProtocol <NSObject>

-(void)selectTime:(NSDictionary *)dic;

@end
@interface TimeStageSelectWindow : UIWindow<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)NSArray *timeStageArr;
@property(nonatomic,strong)NSMutableArray *dateArr;
@property(nonatomic,weak)id<timeSelectProtocol>delegate;
+(TimeStageSelectWindow *)defaultStageSelectWindow;
-(void)showTimeStageWindow;
@end
