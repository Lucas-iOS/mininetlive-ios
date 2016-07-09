//
//  WWRegisterStepServices.m
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWRegisterStepServices.h"
#import "WWUserInfoModel.h"


#define REGISTER_PATH               @"auth/register"
#define VCODE_PATH                  @"auth/vcode"
#define VERIFY_PHONE_PATH           @"auth/verify/phone"


@implementation WWRegisterStepServices

+ (void)sendVerificationCode:(NSString *)phoneNumber resultBlock:(RegisterResponse)block {
    NSDictionary *parameters = @{@"phone": phoneNumber};
    
    [self startDataTaskWithParameters:parameters apiPath:VCODE_PATH completionBlock:^(id responseObject, NSError *error) {
        NSLog(@"发送验证码:%@",responseObject);
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

+ (void)requestRegisterParameters:(NSDictionary *)parameters resultBlock:(RegisterResponse)block {
    [self startDataTaskWithParameters:parameters apiPath:REGISTER_PATH completionBlock:^(id responseObject, NSError *error) {
        NSLog(@"注册:%@",responseObject);
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

+ (void)requestVerifyPhone:(NSString *)phonNumber andVcode:(NSString *)vcode resultBlock:(RegisterResponse)block {
    NSDictionary *parameters = @{@"phone": phonNumber,
                                 @"vcode": vcode};
    [self startDataTaskWithParameters:parameters apiPath:VERIFY_PHONE_PATH completionBlock:^(id responseObject, NSError *error) {
        NSLog(@"验证:%@",responseObject);

        if (!error) {
            WWbaseModel *baseModel = [WWbaseModel modelWithJSON:responseObject];
            if (block) {
                block(baseModel, nil);
            }
        } else {
            DLog(@"error:%@",error);
        }
    }];
}

@end
