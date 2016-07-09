//
//  WWLoginServices.m
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWLoginServices.h"

#define LOGIN_PATH            @"auth/login"
#define THIRD_PARTY_LOGIN     @"oauth/login"
#define THIRD_PARTY_REGISTER  @"oauth/register"
#define INVITE_CODE_PATH      @"common/inviteCode"

@implementation WWLoginServices

+ (void)requestLogin:(NSDictionary *)parameters resultBlock:(LoginResponse)block {
    [self startDataTaskWithParameters:parameters apiPath:LOGIN_PATH completionBlock:^(id responseObject, NSError *error) {
        NSLog(@"手机登录:%@",responseObject);
        WWbaseModel *baseModel = [WWbaseModel modelWithJSON:responseObject];
        if (!error) {
            if (block) {
                block(baseModel, nil);
            }
        } else {
            block(nil, error);
        }
    }];
}

+ (void)requestThirdPartyLogin:(NSDictionary *)parameters resultBlock:(LoginResponse)block {
    [self startDataTaskWithParameters:parameters apiPath:THIRD_PARTY_LOGIN completionBlock:^(id responseObject, NSError *error) {
        NSLog(@"第三方登录：%@",responseObject);
        WWbaseModel *baseModel = [WWbaseModel modelWithJSON:responseObject];
        if (!error) {
            if (block) {
                block(baseModel, nil);
            }
        } else {
            block(nil, error);
        }
    }];
}

+ (void)requestThirdPartyRegister:(NSDictionary *)parameters resultBlock:(LoginResponse)block {
    [self startDataTaskWithParameters:parameters apiPath:THIRD_PARTY_REGISTER completionBlock:^(id responseObject, NSError *error) {
        NSLog(@"第三方注册：%@",responseObject);

        WWbaseModel *baseModel = [WWbaseModel modelWithJSON:responseObject];
        if (!error) {
            if (block) {
                block(baseModel, nil);
            }
        } else {
            block(nil, error);
        }
    }];
}

+ (void)sendInviteCode:(NSString *)inviteCode uid:(NSString *)uid resultBlock:(LoginResponse)block {
    NSDictionary *parameters = @{@"invitedCode":inviteCode,
                                 @"uid":uid};
    
    [self startDataTaskWithParameters:parameters apiPath:INVITE_CODE_PATH completionBlock:^(id responseObject, NSError *error) {
        NSLog(@"发送邀请码：%@",responseObject);

        WWbaseModel *baseModel = [WWbaseModel modelWithJSON:responseObject];
        if (!error) {
            if (block) {
                block(baseModel, nil);
            }
        } else {
            block(nil, error);
        }
    }];
}

@end
