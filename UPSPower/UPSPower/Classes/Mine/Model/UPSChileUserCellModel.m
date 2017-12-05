//
//  UPSChileUserCellModel.m
//  UPSPower
//
//  Created by hjun on 2017/12/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSChileUserCellModel.h"
#define NameLabel @"namelabel"
#define PasswordLabel  @"passWord"
@implementation UPSChileUserCellModel


///存账号
+ (void)saveName:(NSString *)Name{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:Name forKey:NameLabel];
    [defaults synchronize];
}
///取账号
+ (NSString *)getName{
    return [[NSUserDefaults standardUserDefaults]objectForKey:NameLabel];
}

///存密码
+ (void)savePassword:(NSString *)password{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:password forKey:PasswordLabel];
    [defaults synchronize];
}
///取密码
+ (NSString *)getPassWord{
    return [[NSUserDefaults standardUserDefaults]objectForKey:PasswordLabel];
}


///  从沙盒中加载用户账号密码
+ (void)loadUserSetting{
    [NSKeyedUnarchiver unarchiveObjectWithFile:API_UserFilePath];
}

///  保存账号密码到沙盒中
+ (void)saveUserSetting{
//    [NSKeyedArchiver archiveRootObject:[UPSLoginModel sharedUPSLoginModel] toFile:API_UserFilePath];
}

@end
