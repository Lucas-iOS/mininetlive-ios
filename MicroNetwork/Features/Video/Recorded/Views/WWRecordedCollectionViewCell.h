//
//  WWRecordedCollectionViewCell.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/9.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWVideoModel.h"

@interface WWRecordedCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
//@property (weak, nonatomic) IBOutlet UILabel *VideoType;
@property (weak, nonatomic) IBOutlet UIImageView *fontCover;
@property (weak, nonatomic) IBOutlet UILabel *playCount;

- (void)setVideoListData:(WWVideoModel *)video;

@end
