//
//  UPSBaseInfoView.m
//  UPSPower
//
//  Created by hjun on 2018/1/26.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSBaseInfoView.h"
#define upsBaseFont [UIFont systemFontOfSize:15.0]
@implementation UPSBaseInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 15;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kScreenW *0.7, 20)];
    titleLabel.text = @"UPS基本信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]init];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.height.mas_offset(0.5);
    }];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.6;
    
    ///UPS型号
    UILabel *upsModel = [[UILabel alloc]init];
    [self addSubview:upsModel];
    [upsModel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(kScreenW *0.1);
        make.top.mas_equalTo(lineView.mas_bottom).mas_offset(8);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
    }];
    upsModel.text = @"UPS型号: ";
//    upsModel.backgroundColor = [UIColor yellowColor];
    upsModel.textAlignment = NSTextAlignmentRight;
    upsModel.font = upsBaseFont;
    
    self.upsModel_ = [[UILabel alloc]init];
    [self addSubview:self.upsModel_];
    [self.upsModel_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).mas_offset(-kScreenW *0.1);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
        make.top.mas_equalTo(lineView.mas_bottom).mas_offset(8);
        
    }];
//    self.upsModel_.backgroundColor = [UIColor orangeColor];
//    self.upsModel_.text = @" 33333";
    self.upsModel_.textAlignment = NSTextAlignmentLeft;
    self.upsModel_.font = upsBaseFont;
    ///UPS版本号
    UILabel *version = [[UILabel alloc]init];
    [self addSubview:version];
    [version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(kScreenW *0.1);
        make.top.mas_equalTo(upsModel.mas_bottom).mas_offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
    }];
//    version.backgroundColor = [UIColor blueColor];
    version.text = @"UPS版本号: ";
    version.textAlignment = NSTextAlignmentRight;
    version.font = upsBaseFont;
    
    self.version_ = [[UILabel alloc]init];
    [self addSubview:self.version_];
    [self.version_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).mas_offset(-kScreenW *0.1);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
        make.top.mas_equalTo(self.upsModel_.mas_bottom).mas_offset(5);
    }];
//    self.version_.backgroundColor = [UIColor redColor];
    self.version_.textAlignment = NSTextAlignmentLeft;
    self.version_.font = upsBaseFont;
    ///容量
    UILabel *capability = [[UILabel alloc]init];
    [self addSubview:capability];
    [capability mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(kScreenW *0.1);
        make.top.mas_equalTo(version.mas_bottom).mas_offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
    }];
//    capability.backgroundColor = [UIColor orangeColor];
    capability.text = @"容量: ";
    capability.textAlignment = NSTextAlignmentRight;
    capability.font = upsBaseFont;
    
    self.capability_ = [[UILabel alloc]init];
    [self addSubview:self.capability_];
    [self.capability_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).mas_offset(-kScreenW *0.1);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
        make.top.mas_equalTo(self.version_.mas_bottom).mas_offset(5);
    }];
//    self.capability_.backgroundColor = [UIColor redColor];
    self.capability_.textAlignment = NSTextAlignmentLeft;
    self.capability_.font = upsBaseFont;
    
    ///输出功率
    UILabel *configOutputPower = [[UILabel alloc]init];
    [self addSubview:configOutputPower];
    [configOutputPower mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(kScreenW *0.1);
        make.top.mas_equalTo(capability.mas_bottom).mas_offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
        
    }];
//    configOutputPower.backgroundColor = [UIColor orangeColor];
    configOutputPower.text = @"输入功率: ";
    configOutputPower.textAlignment = NSTextAlignmentRight;
    configOutputPower.font = upsBaseFont;
    
    self.configOutputPower_ = [[UILabel alloc]init];
    [self addSubview:self.configOutputPower_];
    [self.configOutputPower_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).mas_offset(-kScreenW *0.1);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
        make.top.mas_equalTo(self.capability_.mas_bottom).mas_offset(5);
    }];
//    self.configOutputPower_.backgroundColor = [UIColor redColor];
    self.configOutputPower_.textAlignment = NSTextAlignmentLeft;
    self.configOutputPower_.font = upsBaseFont;
    ///输入电压
    UILabel *configInputVolt = [[UILabel alloc]init];
    [self addSubview:configInputVolt];
    [configInputVolt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(kScreenW *0.1);
        make.top.mas_equalTo(configOutputPower.mas_bottom).mas_offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
    }];
