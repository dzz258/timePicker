//
//  DZSelectorView.m
//  时间选择器
//
//  Created by 代纵纵 on 16/1/20.
//  Copyright (c) 2016年 daizongzong. All rights reserved.
//

#import "DZSelectorView.h"
#define SCREENHEIGHT    [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH     [UIScreen mainScreen].bounds.size.width

@interface DZSelectorView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,retain)UIPickerView *pickerview;
@property (nonatomic,retain)NSMutableArray *firstData,*secondData,*thirdData;
@property (nonatomic,retain)NSMutableArray *nowHourArray,*nowMinuteArray;;
@property (nonatomic,retain)NSString *firstStr,*secondStr,*thirdStr;
@property (nonatomic,assign)NSInteger hour,minute;

@property (nonatomic,retain) UIToolbar *actionToolbar;

@end

@implementation DZSelectorView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        
        self.pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0,44, SCREENWIDTH, 216)];
        //    指定Delegate
        self.pickerview.delegate=self;
        self.pickerview.dataSource=self;
        //    显示选中框
        self.pickerview.showsSelectionIndicator=YES;
        [self addSubview:self.pickerview];
        
        self.firstStr=[NSString new];
        self.secondStr=[NSString new];
        self.thirdStr=[NSString new];
        
        [self dangqiandata];
        
        self.firstData=[[NSMutableArray alloc]initWithObjects:@"今天",@"明天",@"后天", nil];
        self.secondData=[NSMutableArray new];
        self.thirdData=[[NSMutableArray alloc]init];

        if (self.nowHourArray.count==0) {
            [self.secondData addObject:@"现在"];
            self.firstStr=@"";
            self.secondStr=@"现在";
        }else{
            self.secondData=self.nowHourArray;
            self.firstStr=@"";
            self.secondStr=@"现在";
        }
        
        self.actionToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
        [self.actionToolbar sizeToFit];
        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithTitle:@"  取消" style:UIBarButtonItemStylePlain target:self action:@selector(pickerCancelClicked:)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"确定  " style:UIBarButtonItemStylePlain target:self action:@selector(pickerDoneClicked:)];
        [self.actionToolbar setItems:[NSArray arrayWithObjects:cancelButton,flexSpace,doneBtn, nil] animated:YES];
        [self addSubview:self.pickerview];
        [self addSubview:self.actionToolbar];
    }
    return self;
}
-(void)dangqiandata{
    NSDateComponents *dateComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    self.hour = [dateComponent hour];
    self.minute = [dateComponent minute];
    self.nowHourArray=[NSMutableArray new];
    self.nowMinuteArray=[NSMutableArray new];
//    self.hour = 23;
//    self.minute = 55;
    if (self.minute+20<=50) {
        for (NSInteger i=self.hour; i<24; i++) {
            if (i==self.hour) {
                [self.nowHourArray addObject:@"现在"];
            }
            [self.nowHourArray addObject:[NSString stringWithFormat:@"%ld点",(long)i]];
        }
        for (NSInteger i=(self.minute+25)/10; i<6; i++) {
            [self.nowMinuteArray addObject:[NSString stringWithFormat:@"%ld0分",(long)i]];
        }
    }else{
        for (NSInteger i=self.hour+1; i<24; i++) {
            if (i==self.hour+1) {
                [self.nowHourArray addObject:@"现在"];
            }
            [self.nowHourArray addObject:[NSString stringWithFormat:@"%ld点",(long)i]];
        }
        
        for (NSInteger i=(self.minute+25-60)/10; i<6; i++) {
            [self.nowMinuteArray addObject:[NSString stringWithFormat:@"%ld0分",(long)i]];
        }
        
    }
}
-(void)pickerCancelClicked:(UIBarButtonItem*)barButton{
    [UIView animateWithDuration:0.5 animations:^{
        //480 是屏幕尺寸
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 260);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)pickerDoneClicked:(UIBarButtonItem*)barButton{
    NSLog(@"获取信息%@==%@==%@",self.firstStr,self.secondStr,self.thirdStr);
    [UIView animateWithDuration:0.5 animations:^{
        //480 是屏幕尺寸
        self.frame=CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, 260);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return [self.firstData count];
    }else if (component==1){
        return [self.secondData count];
    }else{
        return [self.thirdData count];
    }
    
}
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [self.firstData objectAtIndex:row];
    }else if (component==1){
        return [self.secondData objectAtIndex:row];
    }else{
        return [self.thirdData objectAtIndex:row];
    }
}
-(void)pickerView:(UIPickerView *)pickerViewt didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.firstStr =[self.firstData objectAtIndex:row];
        self.secondData=[NSMutableArray new];
        self.thirdData=[NSMutableArray new];
        if(row==0){
            if (self.nowHourArray.count==0) {
                [self.secondData addObject:@"现在"];
            }else{
                self.secondData=self.nowHourArray;
            }
            NSInteger eee;
            NSInteger fff;
            if ([self.secondStr isEqualToString:@"现在"]) {
            }else{
                if ([self.secondStr isEqualToString:@"现在"]) {
                    eee=self.hour;
                }else{
                    eee=[[self.secondStr substringToIndex:self.secondStr.length-1] integerValue];
                }
                if ([[self.secondData objectAtIndex:0]isEqualToString:@"现在"]) {
                    fff=self.hour;
                }else{
                    fff=[[[self.secondData objectAtIndex:0] substringToIndex:((NSString *)[self.secondData objectAtIndex:0]).length-1] integerValue];
                }
                
                if (eee<fff) {
                }else{
                        if ([_secondStr isEqualToString:[self.secondData objectAtIndex:0]]) {
                            self.thirdData=self.nowMinuteArray;
                        }else{
                            if (self.hour==[[self.secondStr substringToIndex:self.secondStr.length-1] integerValue]) {
                                self.thirdData=self.nowMinuteArray;
                            }else{
                            if (self.minute+20>50) {
                                self.thirdData=self.nowMinuteArray;
                            }else{
                            for (int i=0; i<6; i++) {
                                [self.thirdData addObject:[NSString stringWithFormat:@"%d0分",i]];
                            }
                            }
                        }
                }
            }
            }
        }else{
            for (int i=0; i<24; i++) {
                [self.secondData addObject:[NSString stringWithFormat:@"%d点",i]];
            }
            if (row==1&&self.hour==23&&self.minute+20>50){
                self.thirdData=self.nowMinuteArray;
            }else{
                for (int i=0; i<6; i++) {
                    [self.thirdData addObject:[NSString stringWithFormat:@"%d0分",i]];
                }
            }
        }
        NSInteger aaa;
        NSInteger bbb;
        [self.pickerview reloadComponent:1];
        if ([self.secondStr isEqualToString:@"现在"]) {
            [self.pickerview selectRow:0 inComponent:1 animated:NO];
        }else{
        if ([self.secondStr isEqualToString:@"现在"]) {
            aaa=self.hour;
        }else{
            aaa=[[self.secondStr substringToIndex:self.secondStr.length-1] integerValue];
        }
        if ([[self.secondData objectAtIndex:0]isEqualToString:@"现在"]) {
            bbb=self.hour;
        }else{
           bbb=[[[self.secondData objectAtIndex:0] substringToIndex:((NSString *)[self.secondData objectAtIndex:0]).length-1] integerValue];
        }
        if (aaa<bbb) {
            [self.pickerview selectRow:0 inComponent:1 animated:NO];
        }else{
            for (int i=0; i<[self.secondData count]; i++) {
                if ([self.secondStr isEqualToString:[self.secondData objectAtIndex:i]]) {
                    [self.pickerview selectRow:i inComponent:1 animated:NO];
                }
            }
        }
        }
        
        NSInteger ccc;
        NSInteger ddd;
        [self.pickerview reloadComponent:2];
        if (self.thirdStr.length==0) {
            [self.pickerview selectRow:0 inComponent:2 animated:NO];
        }else{
            ccc=[[self.thirdStr substringToIndex:self.thirdStr.length-2] integerValue];
            if (self.thirdData.count==0) {
                [self.pickerview selectRow:0 inComponent:2 animated:NO];
            }else{
                ddd=[[[self.thirdData objectAtIndex:0] substringToIndex:((NSString *)[self.thirdData objectAtIndex:0]).length-2] integerValue];
                if (ccc<ddd) {
                    [self.pickerview selectRow:0 inComponent:2 animated:NO];
                }else{
                    for (int i=0; i<[self.thirdData count]; i++) {
                        if ([self.thirdStr isEqualToString:[self.thirdData objectAtIndex:i]]) {
                            [self.pickerview selectRow:i inComponent:2 animated:NO];
                        }
                    }
                }
            }
        }
        if ([self.secondData count]==0) {
            self.secondStr=@"";
        }else{
            self.secondStr=self.secondStr;
        }
        if ([self.thirdData count]==0) {
            self.thirdStr=@"";
        }else{
            self.thirdStr=self.thirdStr;
        }
    }
    if (component==1) {
        self.secondStr=[self.secondData objectAtIndex:row];
        self.thirdData=[NSMutableArray new];
        if ([[self.secondData objectAtIndex:0] isEqualToString:@"现在"]) {
            if ([self.secondStr isEqualToString:@"现在"]) {
            }else{
                if ([self.secondStr isEqualToString:[self.secondData objectAtIndex:1]]) {
                    self.thirdData=self.nowMinuteArray;
                }else{
                    for (int i=0; i<6; i++) {
                        [self.thirdData addObject:[NSString stringWithFormat:@"%d0分",i]];
                    }
                }
            }
        }else{
            if ([self.firstStr isEqualToString:@"明天"]&&row==0&&self.hour==23&&self.minute+20>50) {
                    self.thirdData=self.nowMinuteArray;
            }else{
                for (int i=0; i<6; i++) {
                    [self.thirdData addObject:[NSString stringWithFormat:@"%d0分",i]];
                }
            }
        }
        
        NSInteger hhh;
        NSInteger ggg;
        [self.pickerview reloadComponent:2];
        NSLog(@"%@",self.thirdStr);
        if (self.thirdStr.length==0) {
            [self.pickerview selectRow:0 inComponent:2 animated:NO];
        }else{
            hhh=[[self.thirdStr substringToIndex:self.thirdStr.length-2] integerValue];
            if (self.thirdData.count==0) {
                [self.pickerview selectRow:0 inComponent:2 animated:YES];
            }else{
                ggg=[[[self.thirdData objectAtIndex:0] substringToIndex:((NSString *)[self.thirdData objectAtIndex:0]).length-2] integerValue];
                if (hhh<ggg) {
                    [self.pickerview selectRow:0 inComponent:2 animated:NO];
                }else{
                    for (int i=0; i<[self.thirdData count]; i++) {
                        if ([self.thirdStr isEqualToString:[self.thirdData objectAtIndex:i]]) {
                            [self.pickerview selectRow:i inComponent:2 animated:NO];
                        }
                    }
                }
            }
        }
        
        if ([self.thirdData count]==0) {
            self.thirdStr=@"";
        }else{
            self.thirdStr=self.thirdStr;;
        }
    }if (component==2) {
        if ([self.thirdData count]==0) {
            self.thirdStr=@"";
        }else{
            self.thirdStr =[self.thirdData objectAtIndex:row];
        }
    }
}
//设置滚轮的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return 100;
    }else if(component==1){
        return 100;
    }else{
        return 100;
    }
}

@end
