//
//  UPSBaseInfoModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
///显示UPS基础信息模型
@interface UPSBaseInfoModel : NSObject
/*
 upsModel    ups型号    String        YES
 version    ups版本号    String        YES
 capability    容量    int        YES
 configOutputPower    输出功率    int        YES
 configInputVolt    输入电压    int        YES
 configOutputVolt    输出电压    int        YES
 configInputFreq    输入频率    int        YES
 configOutputFreq    输出频率    int        YES
*/

@property (nonatomic,copy)NSString *upsModel;
@property (nonatomic,copy)NSString *version;
@property (nonatomic,assign)int capability;
@property (nonatomic,assign)int configOutputPower;
@property (nonatomic,assign)int configInputVolt;
@property (nonatomic,assign)int configOutputVolt;
@property (nonatomic,assign)int configInputFreq;
@property (nonatomic,assign)int configOutputFreq;








@end
