//
//  UPSTool.m
//  UPSPower
//
//  Created by hjun on 2017/12/6.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSTool.h"
#define Access_token @"token"
#define Access_ID @"ID"

@implementation UPSTool
// 存储token
+(void)saveToken:(NSString *)token
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    // NSData *tokenData = [NSKeyedArchiver archivedDataWithRootObject:token];
    [userDefaults setObject:token forKey:Access_token];
    [userDefaults synchronize];
}

// 取token
+(NSString *)getToken
{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:Access_token];
    
}
///存id
+(void)saveID:(NSInteger)ID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:ID forKey:Access_ID];
    [userDefaults synchronize];
    
}
///取id
+(NSInteger)getID{
    return [[NSUserDefaults standardUserDefaults]integerForKey:Access_ID];
}

@end
