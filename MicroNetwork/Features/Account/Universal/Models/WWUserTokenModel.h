//
//  WWUserTokenModel.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/23.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYKit.h"
#import "WWUserInfoModel.h"

@interface WWUserTokenModel : NSObject <NSCoding>

@property (copy, nonatomic) NSString *token;
@property (strong, nonatomic) NSNumber *showInvited;
@property (strong, nonatomic) WWUserInfoModel *user;

@end
