//
//  WWRecordedDetailsViewController.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWVideoModel.h"
#import "UCloudMediaPlayer.h"
#import "CameraServer.h"



@interface WWRecordedDetailsViewController : UIViewController
@property (strong, nonatomic) WWVideoModel *video;
@property (assign, nonatomic) NSInteger videoTypt;

@end
