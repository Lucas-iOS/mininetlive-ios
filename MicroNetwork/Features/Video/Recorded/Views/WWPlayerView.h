//
//  WWPlayerView.h
//  MicroNetwork
//
//  Created by Lucas on 16/7/8.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WWVideoModel;

@protocol WWPlayerViewDelegate <NSObject>

- (void)liveVideoShrinkScreenButtonClick;
- (void)liveVideoFullScreenButtonClick;

@end

@interface WWPlayerView : UIView
@property (weak, nonatomic) id <WWPlayerViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame VideoModel:(WWVideoModel *)video;
- (void)shutdown;
@end
