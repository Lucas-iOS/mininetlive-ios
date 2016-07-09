//
//  WWVideoListModel.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/18.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWVideoListModel.h"
#import "WWVideoModel.h"

@implementation WWVideoListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"recommend" : WWVideoModel.class,
             @"general" : WWVideoModel.class};
}

@end
