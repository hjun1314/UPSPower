//
//  UPSTextField.h
//  upsmanager
//
//  Created by hjun on 2018/1/18.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPSTextField : UITextField
+ (void)setTextFieldLeftImageView:(UITextField *)textField leftImageName:(NSString *)imageName;

+ (void)setTxetField:(UITextField *)textField withLeftViewImageName:(NSString *)leftImageName;
@end
