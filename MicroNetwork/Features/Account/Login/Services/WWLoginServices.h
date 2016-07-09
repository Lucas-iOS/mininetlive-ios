//
//  WWLoginServices.h
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWServices.h"
#import "WWbaseModel.h"
#import "WWUserInfoModel.h"


typedef void (^LoginResponse)(WWbaseModel *baseModel, NSError *error);

@interface WWLoginServices : WWServices
/**
 *  手机号登录
 */
+ (void)requestLogin:(NSDictionary *)parameters resultBlock:(LoginResponse)block;
/**
 *  第三方登录
 */
+ (void)requestThirdPartyLogin:(NSDictionary *)parameters resultBlock:(LoginResponse)block;
/**
 *  第三方登录没有资料调用第三方注册
 */
+ (void)requestThirdPartyRegister:(NSDictionary *)parameters resultBlock:(LoginResponse)block;
/**
 *  第三方注册成功后调用发送邀请码
 */
+ (void)sendInviteCode:(NSString *)inviteCode uid:(NSString *)uid resultBlock:(LoginResponse)block;

@end
