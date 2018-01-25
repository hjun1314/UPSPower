//
//  UPSChangePassword.m
//  upsmanager
//
//  Created by hjun on 2018/1/18.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSChangePassword.h"
#import "UPSTextField.h"
#define fieldWidth [UIScreen mainScreen].bounds.size.width - 60

@interface UPSChangePassword()<UITextFieldDelegate>

@end

@implementation UPSChangePassword
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
        self.backgroundColor = [UIColor lightTextColor];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame needOrignalPW:(BOOL)needOrignalPW{
//    if (self = [super initWithFrame:frame]) {
//        self.needOrignalPW = needOrignalPW;
//        [self prepareUI];
//        self.backgroundColor = [UIColor lightTextColor];
//    }
//    return self;
//}



- (void)prepareUI {
    // 添加子控件
    
//    [self addSubview:self.passwordView];
    [self addSubview:self.passwordFirstView];
    [self addSubview:self.passwordSecondView];
    [self addSubview:self.completeBtn];
//    [self.passwordView addSubview:self.passwordField];
    [self.passwordFirstView addSubview:self.passwordFirstField];
    [self.passwordSecondView addSubview:self.passwordSecondField];
    
    
//    [self.passwordView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.passwordFirstView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.passwordSecondView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.completeBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.passwordField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.passwordFirstField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.passwordSecondField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // 添加约束
    // 原密码view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordFirstView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordFirstView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordFirstView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordFirstView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    
    
    // 输入新密码view
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passwordFirstView attribute:NSLayoutAttributeBottom multiplier:1 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    
    
    // 再次输入新密码view
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:30]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passwordFirstView attribute:NSLayoutAttributeBottom multiplier:1 constant:30]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30]];
//    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
//
//
    // 完成按钮
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.completeBtn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.completeBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passwordSecondView attribute:NSLayoutAttributeBottom multiplier:1 constant:30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.completeBtn attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.completeBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
    
    
    //原密码field
//    [self.passwordView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.passwordView attribute:NSLayoutAttributeLeading multiplier:1 constant:5]];
//    [self.passwordView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passwordView attribute:NSLayoutAttributeTop multiplier:1 constant:6]];
//    [self.passwordView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.passwordView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-6]];
//    [self.passwordView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
    
    
    //输入新密码field
    [self.passwordFirstView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordFirstField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.passwordFirstView attribute:NSLayoutAttributeLeading multiplier:1 constant:5]];
    [self.passwordFirstView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordFirstField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passwordFirstView attribute:NSLayoutAttributeTop multiplier:1 constant:6]];
    [self.passwordFirstView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordFirstField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.passwordFirstView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-6]];
    [self.passwordFirstView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordFirstField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
    
    
    //再次输入新密码field
    [self.passwordSecondView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.passwordSecondView attribute:NSLayoutAttributeLeading multiplier:1 constant:5]];
    [self.passwordSecondView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passwordSecondView attribute:NSLayoutAttributeTop multiplier:1 constant:6]];
    [self.passwordSecondView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.passwordSecondView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-6]];
    [self.passwordSecondView addConstraint:[NSLayoutConstraint constraintWithItem:self.passwordSecondField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
    
    //如果不需要核对密码就隐藏原密码输入框
//    if (!self.needOrignalPW){
//        self.passwordView.hidden = YES;
//    }
    
    
    
}



#pragma mark - 懒加载
//- (UIView *)passwordView {
//
//    if (_passwordView == nil) {
//
//        _passwordView = [[UIView alloc] init];
//        // 设置背景颜色
//        _passwordView.backgroundColor  = [UIColor whiteColor];
//    }
//    return _passwordView;
//}

- (UIView *)passwordFirstView {
    
    if (_passwordFirstView == nil) {
        
        _passwordFirstView = [[UIView alloc] init];
        // 设置背景颜色
        _passwordFirstView.backgroundColor = [UIColor whiteColor];
    }
    return _passwordFirstView;
}
- (UIView *)passwordSecondView {
    
    if (_passwordSecondView == nil) {
        
        _passwordSecondView = [[UIView alloc] init];
        // 设置背景颜色
        _passwordSecondView.backgroundColor = [UIColor whiteColor];
    }
    return _passwordSecondView;
}
- (UIButton *)completeBtn {
    
    if (_completeBtn == nil) {
        
        _completeBtn = [[UIButton alloc] init];
        // 设置文本
        [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
        // 设置文本颜色
        [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // 设置背景颜色
        [_completeBtn setBackgroundColor:UICOLOR_RGB(33.0, 151.0, 216.0, 1)];
        _completeBtn.layer.cornerRadius = 8;
        _completeBtn.layer.masksToBounds = YES;
    }
    return _completeBtn;
}

//- (UITextField *)passwordField{
//
//    if (_passwordField == nil) {
//
//        _passwordField = [[UITextField alloc] init];
//        // 设置文本
//        _passwordField.placeholder = @"请输原密码";
//
//        // 添加leftView图片
//        [UPSTextField setTxetField:_passwordField withLeftViewImageName:@"lock"];
//
//        _passwordField.delegate = self;
//    }
//    return _passwordField;
//}

- (UITextField *)passwordFirstField {
    
    if (_passwordFirstField == nil) {
        
        _passwordFirstField = [[UITextField alloc] init];
        // 设置文本
        _passwordFirstField.placeholder = @"请输入新密码";
        // 添加leftView图片
        [UPSTextField setTxetField:_passwordFirstField withLeftViewImageName:@"password"];
        
        _passwordFirstField.delegate = self;
    }
    return _passwordFirstField;
}
- (UITextField *)passwordSecondField {
    
    if (_passwordSecondField == nil) {
        
        _passwordSecondField = [[UITextField alloc] init];
        // 设置文本
        _passwordSecondField.placeholder = @"请再次输入新密码";
        // 添加leftView图片
        // 添加leftView图片
        [UPSTextField setTxetField:_passwordSecondField withLeftViewImageName:@"password"];
        
        _passwordSecondField.delegate = self;
    }
    return _passwordSecondField;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

@end
