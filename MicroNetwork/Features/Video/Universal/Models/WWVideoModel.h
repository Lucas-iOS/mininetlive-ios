//
//  WWVideoModel.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/18.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "YYKit.h"
#import "WWOwner.h"

@interface WWVideoModel : NSObject

@property (strong, nonatomic) NSString *aid;
@property (strong, nonatomic) NSString *streamId;
@property (assign, nonatomic) NSInteger streamType;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *fontCover;
@property (assign, nonatomic) NSInteger type;
@property (assign, nonatomic) NSInteger price;
@property (assign, nonatomic) NSInteger activityState;
@property (assign, nonatomic) NSInteger activityType;
@property (assign, nonatomic) NSInteger payState;
@property (assign, nonatomic) NSInteger appoinState;
@property (assign, nonatomic) NSInteger playCount;
@property (assign, nonatomic) NSInteger appointmentCount;
@property (strong, nonatomic) NSString *livePullPath;
@property (strong, nonatomic) NSString *videoPath;
@property (strong, nonatomic) NSString *groupId;
@property (strong, nonatomic) WWOwner *owner;

//加载更多属性
@property (strong, nonatomic) NSString *belongUserId;

@end
