//
//  WWOwner.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/18.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "YYKit.h"

@interface WWOwner : NSObject

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *avatar;
@property (assign, nonatomic) NSInteger gender;
@property (strong, nonatomic) NSString *qrcode;
@property (strong, nonatomic) NSString *phone;
@property (assign, nonatomic) NSInteger balance;
@property (strong, nonatomic) NSString *inviteCode;
@end
