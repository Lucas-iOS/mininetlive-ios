//
//  WWTabBarView.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/6.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWTabBarView.h"

@implementation WWTabBarView

+ (id)loadFromNib {
    
    return [self loadFromNibNamed:NSStringFromClass(self)];
}

+ (id)loadFromNibNamed:(NSString *)nibName {
    
    return [FileOwner viewFromNibNamed:nibName];
}

- (void)setRightButtonTitle:(NSString *)title andBackgroundImageString:(NSString *)imageString {
    
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    
    [self.rightButton setBackgroundImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
