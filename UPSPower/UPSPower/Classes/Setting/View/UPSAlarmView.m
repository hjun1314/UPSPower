//
//  UPSAlarmView.m
//  UPSPower
//
//  Created by hjun on 2018/1/2.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSAlarmView.h"

@implementation UPSAlarmView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
    }
    return self;
}
- (void)setup{
    UILabel *alarm = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 30)];
    alarm.text = @"告警编码:";
    [self addSubview:alarm];
    
    self.alarmLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 120, 30)];
//    codeLabel.text = @"11111";
    [self addSubview:self.alarmLabel];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 80, 30)];
    name.text = @"告警名称:";
    [self addSubview:name];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 45, 120, 30)];
//    nameLabel.text = @"aaaaa";
    [self addSubview:self.nameLabel];
    
    UILabel *happen = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 80, 30)];
    happen.text = @"发生时间:";
    [self addSubview:happen];
    
   self.happenLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 80,  120, 30)];
//    happenLabel.text = @"12:50";
    [self addSubview:self.happenLabel];
    
    UILabel *remove = [[UILabel alloc]initWithFrame:CGRectMake(10, 115, 80, 30)];
    remove.text = @"解除时间:";
    [self addSubview:remove];
    
  self.removeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 115,120, 30)];
//    removeLabel.text = @"12:33";
    [self addSubview:self.removeLabel];
    
}


@end
