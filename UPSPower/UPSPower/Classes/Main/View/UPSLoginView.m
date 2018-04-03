//
//  UPSLoginView.m
//  UPSPower
//
//  Created by hjun on 2017/12/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSLoginView.h"
#import "UPSRememberBtn.h"
@interface UPSLoginView()<UITextFieldDelegate>
//@property (nonatomic,strong)UPSLoginBackView *backgroundView;

@property (nonatomic, strong) UIActivityIndicatorView *logioningActivityIndicatorView;
@property (nonatomic,strong)UIButton *selectBtn;
@property (nonatomic,strong)UIButton *passwordSelectBtn;
@property (nonatomic,assign)BOOL isSelect;

//@property (nonatomic, assign) BOOL isUserEmpty;
//@property (nonatomic, assign) BOOL isPasswordEmpty;

@end
@implementation UPSLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(SafeAreaTopHeight).equalTo(self);
        make.centerX.equalTo(self);
        make.height.width.offset(100);
        
    }];
    imageView.image = [UIImage imageNamed:@"upslogo"];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 10;
    
    UIView *accountView = [[UIView alloc]init];
    [self addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(15);
        make.leading.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.centerX.equalTo(self);
        make.height.offset(40);
        
    }];
    accountView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    ///左边头像
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 4, 32, 32)];
    [accountView addSubview:iconView];
    iconView.image = [UIImage imageNamed:@"account"];
    
    UITextField *accountTextField = [[UITextField alloc]init];
    [accountView addSubview:accountTextField];
    [accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(iconView.mas_trailing).offset(15);
        make.top.trailing.bottom.equalTo(accountView);
        //        make.height.offset(32);
        //        make.trailing.equalTo(accountView);
        
    }];
    accountTextField.placeholder = @"请输入账号";
    accountTextField.clearButtonMode = UITextFieldViewModeAlways;
    accountTextField.text = [UPSTool getUserName];
    self.userTextField = accountTextField;
    accountTextField.delegate = self;
    ///密码
    UIView *passwordView = [[UIView alloc]init];
    [self addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountView.mas_bottom).offset(10);
        make.leading.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.centerX.equalTo(self);
        make.height.offset(40);
    }];
    passwordView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    UIImageView *passwordImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 4, 32, 32)];
    [passwordView addSubview:passwordImageView];
    passwordImageView.image = [UIImage imageNamed:@"password"];
    
    UITextField *passwordTextField = [[UITextField alloc]init];
    [passwordView addSubview:passwordTextField];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(passwordImageView.mas_trailing).offset(15);
        make.top.trailing.bottom.equalTo(passwordView);
    }];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.secureTextEntry = YES;
    passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordTextField = passwordTextField;
    passwordTextField.text = [UPSTool getPassword];
    passwordTextField.delegate = self;
    
    UIView *rememberView = [[UIView alloc]init];
    [self addSubview:rememberView];
    [rememberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordView.mas_bottom).offset(10);
        make.leading.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.centerX.equalTo(self);
        make.height.offset(20);
    }];
