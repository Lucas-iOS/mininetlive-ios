//
//  WWRecordedDetailsServices.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWServices.h"
#import "WWbaseModel.h"

typedef void (^PayResponse)(WWbaseModel *baseModel, NSError *error);

typedef void (^MenberListResponse)(NSArray *menberList, NSError *error);


@interface WWRecordedDetailsServices : WWServices

+ (void)requestPay:(NSDictionary *)parameters resultBlock:(PayResponse)block;

+ (void)requestAppointment:(NSString *)aid resultBlock:(PayResponse)block;

+ (void)requestGroupJoin:(NSString *)groupId resultBlock:(PayResponse)block;

+ (void)requestGroupLeave:(NSString *)groupId resultBlock:(PayResponse)block;

+ (void)requestGroupMemberList:(NSString *)groupId resultBlock:(MenberListResponse)block;

+ (void)requestGroupMemberCount:(NSString *)groupId resultBlock:(PayResponse)block;

@end
