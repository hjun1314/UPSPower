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
#define Access_CID @"CID"
#define Access_userName @"userName"
#define Access_password @"password"
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

///存个推CID
+ (void)saveGeTuiCid:(NSString *)cid{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:cid forKey:Access_CID];
    [userDefaults synchronize];
}
///取cid
+ (NSString *)getGeTuiCid{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:Access_CID];
    
}

+ (void)saveUserName:(NSString *)username{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:username forKey:Access_userName];
    [userDefaults synchronize];
}
+ (NSString *)getUserName{
    return [[NSUserDefaults standardUserDefaults]objectForKey:Access_userName];
    
}

///存密码
+ (void)savePassWord:(NSString *)password{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:password forKey:Access_password];
    [defaults synchronize];
}
+ (NSString *)getPassword{
    return [[NSUserDefaults standardUserDefaults]objectForKey:Access_password];
}


+ (NSString *)strwithInteger:(long)interger
{
    NSDate* date = [[NSDate alloc] initWithTimeIntervalSince1970:interger];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *string = [formatter stringFromDate:date];
    
    
    //
    //    NSTimeInterval spaceTime = [date timeIntervalSinceDate:date];
    //    int second = (int)spaceTime;
    //    int minute = second / 60;
    //    int hour = minute / 60;
    //    if (minute < 1) {
    //        string = @"刚刚";
    //    }else if (hour < 1 && minute >= 1) {
    //       string = [NSString stringWithFormat:@"%d分钟前",minute];
    //    }else if (hour >= 1 && hour < 24) {
    //        string = [NSString stringWithFormat:@"%d小时前",hour];
    //    }else if (hour >= 24 && hour < 10 * 24) {
    //        string = [NSString stringWithFormat:@"%d天前",hour / 24];
    //    }else if (hour > 24 * 10) {
    //        string = string;
    //    }
    return string;
}

+ (NSString *)stringWithNsdate:(NSString *)str{
    //    NSString *str=@"1368082020";//时间戳
    NSTimeInterval time=[str doubleValue] / 1000.0;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}


@end
