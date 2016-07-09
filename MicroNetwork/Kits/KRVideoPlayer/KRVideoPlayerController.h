//
//  KRVideoPlayerController.h
//  KRKit
//
//  Created by aidenluo on 5/23/15.
//  Copyright (c) 2015 36kr. All rights reserved.
//

@import MediaPlayer;
@class WWVideoModel;

@protocol KRVideoPlayerDelegate <NSObject>

- (void)videoShrinkScreenButtonClick;
- (void)videoFullScreenButtonClick;

@end

@interface KRVideoPlayerController : MPMoviePlayerController

@property (weak, nonatomic) id <KRVideoPlayerDelegate> delegate;

@property (nonatomic, copy)void(^dimissCompleteBlock)(void);
@property (nonatomic, assign) CGRect frame;

- (instancetype)initWithFrame:(CGRect)frame video:(WWVideoModel *)video;
- (void)showInWindow;
- (void)dismiss;

@end