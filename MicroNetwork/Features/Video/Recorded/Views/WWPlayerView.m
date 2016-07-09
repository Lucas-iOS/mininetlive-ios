//
//  WWPlayerView.m
//  MicroNetwork
//
//  Created by Lucas on 16/7/8.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWPlayerView.h"
#import "UCloudMediaPlayer.h"
#import "WWVideoModel.h"
#import "WWUtils.h"

#define BASE_URL        @"rtmp://vlive3.rtmp.cdn.ucloud.com.cn/ucloud/"
static const CGFloat kVideoControlBarHeight = 40.0;
static const CGFloat kVideoControlAnimationTimeinterval = 0.3;
static const CGFloat kVideoControlBarAutoFadeOutTimeinterval = 5.0;


@interface WWPlayerView ()
@property (strong, nonatomic) UCloudMediaPlayer *mediaPlayer;
@property (strong, nonatomic) UIView *bottomBar;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIButton *fullScreenButton;
@property (strong, nonatomic) UIButton *shrinkScreenButton;
@property (nonatomic, assign) BOOL isFullscreenMode;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) BOOL isBarShowing;
@property (nonatomic, assign) WWVideoModel *video;
@end

@implementation WWPlayerView

+ (NSString *)path:(NSString *)url {
    
    return [NSString stringWithFormat:@"%@%@",BASE_URL, url];
}


+ (WWPlayerView *)sharedManager{
    static dispatch_once_t predicate;
    static WWPlayerView * sharedManager;
    if (sharedManager == nil) {
        dispatch_once(&predicate, ^{
            sharedManager=[[WWPlayerView alloc] init];
        });
    }
    return sharedManager;
}

- (instancetype)initWithFrame:(CGRect)frame VideoModel:(WWVideoModel *)video {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.video = video;
        self.mediaPlayer = [UCloudMediaPlayer ucloudMediaPlayer];
        [self addPlayerWithPlayerURL:[self.class path:@"testlive_mininetlive_fee"]];
        [self addSubview:self.bottomBar];
        [self.bottomBar addSubview:self.fullScreenButton];
        [self.bottomBar addSubview:self.shrinkScreenButton];
        self.shrinkScreenButton.hidden = YES;
        [self.fullScreenButton addTarget:self action:@selector(fullScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.shrinkScreenButton addTarget:self action:@selector(shrinkScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [self addGestureRecognizer:tapGesture];
        self.isBarShowing = YES;
        [self autoFadeOutControlBar];
    }
    return self;
}

- (void)onTap:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        if (self.isBarShowing) {
            [self animateHide];
        } else {
            [self animateShow];
        }
    }
}

- (void)addPlayerWithPlayerURL:(NSString *)url {
    [self.mediaPlayer showMediaPlayer:url urltype:UrlTypeLive frame:CGRectNull view:self completion:^(NSInteger defaultNum, NSArray *data) {
        if (self.mediaPlayer) {
            
        }
    }];
    self.mediaPlayer.player.controlStyle = MPMovieControlStyleNone;
    self.mediaPlayer.player.scalingMode = MPMovieScalingModeFill;
}

- (void)shutdown {
    [self.mediaPlayer.player shutdown];
    self.mediaPlayer = nil;
}

- (void)layoutSubviews {
    self.mediaPlayer.player.view.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    self.bottomBar.frame = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetHeight(self.bounds) - kVideoControlBarHeight, CGRectGetWidth(self.bounds), kVideoControlBarHeight);
    
    self.fullScreenButton.frame = CGRectMake(CGRectGetWidth(self.bottomBar.bounds) - CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.bottomBar.bounds)/2 - CGRectGetHeight(self.fullScreenButton.bounds)/2, CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.fullScreenButton.bounds));
    self.shrinkScreenButton.frame = self.fullScreenButton.frame;
}

