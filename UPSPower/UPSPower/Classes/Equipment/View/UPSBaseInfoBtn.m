//
//  UPSBaseInfoBtn.m
//  UPSPower
//
//  Created by hjun on 2018/2/2.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "UPSBaseInfoBtn.h"

@implementation UPSBaseInfoBtn

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5.0;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted{
    
}
@end
