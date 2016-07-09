//
//  WWLiveTableViewCell.h
//  MicroNetwork
//
//  Created by Lucas on 16/7/9.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WWVideoModel;

@interface WWLiveTableViewCell : UITableViewCell
- (void)setLiveData:(WWVideoModel *)video;
@end
