//
//  UPSChildUserAccountModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/6.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
///显示子账号模型
@interface UPSChildUserAccountModel : NSObject

///用户id
@property (nonatomic,assign)NSInteger userId;
///父账号id
@property (nonatomic,assign)NSInteger parentId;
///用户名
@property (nonatomic,copy)NSString *username;
///密码
@property (nonatomic,copy)NSString *password;





@end