//    rememberView.backgroundColor = [UIColor redColor];
    
    UPSRememberBtn *rememberAccount = [[UPSRememberBtn alloc]initWithFrame:CGRectMake(kScreenW / 6, 0, kScreenW / 4 ,20)];
    [rememberView addSubview:rememberAccount];
    [rememberAccount setTitle:@"记住账号" forState:UIControlStateNormal];
    [rememberAccount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rememberAccount setImage:[UIImage imageNamed:@"xkuang_nor"] forState:UIControlStateNormal];
    [rememberAccount setImage:[UIImage imageNamed:@"xkuang_onclick"] forState:UIControlStateSelected];
    [rememberAccount addTarget:self action:@selector(clickAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (iphone4 || iphone5) {
        rememberAccount.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }else if(iphone6 || iphoneX){
        rememberAccount.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }else{
        rememberAccount.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    rememberAccount.selected = YES;
    //    rememberAccount.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
//
//    // 重点位置开始
//    rememberAccount.imageEdgeInsets = UIEdgeInsetsMake(0, rememberAccount.titleLabel.width + 2.5, 0, -rememberAccount.titleLabel.width - 2.5);
//    rememberAccount.titleEdgeInsets = UIEdgeInsetsMake(0, -rememberAccount.currentImage.size.width, 0, rememberAccount.currentImage.size.width);
//    // 重点位置结束
//    rememberAccount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//
    UPSRememberBtn *rememberPassword = [[UPSRememberBtn alloc]initWithFrame:CGRectMake(kScreenW / 6 + kScreenW / 4 + kScreenW / 6, 0, kScreenW / 4, 20)];
    [rememberView addSubview:rememberPassword];
    [rememberPassword setImage:[UIImage imageNamed:@"xkuang_nor"] forState:UIControlStateNormal];
    [rememberPassword setImage:[UIImage imageNamed:@"xkuang_onclick"] forState:UIControlStateSelected];
    [rememberPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rememberPassword setTitle:@"记住密码" forState:UIControlStateNormal];
    [rememberPassword addTarget:self action:@selector(clickPasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
    if (iphone4 || iphone5) {
        rememberPassword.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }else if(iphone6 || iphoneX){
        rememberPassword.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }else{
        rememberPassword.titleLabel.font = [UIFont systemFontOfSize:15];
        
    }
    rememberPassword.selected = YES;
    
    UPSRememberBtn *sureBtn = [[UPSRememberBtn alloc]init];
//WithFrame:CGRectMake(4, 4, 26, 23)];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(rememberView.mas_bottom).offset(10);
        make.leading.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.centerX.equalTo(self);
        make.height.offset(40);
    }];
    
    sureBtn.titleLabel.alpha = 0.5;
    [sureBtn.layer setCornerRadius:3.0];
    sureBtn.clipsToBounds = YES;
    [sureBtn setTitle:@"登录" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(didClickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [sureBtn setBackgroundColor:[UIColor lightGrayColor]];
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.loginButton = sureBtn;
    self.loginButton.backgroundColor = UICOLOR_RGB(33, 151, 216, 1);
    
    UILabel *bottomLabel = [[UILabel alloc]init];
    [self addSubview:bottomLabel];
    bottomLabel.text = @"昌菱电气  版权所有";
    bottomLabel.font = [UIFont fontWithName:@"Arial"size:22];
    
    if (iphoneX) {
        
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-60);
            make.centerX.equalTo(self);
        }];
        
    }else{
        
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-40);
            make.centerX.equalTo(self);
        }];
        
    }
    
    UILabel *copyRightLabel = [[UILabel alloc]init];
    [self addSubview:copyRightLabel];
    [copyRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        
    }];
    copyRightLabel.text = @"Copyright©2018 Shoryo All Rights Reserved";
    copyRightLabel.font = [UIFont systemFontOfSize:14];
   
    
}

- (void)didClickLoginBtn:(UIButton *)sender{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"didClickSureBtn" object:nil];
//    [self addLogioningActivityIndicatorView];
}

#pragma mark - textfieldDelegate

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSCharacterSet *cs;
//    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
//
//    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    if (self.userTextField == textField) {
//
//    }
//    if (self.passwordTextField == textField) {
//        if (toBeString.length > 0) {
//            self.loginButton.backgroundColor = UICOLOR_RGB(33, 151, 216, 1);          self.loginButton.enabled = YES;
//        }else{
//            self.loginButton.enabled = NO;
//            self.loginButton.backgroundColor = [UIColor lightGrayColor];
//        }
//    }
//
//
//
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
//
//    BOOL canChange = [string isEqualToString:filtered];
//
//    return canChange;
//}
//

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    ///移除键盘
    [self.userTextField resignFirstResponder];
    
    [self.passwordTextField resignFirstResponder];
    
}
///点击记住账号密码
- (void)clickAccountBtn:(UIButton *)accountBtn{
//    self.selectBtn.selected = NO;
//    accountBtn.selected = YES;
//
//    self.selectBtn = accountBtn;
    accountBtn.selected = !accountBtn.selected;
    self.isSelect = accountBtn.selected;
    if (self.isSelect == YES) {
        self.userTextField.text = [UPSTool getUserName];
    }else{
        self.userTextField.text = nil;
    }
}
- (void)clickPasswordBtn:(UIButton *)passwordBtn{
//    self.passwordSelectBtn.selected = NO;
//    passwordBtn.selected = YES;
//    self.passwordSelectBtn = passwordBtn;
    passwordBtn.selected = !passwordBtn.selected;
    self.isSelect = passwordBtn.selected;
    if (self.isSelect == YES) {
        self.passwordTextField.text = [UPSTool getPassword];
    }else{
        self.passwordTextField.text = nil;
    }
}