//    configInputVolt.backgroundColor = [UIColor orangeColor];
    configInputVolt.text = @"输入电压: ";
    configInputVolt.textAlignment = NSTextAlignmentRight;
    configInputVolt.font = upsBaseFont;
    
    self.configInputVolt_ = [[UILabel alloc]init];
    [self addSubview:self.configInputVolt_];
    [self.configInputVolt_  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).mas_offset(-kScreenW *0.1);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
        make.top.mas_equalTo(self.configOutputPower_.mas_bottom).mas_offset(5);
    }];
//    self.configInputVolt_.backgroundColor = [UIColor redColor];
    self.configInputVolt_.textAlignment = NSTextAlignmentLeft;
    self.configInputVolt_.font = upsBaseFont;
    
    ///输出电压
    UILabel *configOutputVolt = [[UILabel alloc]init];
    [self addSubview:configOutputVolt];
    [configOutputVolt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(kScreenW *0.1);
        make.top.mas_equalTo(configInputVolt.mas_bottom).mas_offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
    }];
//    configOutputVolt.backgroundColor = [UIColor orangeColor];
    configOutputVolt.text = @"输出电压: ";
    configOutputVolt.textAlignment = NSTextAlignmentRight;
    configOutputVolt.font = upsBaseFont;
    
    self.configOutputVolt_ = [[UILabel alloc]init];
    [self addSubview: self.configOutputVolt_ ];
    [ self.configOutputVolt_  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).mas_offset(-kScreenW *0.1);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
        make.top.mas_equalTo(self.configInputVolt_.mas_bottom).mas_offset(5);
    }];
//    self.configOutputVolt_.backgroundColor = [UIColor redColor];
    self.configOutputVolt_.font = upsBaseFont;
    self.configOutputVolt_.textAlignment = NSTextAlignmentLeft;
    
    ///输入频率
    UILabel *configInputFreq = [[UILabel alloc]init];
    [self addSubview:configInputFreq];
    [configInputFreq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(kScreenW *0.1);
        make.top.mas_equalTo(configOutputVolt.mas_bottom).mas_offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
    }];
//    configInputFreq.backgroundColor = [UIColor orangeColor];
    configInputFreq.text = @"输入频率: ";
    configInputFreq.textAlignment = NSTextAlignmentRight;
    configInputFreq.font = upsBaseFont;
    
    self.configInputFreq_ = [[UILabel alloc]init];
    [self addSubview:self.configInputFreq_];
    [self.configInputFreq_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).mas_offset(-kScreenW *0.1);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
        make.top.mas_equalTo(self.configOutputVolt_.mas_bottom).mas_offset(5);
    }];
//    self.configInputFreq_.backgroundColor = [UIColor redColor];
    self.configInputFreq_.textAlignment = NSTextAlignmentLeft;
    self.configInputFreq_.font = upsBaseFont;
    ///输出频率
    UILabel *configOutputFreq = [[UILabel alloc]init];
    [self addSubview:configOutputFreq];
    [configOutputFreq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).mas_offset(kScreenW *0.1);
        make.top.mas_equalTo(configInputFreq.mas_bottom).mas_offset(5);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
    }];
//    configOutputFreq.backgroundColor = [UIColor orangeColor];
    configOutputFreq.text = @"输出频率: ";
    configOutputFreq.textAlignment = NSTextAlignmentRight;
    configOutputFreq.font = upsBaseFont;
    
    self.configOutputFreq_ = [[UILabel alloc]init];
    [self addSubview:self.configOutputFreq_ ];
    [self.configOutputFreq_  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).mas_offset(-kScreenW *0.1);
        make.height.mas_offset(15);
        make.width.mas_offset(kScreenW * 0.25);
        make.top.mas_equalTo(self.configInputFreq_.mas_bottom).mas_offset(5);
    }];
//    self.configOutputFreq_.backgroundColor = [UIColor redColor];
    self.configOutputFreq_.textAlignment = NSTextAlignmentLeft;
    self.configOutputFreq_.font = upsBaseFont;
}

@end
