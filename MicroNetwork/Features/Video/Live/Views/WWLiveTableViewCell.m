//
//  WWLiveTableViewCell.m
//  MicroNetwork
//
//  Created by Lucas on 16/7/9.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWLiveTableViewCell.h"
#import "WWVideoModel.h"
#import "UIImageView+AFNetworking.h"

@interface WWLiveTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *videoType;
@property (weak, nonatomic) IBOutlet UIImageView *fontCover;
@property (weak, nonatomic) IBOutlet UILabel *appointmentCount;
@property (strong, nonatomic) UILabel *videoStatus;

@end

@implementation WWLiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLiveData:(WWVideoModel *)video {
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
            self.self.videoStatus.backgroundColor = RGBA(165, 170, 178, 0.9);
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


@end
