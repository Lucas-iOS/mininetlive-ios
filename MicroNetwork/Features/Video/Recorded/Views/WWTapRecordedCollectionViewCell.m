//
//  WWTapRecordedCollectionViewCell.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWTapRecordedCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "WWUtils.h"

@interface WWTapRecordedCollectionViewCell ()

@property (strong, nonatomic) UILabel *videoStatus;

@end

@implementation WWTapRecordedCollectionViewCell

- (void)setVideoListData:(WWVideoModel *)video {
    
    self.title.text = video.title;
    self.videoType.text = video.activityType == 0 ? @"课程类型：免费": @"课程类型：收费";
    [self.fontCover setImageWithURL:[NSURL URLWithString:video.fontCover] placeholderImage:[UIImage imageNamed:@"img_default"]];
    self.appointmentCount.text = [NSString stringWithFormat:@"%zd人",video.appointmentCount];
    
    switch (video.activityState) {
        case 0:
            self.videoStatus.text = @"预告";
            self.videoStatus.frame = CGRectMake(SCREEN_WIDTH - 75, 16, 40, 31);
            self.videoStatus.backgroundColor = RGBA(74, 144, 226, 0.9);
            break;
        case 1:
            self.videoStatus.text = @"直播中";
            self.videoStatus.backgroundColor = RGBA(255, 104, 75, 0.9);
            self.videoStatus.frame = CGRectMake(SCREEN_WIDTH - 90, 16, 55, 31);
            break;
        case 2:
            self.videoStatus.text = @"结束";
            self.videoStatus.backgroundColor = RGBA(165, 170, 178, 0.9);
            self.videoStatus.frame = CGRectMake(SCREEN_WIDTH - 75, 16, 40, 31);
            break;
            
        default:
            break;
    }

    [self addSubview:self.videoStatus];
}

- (UILabel *)videoStatus {
    if (_videoStatus == nil) {
        _videoStatus = [[UILabel alloc] init];
        _videoStatus.layer.cornerRadius = 2;
        _videoStatus.layer.masksToBounds = YES;
        _videoStatus.textColor = [UIColor whiteColor];
        _videoStatus.font = [UIFont systemFontOfSize:14];
        _videoStatus.textAlignment = NSTextAlignmentCenter;
    }
    return _videoStatus;
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.frame = CGRectMake(0, 0, 320, 192);

}

@end
