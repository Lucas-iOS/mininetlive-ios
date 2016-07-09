//
//  WWRecordedVideoImageView.h
//  MicroNetwork
//
//  Created by Lucas on 16/7/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PlayClickBlock)();

@interface WWRecordedVideoImageView : UIImageView

- (instancetype)initWithFrame:(CGRect)frame imageURL:(NSString *)imageURL clickBlock:(PlayClickBlock)block;

@property (copy, nonatomic) PlayClickBlock block;

@end
