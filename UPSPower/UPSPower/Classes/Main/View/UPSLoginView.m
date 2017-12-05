//
//  UPSLoginView.m
//  UPSPower
//
//  Created by hjun on 2017/12/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSLoginView.h"
//#import "UPSLoginBackView.h"
//#import "UPSLoginTextField.h"
@interface UPSLoginView()<UITextFieldDelegate>
//@property (nonatomic,strong)UPSLoginBackView *backgroundView;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIActivityIndicatorView *logioningActivityIndicatorView;

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
        make.top.offset(30).equalTo(self);
        make.centerX.equalTo(self);
        make.height.width.offset(200);
        
    }];
    imageView.image = [UIImage imageNamed:@"upslogo"];
    
    UIView *accountView = [[UIView alloc]init];
    [self addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(20);
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
    self.userTextField = accountTextField;
    accountTextField.delegate = self;
    ///密码
    UIView *passwordView = [[UIView alloc]init];
    [self addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(accountView.mas_bottom).offset(15);
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
    self.passwordTextField = passwordTextField;
    passwordTextField.delegate = self;
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(4, 4, 26, 23)];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(passwordView.mas_bottom).offset(20);
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
    [sureBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    
}

- (void)didClickLoginBtn:(UIButton *)sender{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"didClickSureBtn" object:nil];
    [self addLogioningActivityIndicatorView];
}

#pragma mark - textfieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS]invertedSet];
    
    NSString *toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (self.userTextField == textField) {
        
    }
    if (self.passwordTextField == textField) {
        if (toBeString.length > 0) {
            self.loginButton.backgroundColor = UICOLOR_RGB(33, 151, 216, 1);          self.loginButton.enabled = YES;
        }else{
            self.loginButton.enabled = NO;
            self.loginButton.backgroundColor = [UIColor lightGrayColor];
        }
    }
    
    
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [string isEqualToString:filtered];
    
    return canChange;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    ///移除键盘
    [self.userTextField resignFirstResponder];
    
    [self.passwordTextField resignFirstResponder];
    
}


//
////添加textField的背景View
//- (void)addLoginBackgroundView:(CGRect)frame{
//    CGFloat backgroundX = 0;
//    CGFloat backgroundY = 0;
//    CGFloat backgroundW = frame.size.width;
//    CGFloat backgroundH = 80;
//    self.backgroundView = [[UPSLoginBackView alloc] initWithFrame:CGRectMake(backgroundX, backgroundY, backgroundW, backgroundH)];
//    [self.backgroundView setBackgroundColor:[UIColor yellowColor]];
//    [self.backgroundView.layer setCornerRadius:5.0];
//    [self.backgroundView.layer setBorderWidth:1.0];
//    [self.backgroundView.layer setBorderColor:UICOLOR_RGB(207, 207, 207, 1).CGColor];
//    [self addSubview:self.backgroundView];
////    self.backgroundView.backgroundColor = [UIColor redColor];
//}
//
//- (void)customAllButtons:(CGRect)frame{
////    //返回button
////    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(19, 35, 22, 22)];
////    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
////    [backButton addTarget:self action:@selector(clickTheBackButton:) forControlEvents:UIControlEventTouchDown];
////    [self addSubview:backButton];
////    [backButton setBackgroundColor:[UIColor orangeColor]];
//    //登录button
//    CGFloat loginButtonX = 20;
//    CGFloat loginButtonY = self.backgroundView.origin.y + self.backgroundView.height + 30;
//    CGFloat loginButtonW = frame.size.width - 40;
//    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(loginButtonX, loginButtonY, loginButtonW, 40)];
////    [self.loginButton setEnabled:NO];
//    self.loginButton.titleLabel.alpha = 0.5;
//    [self.loginButton.layer setCornerRadius:3.0];
//    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
//    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateReserved];
//    [self.loginButton setBackgroundColor:UICOLOR_RGB(133, 122, 250, 1)];
//    [self.loginButton addTarget:self action:@selector(clickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.loginButton];
//    //忘记密码
//    CGFloat forgetButtonW = 73;
//    CGFloat forgetButtonX = loginButtonX + loginButtonW - forgetButtonW;
//    CGFloat forgetButtonY = 0.916 * (loginButtonY + 100);
//    CGFloat forgetButtonH = 20;
//    UIButton *forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(forgetButtonX, forgetButtonY, forgetButtonW, forgetButtonH)];
//    [forgetButton addTarget:self action:@selector(clickForgetpasswordTextFieldButton:) forControlEvents:UIControlEventTouchDown];
//    [forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
//    [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    [forgetButton setTitleColor:UICOLOR_RGB(74, 74, 74, 1)forState:UIControlStateNormal];
//    [self addSubview:forgetButton];
//}
//
//- (void)customUserTextField:(CGRect)frame{
//    self.userTextField = [[UPSLoginTextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
//    self.userTextField.keyboardType = UIKeyboardTypeNumberPad;
//    self.userTextField.delegate = self;
//    self.userTextField.tag = 7;
//    self.userTextField.placeholder = @"请输入账号";
//    [self.userTextField setFont:[UIFont systemFontOfSize:14]];
//    UIImageView *userTextFieldImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account"]];
//    self.userTextField.leftView = userTextFieldImage;
//    self.userTextField.leftViewMode = UITextFieldViewModeAlways;
//    self.userTextField.clearButtonMode = UITextFieldViewModeAlways;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.userTextField];
//    self.isPasswordEmpty = YES;
//    [self.backgroundView addSubview:self.userTextField];
//}
//
//- (void)customPasswordTextField:(CGRect)frame{
//    self.passwordTextField = [[UPSLoginTextField alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, 40)];
//    self.passwordTextField.delegate = self;
//    self.passwordTextField.tag = 11;
//    self.passwordTextField.placeholder = @"请输入密码";
//    [self.passwordTextField setFont:[UIFont systemFontOfSize:14]];
//    UIImageView *passwordTextFieldImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
//    self.passwordTextField.leftView = passwordTextFieldImage;
//    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
//   // self.passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
//    self.passwordTextField.secureTextEntry = YES;
//    //设置监听
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(passwordTextFieldDidChange) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
//    self.isUserEmpty = YES;
//    [self.backgroundView addSubview:self.passwordTextField];
//}
//
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
