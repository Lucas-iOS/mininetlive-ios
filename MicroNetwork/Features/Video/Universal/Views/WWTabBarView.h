//
//  WWTabBarView.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileOwner.h"

@interface WWTabBarView : UIView
//分享按钮，在添加View时手动添加点击事件
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

+ (id)loadFromNib;

- (void)setRightButtonTitle:(NSString *)title andBackgroundImageString:(NSString *)imageString;

@end
