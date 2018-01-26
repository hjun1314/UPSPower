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
@interface UPSBaseInfoVC ()

@end

@implementation UPSBaseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setUI];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)setNav{
    self.navigationItem.title = @"设备详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"基础信息" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightItem)];
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
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 20, kScreenW, kScreenH * 0.3)];
    imageView.image = [UIImage imageNamed:@"0-1-正常工作状态"];
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
