//
//  NSUserDefaults+Signin.h
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WWUserInfoModel.h"

@interface NSUserDefaults (Signin)

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userToken;
@property (strong, nonatomic) NSNumber *showInvited;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSNumber *gender;
@property (copy, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSNumber *balance;
@property (copy, nonatomic) NSString *inviteCode;
@property (copy, nonatomic) NSString *qrcode;
@property (copy, nonatomic) NSString *phone;

- (void)setUserInfo:(WWUserInfoModel *)userInfo;
- (void)removeUserInfo;

@end
