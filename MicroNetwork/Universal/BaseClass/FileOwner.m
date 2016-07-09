//
//  FileOwner.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "FileOwner.h"

@implementation FileOwner


+ (id)viewFromNibNamed:(NSString *)nibName {
    
    FileOwner *owner = [self new];
    
    [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    
    return owner.view;
    
}

@end
