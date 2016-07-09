//
//  WWVideoListModel.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/18.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "YYKit.h"

@interface WWVideoListModel : NSObject

@property (nonatomic) BOOL hasmore;
@property (strong, nonatomic) NSMutableArray *recommend;
@property (strong, nonatomic) NSMutableArray *general;


@end
