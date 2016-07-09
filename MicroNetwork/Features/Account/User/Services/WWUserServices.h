//
//  WWUserServices.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/26.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWServices.h"
#import "WWbaseModel.h"

typedef void (^LoginResponse)(WWbaseModel *baseModel, NSError *error);

@interface WWUserServices : WWServices

+ (void)requestLogOut:(NSString *)uid resultBlock:(LoginResponse)block;

@end
