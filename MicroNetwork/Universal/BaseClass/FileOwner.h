//
//  FileOwner.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileOwner : NSObject

@property (nonatomic, weak) IBOutlet UIView *view;

+ (id)viewFromNibNamed:(NSString *)nibName;

@end
