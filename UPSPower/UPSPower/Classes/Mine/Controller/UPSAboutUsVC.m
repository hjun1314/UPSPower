//
//  UPSAboutUsVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/24.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSAboutUsVC.h"

@interface UPSAboutUsVC ()

@end

@implementation UPSAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setup];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)setNav{
    
    self.navigationItem.title = @"关于我们";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
   
}
- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setup{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SafeAreaTopHeight + 30);
        make.height.offset(100);
        make.width.offset(90);
        make.centerX.equalTo(self.view);
        
    }];
    imageView.image = [UIImage imageNamed:@"Logo"];
    
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.centerX.equalTo(imageView);
        
    }];
    label.text = @"V1.0";
    label.font = [UIFont systemFontOfSize:17];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    [self.view addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.centerX.equalTo(imageView);
        make.trailing.offset(-15).equalTo(self.view);
        make.leading.offset(15).equalTo(self.view);
    }];
    contentLabel.text = @"本程序受著作权法和国际法公约的保护，未经授权擅自复制或散步本程序的部分或全部，将受严厉的民事和刑事处罚，对已知的违反者，将给予法律范围内的全部制裁！";
    
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:16];
    
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    [self.view addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
        make.centerX.equalTo(self.view);
    }];
    bottomLabel.text = @"昌菱电气  版权所有";
    bottomLabel.font = [UIFont fontWithName:@"Arial"size:24];
    
    
    UILabel *copyRightLabel = [[UILabel alloc]init];
    [self.view addSubview:copyRightLabel];
    [copyRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        
    }];
    copyRightLabel.text = @"Copyright©2017 Shoryo All Rights Reserved";
    copyRightLabel.font = [UIFont systemFontOfSize:16];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
