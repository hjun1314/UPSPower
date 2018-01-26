//
//  UPSBaseInfoView.h
//  UPSPower
//
//  Created by hjun on 2018/1/26.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPSBaseInfoView : UIView
///型号
@property (nonatomic,strong)UILabel *upsModel_;
@property (nonatomic,strong)UILabel *version_;
@property (nonatomic,strong)UILabel *capability_;
@property (nonatomic,strong)UILabel *configOutputPower_;
@property (nonatomic,strong)UILabel *configInputVolt_;
@property (nonatomic,strong)UILabel *configOutputVolt_;
@property (nonatomic,strong)UILabel *configInputFreq_;
@property (nonatomic,strong)UILabel *configOutputFreq_;





@end
