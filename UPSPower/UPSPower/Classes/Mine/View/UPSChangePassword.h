//
//  UPSChangePassword.h
//  upsmanager
//
//  Created by hjun on 2018/1/18.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPSChangePassword : UIView

///  是否需要核对原密码
//@property (nonatomic,assign) BOOL needOrignalPW;
/// 原密码view
//@property (nonatomic, strong) UIView *passwordView;
/// 输入新密码view
@property (nonatomic, strong) UIView *passwordFirstView;
/// 再次输入新密码view
@property (nonatomic, strong) UIView *passwordSecondView;
/// 完成按钮
@property (nonatomic, strong) UIButton *completeBtn;
/// 原密码field
//@property (nonatomic, strong) UITextField *passwordField;
/// 输入新密码field
@property (nonatomic, strong) UITextField *passwordFirstField;
/// 再次输入新密码field
@property (nonatomic, strong) UITextField *passwordSecondField;




///  创建是否核对原密码的 View
///
///  @param frame         frame
///  @param needOrignalPW  是否需要核对原密码
//- (instancetype)initWithFrame:(CGRect)frame needOrignalPW:(BOOL)needOrignalPW;

@end
