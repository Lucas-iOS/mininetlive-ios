//
//  WWUserInfoModel.h
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWUserInfoModel : NSObject

@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSNumber *gender;
@property (copy, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSNumber *balance;
@property (copy, nonatomic) NSString *inviteCode;
@property (copy, nonatomic) NSString *qrcode;
@property (copy, nonatomic) NSString *phone;

@end
