//
//  WWUserServices.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/26.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWUserServices.h"

#define LOGOUT_PATH     @"auth/logout"

@implementation WWUserServices

+ (void)requestLogOut:(NSString *)uid resultBlock:(LoginResponse)block {
    NSDictionary *parameters = @{@"uid":uid};
    [self startDataTaskWithParameters:parameters apiPath:LOGOUT_PATH completionBlock:^(id responseObject, NSError *error) {
        NSLog(@"退出:%@",responseObject);
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
