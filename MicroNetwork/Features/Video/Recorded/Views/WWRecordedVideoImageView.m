//
//  WWRecordedVideoImageView.m
//  MicroNetwork
//
//  Created by Lucas on 16/7/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWRecordedVideoImageView.h"
#import "UIImageView+AFNetworking.h"


@implementation WWRecordedVideoImageView

- (instancetype)initWithFrame:(CGRect)frame imageURL:(NSString *)imageURL clickBlock:(PlayClickBlock)block {
    if (self = [super initWithFrame:frame]) {
        self.block = block;
        [self setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"img_default"]];
        self.userInteractionEnabled = YES;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.5 - 35, self.frame.size.height * 0.5 - 35, 70, 70)];
        [btn setBackgroundImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return  self;
}

- (void)playClick {
    self.block();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
