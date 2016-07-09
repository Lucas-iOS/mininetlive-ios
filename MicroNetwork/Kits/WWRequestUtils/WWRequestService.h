//
//  WWRequestService.h
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

typedef enum : NSUInteger {
    HttpMethodPOST = 10,
    HttpMethodGET,
} HttpMethod;

extern NSString *const kHttpMethodPOST;
extern NSString *const kHttpMethodGET;
extern NSString *const kMsg;
extern NSString *const kRet;


typedef void (^ServiceResponseBlock)(id responseObject, NSError *error);


@interface WWRequestService : NSObject



+ (NSString *)baseURL;
+ (NSString *)setAccessTokenFromKeychain;
+ (NSString *)getAccessTokenFromKeychain;

+ (AFHTTPSessionManager *)sharedManager;

+ (void)startDataTaskWithParameters:(NSDictionary *)parameters
                            apiPath:(NSString *)apiPath
                    completionBlock:(ServiceResponseBlock)block;

+ (void)startDataTaskWithParameters:(NSDictionary *)parameters
                            apiPath:(NSString *)apiPath
                         HTTPMethod:(NSString *)method
                    completionBlock:(ServiceResponseBlock)block;

@end
