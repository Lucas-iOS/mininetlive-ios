//
//  WWRegisterStepServices.h
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWServices.h"
#import "WWbaseModel.h"

typedef void (^RegisterResponse)(WWbaseModel *baseModel, NSError *error);

@interface WWRegisterStepServices : WWServices
//验证码
+ (void)sendVerificationCode:(NSString *)phoneNumber resultBlock:(RegisterResponse)block;
//提交注册资料
+ (void)requestRegisterParameters:(NSDictionary *)parameters resultBlock:(RegisterResponse)block;
//验证手机号
+ (void)requestVerifyPhone:(NSString *)phonNumber andVcode:(NSString *)vcode resultBlock:(RegisterResponse)block;

@end
