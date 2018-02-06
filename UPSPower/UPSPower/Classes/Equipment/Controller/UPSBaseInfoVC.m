//
//  UPSBaseInfoVC.m
//  UPSPower
//
//  Created by hjun on 2017/12/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSBaseInfoVC.h"
#import "UPSBaseInfoView.h"
#import "GKCover.h"
#import "UPSBaseInfoModel.h"
#import "UPSGroupUPSModel.h"
#import "UPSBaseInfoBtn.h"
#import "UPSPower.h"
@interface UPSBaseInfoVC ()
@property (nonatomic,strong)UITextView *textView;

@end

@implementation UPSBaseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setUI];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)setNav{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"基础信息" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
    for (UPSGroupUPSModel *model in self.upsDataArr) {
        self.navigationItem.title = model.userDefinedUpsName;

    }
    for (int i = 0; i < self.upsDataArr.count; i++) {
        UPSGroupUPSModel *model = [[UPSGroupUPSModel alloc]init];
        self.navigationItem.title = model.userDefinedUpsName;
    }
}
- (void)clickRightItem{
    UPSBaseInfoView *info = [[UPSBaseInfoView alloc]init];
    info.gk_size = CGSizeMake(kScreenW *0.7, 215);
    
    [GKCover translucentWindowCenterCoverContent:info animated:YES];
    for (UPSBaseInfoModel *model in self.baseModerArr) {
        info.upsModel_.text = model.upsModel;
        info.version_.text = model.version;
        info.capability_.text = [NSString stringWithFormat:@"%d",model.capability];
        info.configOutputPower_.text = [NSString stringWithFormat:@"%d",model.configOutputPower];
        info.configInputVolt_.text = [NSString stringWithFormat:@"%d",model.configInputVolt];
        info.configOutputVolt_.text = [NSString stringWithFormat:@"%d",model.configOutputVolt];
        info.configInputFreq_.text = [NSString stringWithFormat:@"%d",model.configInputFreq];
        info.configOutputFreq_.text = [NSString stringWithFormat:@"%d",model.configOutputFreq];
        
    }
}
- (void)setUI{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 40, kScreenW, kScreenH * 0.3)];
    imageView.image = [UIImage imageNamed:@"a2_3"];
    [self.view addSubview:imageView];
//    imageView.backgroundColor = [UIColor redColor];
    UPSBaseInfoBtn *imputBtn = [[UPSBaseInfoBtn alloc]initWithFrame:CGRectMake(5, SafeAreaTopHeight + 5, KScreenW / 5, 30)];
   [imputBtn setBackgroundColor:UICOLOR_RGB(55.0, 157.0, 246.0, 1)];
    [imputBtn setTitle:@"旁路输入" forState:UIControlStateNormal];
   [self.view addSubview:imputBtn];
    
    UPSBaseInfoBtn *faultBtn = [[UPSBaseInfoBtn alloc]initWithFrame:CGRectMake(KScreenW - KScreenW /5 - 5, SafeAreaTopHeight + 5, KScreenW / 5, 30)];
    [self.view addSubview:faultBtn];
    [faultBtn setTitle:@"异常信息" forState:UIControlStateNormal];
    [faultBtn setBackgroundColor:[UIColor redColor]];
    
    ///交流输入
    UPSBaseInfoBtn *ACinputBtn = [[UPSBaseInfoBtn alloc]init];
    [self.view addSubview:ACinputBtn];
    [ACinputBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(5);
        make.width.mas_offset(KScreenW / 5);
        make.height.mas_offset(30);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(-44);
    }];
    [ACinputBtn setBackgroundColor:UICOLOR_RGB(55.0, 157.0, 246.0, 1)];
    [ACinputBtn setTitle:@"交流输入" forState:UIControlStateNormal];
    
    UPSBaseInfoBtn *ACoutputBtn = [[UPSBaseInfoBtn alloc]init];
    [self.view addSubview:ACoutputBtn];
    [ACoutputBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view).offset(-5);
        make.width.mas_offset(KScreenW / 5);
        make.height.mas_offset(30);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(-44);
    }];
    [ACoutputBtn setTitle:@"交流输出" forState:UIControlStateNormal];
    [ACoutputBtn setBackgroundColor:UICOLOR_RGB(55.0, 157.0, 246.0, 1)];
    
    UPSBaseInfoBtn *batteryBtn = [[UPSBaseInfoBtn alloc]init];
    [self.view addSubview:batteryBtn];
    [batteryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(imageView);
        make.width.mas_offset(KScreenW / 5);
        make.height.mas_offset(30);
    }];
    [batteryBtn setTitle:@"电池" forState:UIControlStateNormal];
    [batteryBtn setBackgroundColor:UICOLOR_RGB(55.0, 157.0, 246.0, 1)];
    [batteryBtn addTarget:self action:@selector(clickBatteryBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)clickBatteryBtn:(UIButton *)btn{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, KScreenH * 0.5, KScreenW, KScreenH - KScreenH * 0.5)];
    [self.view addSubview:textView];
    self.textView = textView;
   textView.backgroundColor = [UIColor redColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
