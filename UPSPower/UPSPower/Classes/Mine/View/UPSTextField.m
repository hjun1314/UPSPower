//
//  UPSTextField.m
//  upsmanager
//
//  Created by hjun on 2018/1/18.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSTextField.h"

@implementation UPSTextField

// 设置textField左边的图片
+(void)setTextFieldLeftImageView:(UITextField *)textField leftImageName:(NSString *)imageName{
    
    UIImageView *leftView = [[UIImageView alloc] init];
    leftView.image = [UIImage imageNamed:imageName];
    
    CGRect rect = leftView.frame;
    rect.size = CGSizeMake(30, 30);
    leftView.frame = rect;
    
    leftView.contentMode = UIViewContentModeCenter;
    textField.leftView = leftView;
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeAlways;
}

// 设置textField左边的图片
+ (void)setTxetField:(UITextField *)textField withLeftViewImageName:(NSString *)leftImageName {
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:leftImageName]];
    
    CGRect rect = leftView.frame;
    
    rect.size = CGSizeMake(30, 30);
    
    leftView.frame = rect;
    
    leftView.contentMode = UIViewContentModeCenter;
    
    textField.leftView = leftView;
    
    // 设置左边图片一直出现
    textField.leftViewMode = UITextFieldViewModeAlways;
    // 设置textField边框样式
    textField.borderStyle = UITextBorderStyleRoundedRect;
    // 设置输入框中叉号
    textField.clearButtonMode = UITextFieldViewModeAlways;
    // 设置键盘return键类型
    textField.returnKeyType = UIReturnKeyNext;
    
}


@end
