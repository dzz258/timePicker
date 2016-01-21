//
//  ViewController.m
//  时间选择器
//
//  Created by 代纵纵 on 16/1/20.
//  Copyright (c) 2016年 daizongzong. All rights reserved.
//

#import "ViewController.h"
#import "DZSelectorView.h"
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@end

@implementation ViewController
{
    DZSelectorView *_tsvc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnClick:(UIButton *)sender {
        [_tsvc removeFromSuperview];
        _tsvc=[[DZSelectorView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 260)];
        [self.view addSubview:_tsvc];
        [UIView animateWithDuration:0.5 animations:^{
            _tsvc.frame=CGRectMake(0, SCREEN_HEIGHT-260, SCREEN_WIDTH, 260);
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
