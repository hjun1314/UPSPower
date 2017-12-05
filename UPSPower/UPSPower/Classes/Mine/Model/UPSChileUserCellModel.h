//
//  UPSChileUserCellModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPSChileUserCellModel : NSObject
//@property (nonatomic,strong)NSArray *nameAndPassword;
//+ (id)UPSChileUserCellModel:(NSArray *)UPSChildUserModelData;

///存账号
+ (void)saveName:(NSString *)Name;
///取账号
+ (NSString *)getName;

///存密码
+ (void)savePassword:(NSString *)password;
///取密码
+ (NSString *)getPassWord;


///  从沙盒中加载用户账号密码
+ (void)loadUserSetting;
///  保存账号密码到沙盒中
+ (void)saveUserSetting;

@end
