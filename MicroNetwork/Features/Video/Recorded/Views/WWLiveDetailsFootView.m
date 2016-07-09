//
//  WWLiveDetailsFootView.m
//  MicroNetwork
//
//  Created by Lucas on 16/7/4.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWLiveDetailsFootView.h"
#import "WWUserInfoModel.h"



@implementation WWLiveDetailsFootView


- (instancetype)initWithFrame:(CGRect)frame names:(NSArray*)names menberCount:(NSNumber *)menberCount {
    
    if (self = [super initWithFrame:frame]) {

        [self initializeWithMneber:names frame:frame menberCount:menberCount];
        
    }
    return self;
}

- (void)initializeWithMneber:(NSArray *)menbers frame:(CGRect)frame menberCount:(NSNumber *)menberCount {
    self.backgroundColor = [UIColor whiteColor];
    UILabel *menberCountText = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, SCREEN_WIDTH - 40, 19)];
    menberCountText.textColor = UIColorFromRGB(0x4A4A4A);
    menberCountText.font = [UIFont systemFontOfSize:14];
    
    menberCountText.text = [NSString stringWithFormat:@"在线人数：%@",menberCount];
    [self addSubview:menberCountText];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, SCREEN_WIDTH, 8)];
    lineView.backgroundColor = UIColorFromRGB(0xEEEEEE);
    [self addSubview:lineView];
    
    NSInteger countInLine = 5;
    CGFloat imageViewInAllRaw = 0.6; //imageView占iamgeView和lbale的高度比例
    NSInteger line = menbers.count/countInLine + (menbers.count%countInLine==0 ? 0 : 1);//计算行数
    //限制frame的高度
    frame.size.height = 115 * line;
    
    CGFloat imageViewAndLabeHeight = frame.size.height / line;//计算单个ImageView和Label的总体高度
    CGFloat imageViewAndLabeWidth = frame.size.width / countInLine;//计算单个ImageView和Label的总体宽度
    CGFloat imageViewAndLabelX = 0;//计算单个ImageView和Label的起始位置（X）
    CGFloat imageViewY = 0;//计算单个ImageView和Label的起始位置(Y)
    CGFloat verticalGap = 10.0;
    CGFloat imageViewHeight = 30;//计算单个ImageView的高度
    for (NSInteger i = 0; i < menbers.count; i++) {
        imageViewAndLabelX = i % 5 * imageViewAndLabeWidth;
        imageViewY = i / 5 * imageViewAndLabeHeight + (imageViewAndLabeHeight * imageViewInAllRaw - imageViewHeight) * 0.5;
        
        //UIImageView
        //            NSString *imageName = [NSString stringWithFormat:@"head_00%ld", (long)i % 5 + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_n"]];
        CGFloat imageViewWidth = 30;
        imageView.frame = CGRectMake((imageViewAndLabeWidth - imageViewWidth) * 0.5 + imageViewAndLabelX, imageViewY + 28, imageViewWidth, imageViewHeight);
        
        WWUserInfoModel *menber = menbers[i];
        //具体的label样式还要调整一下
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageViewAndLabelX, imageView.frame.origin.y + 4 , imageViewAndLabeWidth, imageViewAndLabeHeight - imageView.bounds.size.height - verticalGap)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = UIColorFromRGB(0xC9C9C9);
        label.text = menber.nickname;
        
        [self addSubview:imageView];
        [self addSubview:label];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
