//
//  UPSChildUserCell.h
//  UPSPower
//
//  Created by hjun on 2017/11/29.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPSChildUserCell : UITableViewCell

@property (nonatomic,strong)UITextField *nameLabel;
@property (nonatomic,strong)UITextField *passwordLabel;

@property (nonatomic,copy)void(^btnClick)(void);

///  从沙盒中加载用户账号密码
+ (void)loadUserSetting;
///  保存账号密码到沙盒中
+ (void)saveUserSetting;

@end
