//
//  WWbaseModel.h
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/NSObject+YYModel.h>
#import <YYKit/YYClassInfo.h>


@interface WWbaseModel : NSObject

@property (assign, nonatomic) NSInteger ret;
@property (strong, nonatomic) NSString *msg;
@property (strong, nonatomic) NSDictionary *data;


@end
