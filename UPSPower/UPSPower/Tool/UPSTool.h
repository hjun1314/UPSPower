//
//  UPSTool.h
//  UPSPower
//
//  Created by hjun on 2017/12/6.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPSTool : NSObject

///存token
+(void)saveToken:(NSString *)token;
///取token
+(NSString *)getToken;
///存id
+(void)saveID:(NSInteger)ID;
///取id
+(NSInteger)getID;

///存个推CID
+ (void)saveGeTuiCid:(NSString *)cid;
///取cid
+ (NSString *)getGeTuiCid;

///存账号
+ (void)saveUserName:(NSString *)username;
+ (NSString *)getUserName;
///存密码
+ (void)savePassWord:(NSString *)password;
+ (NSString *)getPassword;


///nadate转字符串
+ (NSString *)strwithInteger:(long)interger;

+ (NSString *)stringWithNsdate:(NSString *)str;

@end
