//
//  WWTapRecordedCollectionViewCell.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWVideoModel.h"

@interface WWTapRecordedCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *videoType;
@property (weak, nonatomic) IBOutlet UIImageView *fontCover;
@property (weak, nonatomic) IBOutlet UILabel *appointmentCount;


- (void)setVideoListData:(WWVideoModel *)video;

@end