- (UIView *)bottomBar {
    if (_bottomBar == nil) {
        _bottomBar = [UIView new];
        _bottomBar.backgroundColor = UIColorFromRGB(0x4A90E2);
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 10, 100, 19)];
        switch (self.video.activityState) {
            case 0:
                label.text = @"预告";
                break;
            case 1:
                label.text = @"直播中....";
                break;
            case 2:
                label.text = @"结束";
                break;
                
            default:
                break;
        }
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        [self.bottomBar addSubview:label];
    }
    return _bottomBar;
}

//- (UILabel *)label {
//    if (_label == nil) {
//        _label = [[UILabel alloc] initWithFrame:CGRectMake(17, 10, 100, 19)];
//        _label.textColor = [UIColor whiteColor];
//        _label.font = [UIFont systemFontOfSize:14];
//    }
//    return _label;
//}

- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"kr-video-player-fullscreen"] forState:UIControlStateNormal];
        _fullScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _fullScreenButton;
}

- (UIButton *)shrinkScreenButton
{
    if (!_shrinkScreenButton) {
        _shrinkScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shrinkScreenButton setImage:[UIImage imageNamed:@"kr-video-player-shrinkscreen"] forState:UIControlStateNormal];
        _shrinkScreenButton.bounds = CGRectMake(0, 0, kVideoControlBarHeight, kVideoControlBarHeight);
    }
    return _shrinkScreenButton;
}

- (void)fullScreenButtonClick {
    
    if ([_delegate respondsToSelector:@selector(liveVideoFullScreenButtonClick)]) {
        
        if (self.video.payState == 0 && self.video.streamType == 0) {
            [WWUtils showTipAlertWithTitle:@"收费直播" message:@"直播视频需购买后才能放大观看"];
            return;
        } else {
            [_delegate liveVideoFullScreenButtonClick];
        }
    }
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"UCloudViewControllerWillRotate"
//                                                                                         object:nil
//                                                                                       userInfo:nil]];
    if (self.isFullscreenMode) {
        return;
    }
    self.originFrame = self.frame;
    
    CGFloat height = [[UIScreen mainScreen] bounds].size.width;
    CGFloat width = [[UIScreen mainScreen] bounds].size.height;
    CGRect frame = CGRectMake((height - width) / 2, (width - height) / 2, width, height);;
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = frame;
        [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    } completion:^(BOOL finished) {
        [self.mediaPlayer refreshView];
        self.isFullscreenMode = YES;
        self.fullScreenButton.hidden = YES;
        self.shrinkScreenButton.hidden = NO;
    }];
}

- (void)shrinkScreenButtonClick {
    
    if ([_delegate respondsToSelector:@selector(liveVideoShrinkScreenButtonClick)]) {
        [_delegate liveVideoShrinkScreenButtonClick];
    }
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"UCloudViewControllerDidRotate"
//                                                                                         object:nil
//                                                                                       userInfo:nil]];
    if (!self.isFullscreenMode) {
        return;
    }
    [UIView animateWithDuration:0.3f animations:^{
        [self setTransform:CGAffineTransformIdentity];
        self.frame = self.originFrame;
    } completion:^(BOOL finished) {
        [self.mediaPlayer refreshView];
        self.isFullscreenMode = NO;
        self.fullScreenButton.hidden = NO;
        self.shrinkScreenButton.hidden = YES;
    }];
}

- (void)animateHide
{
    if (!self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeinterval animations:^{
        self.bottomBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.isBarShowing = NO;
    }];
}

- (void)animateShow
{
    if (self.isBarShowing) {
        return;
    }
    [UIView animateWithDuration:kVideoControlAnimationTimeinterval animations:^{
        self.bottomBar.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.isBarShowing = YES;
        [self autoFadeOutControlBar];
    }];
}

- (void)autoFadeOutControlBar
{
    if (!self.isBarShowing) {
        return;
    }
    [self performSelector:@selector(animateHide) withObject:nil afterDelay:5.0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
