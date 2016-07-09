//
//  WWRequestService.m
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWRequestService.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import "AFNetworking.h"
#import "NSUserDefaults+Signin.h"


NSString *const kHttpMethodPOST = @"POST";
NSString *const kHttpMethodGET = @"GET";
NSString *const kMsg = @"msg";
NSString *const kRet = @"ret";



#define EXCEPTION_NAME @"Needs Overriding"
#define EXCEPTION_MSG @"Method %s must be overrided to provide concrete implementaion."

@implementation WWRequestService

#pragma mark - class methods
+ (NSString *)baseURL {
    [NSException raise:EXCEPTION_NAME format:EXCEPTION_MSG, __func__];
    return nil;
}

+ (NSString *)setAccessTokenFromKeychain {
    return nil;
}

+ (NSString *)getAccessTokenFromKeychain {
    return nil;
}

+ (NSString*)defaultHTTPMethod {
    return kHttpMethodPOST;
}

+ (AFHTTPSessionManager *)sharedManager {
    static AFHTTPSessionManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.HTTPMaximumConnectionsPerHost = 1;
        _sharedManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:config];
        _sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
//        [_sharedManager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [_sharedManager.requestSerializer setValue:[NSUserDefaults standardUserDefaults].uid forHTTPHeaderField:@"uid"];
        [_sharedManager.requestSerializer setValue:[NSUserDefaults standardUserDefaults].userToken forHTTPHeaderField:@"token"];
        [_sharedManager setSessionDidReceiveAuthenticationChallengeBlock:[self.class sessionDidReceiveAuthenticationChallengeBlock]];
        [_sharedManager setTaskWillPerformHTTPRedirectionBlock:[self.class taskWillPerformHTTPRedirectionBlock]];
        [_sharedManager setTaskDidReceiveAuthenticationChallengeBlock:[self.class taskDidReceiveAuthenticationChallengeBlock]];
    });
    return _sharedManager;
}

+ (id)sessionDidReceiveAuthenticationChallengeBlock {
    id block = nil;
    return block;
}

+ (id)taskWillPerformHTTPRedirectionBlock {
    id block = nil;
    return block;
}

+ (id)taskDidReceiveAuthenticationChallengeBlock {
    id block = nil;
    return block;
}

+ (void)startDataTaskWithParameters:(NSDictionary *)parameters
                            apiPath:(NSString *)apiPath
                    completionBlock:(ServiceResponseBlock)block {
    [self.class requestWithParameters:parameters
                              apiPath:apiPath
                           HTTPMethod:[self defaultHTTPMethod]
                 serviceResponseBlock:block];
}

+ (void)startDataTaskWithParameters:(NSDictionary *)parameters
                            apiPath:(NSString *)apiPath
                         HTTPMethod:(NSString *)method
                    completionBlock:(ServiceResponseBlock)block {
    [self.class requestWithParameters:parameters
                              apiPath:apiPath
                           HTTPMethod:method
                 serviceResponseBlock:block];
}

+ (void)requestWithParameters:(NSDictionary *)parameters
                      apiPath:(NSString *)apiPath
                   HTTPMethod:(NSString *)method
         serviceResponseBlock:(ServiceResponseBlock)block {
    
    AFHTTPSessionManager *sharedManager = [self.class sharedManager];
    NSString *URLString = [[NSString alloc] initWithFormat:@"%@%@",[self.class baseURL], apiPath];
    
    if (block) {
        if ([method isEqualToString:kHttpMethodPOST]) {
            [self POSTRequestWithParameters:parameters URLString:URLString sharedManager:sharedManager ResponseBlock:block];
        } else {
            [self GETRequestWithParameters:parameters URLString:URLString sharedManager:sharedManager ResponseBlock:block];
        }
    }
}

+ (void)POSTRequestWithParameters:(NSDictionary *)parameters URLString:(NSString *)URLString sharedManager:(AFHTTPSessionManager *)sharedManager ResponseBlock:(ServiceResponseBlock)block {
    
    [sharedManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        block(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
}

+ (void)GETRequestWithParameters:(NSDictionary *)parameters URLString:(NSString *)URLString sharedManager:(AFHTTPSessionManager *)sharedManager ResponseBlock:(ServiceResponseBlock)block {
    [sharedManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        block(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil, error);
    }];
}


@end