- (void)addLogioningActivityIndicatorView{
    CGFloat logioningActivityIndicatorViewX = self.loginButton.frame.origin.x + 80;
    CGFloat logioningActivityIndicatorViewY = self.loginButton.frame.origin.y;
    CGFloat logioningActivityIndicatorViewWH = self.loginButton.frame.size.height;
    self.logioningActivityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(logioningActivityIndicatorViewX, logioningActivityIndicatorViewY, logioningActivityIndicatorViewWH, logioningActivityIndicatorViewWH)];
    [self addSubview:self.logioningActivityIndicatorView];
}
//
//- (void)clickLoginBtn:(id)sender{
//    [self.loginButton setTitle:@"登录中..." forState:UIControlStateNormal];
//    [self addLogioningActivityIndicatorView];
//    [self.logioningActivityIndicatorView startAnimating];
//    //当点击登录按钮时，账号和密码输入框放弃第一响应者，此时键盘退出
//    [self.userTextField resignFirstResponder];
//    [self.passwordTextField resignFirstResponder];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"pushTabVC" object:nil];
//    NSLog(@"dadas");
//}
//
//- (void)clickForgetpasswordTextFieldButton:(id)sender{
//    //点击忘记密码button后需要执行的代码
//}
//
//#pragma makr --UITextFieldDelegate
////UITextField的代理方法，点击键盘return按钮退出键盘
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [self.passwordTextField resignFirstResponder];
//    return YES;
//}
////此处为userTextField的监听方法，后面会细讲，主要是实时监听textField值的变化
//- (void)userTextFieldDidChange{
//    if (self.userTextField.text.length > 0) {
//        UIImageView *loginTextFieldImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userIconEdited"]];
//        self.userTextField.leftView = loginTextFieldImage;
//        self.isUserEmpty = NO;
//        if (self.isPasswordEmpty == NO) {
//            self.loginButton.titleLabel.alpha = 1;
//            [self.loginButton setEnabled:YES];
//        }
//    }else{
//        UIImageView *loginTextFieldImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userIcon"]];
//        self.userTextField.leftView = loginTextFieldImage;
//        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
//        self.loginButton.titleLabel.alpha = 0.5;
//        [self.loginButton setEnabled:NO];
//        self.isUserEmpty = YES;
//        [self.logioningActivityIndicatorView stopAnimating];
//    }
//}
////passwordTextField的监听方法
//- (void)passwordTextFieldDidChange{
//    if (self.passwordTextField.text.length > 0) {
//        self.isPasswordEmpty = NO;
//        UIImageView *loginTextFieldImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"passwordIconEdited"]];
//        self.passwordTextField.leftView = loginTextFieldImage;
//        if (self.isUserEmpty == NO){
//            self.loginButton.titleLabel.alpha = 1;
//            [self.loginButton setEnabled:YES];
//        }
//    }else{
//        self.isPasswordEmpty = YES;
//        UIImageView *loginTextFieldImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"passwordIcon"]];
//        self.passwordTextField.leftView = loginTextFieldImage;
//        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
//        self.loginButton.titleLabel.alpha = 0.5;
//        [self.loginButton setEnabled:NO];
//        [self.logioningActivityIndicatorView stopAnimating];
//    }
//}
////点击界面空白处退出键盘
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.userTextField resignFirstResponder];
//    [self.passwordTextField resignFirstResponder];
//}

@end
