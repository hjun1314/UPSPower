//
//  UPSPower.h
//  UPSPower
//
//  Created by hjun on 2017/12/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#define UPSPower_h

#define Singleton_h(name)  +(instancetype)shared##name;
#if __has_feature(objc_arc) // arc
#define Singleton_m(name) \
+(instancetype)shared##name{ \
return [[self alloc] init]; \
}\
\
- (id)copyWithZone:(NSZone *)zone{\
return self;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone {\
static id instance;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
instance = [super allocWithZone:zone];\
});\
return instance;\
}




#endif /* UPSPower_h */
