//
//  WWLiveDetailsFootView.h
//  MicroNetwork
//
//  Created by Lucas on 16/7/4.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWLiveDetailsFootView : UIView

- (instancetype)initWithFrame:(CGRect)frame names:(NSArray*)names menberCount:(NSNumber *)menberCount;

@property (strong, nonatomic) UILabel *menberCount;

@end
