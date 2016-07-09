//
//  GBHeadPortraitImageView.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/17.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeadPortraitBlock)(UIImage *newImage);

@interface GBHeadPortraitImageView : UIImageView

@property (strong, nonatomic) HeadPortraitBlock block;

- (instancetype)initWithFrame:(CGRect)frame currentVC:(UIViewController *)currentVC resultBlock:(HeadPortraitBlock)block;
//对外单独点击事件（特殊位置点击使用）
- (void)alterHeadPortrait:(UITapGestureRecognizer *)gesture;
/**
 *  当前调用VC并返回编辑好的Image
 *
 *  @param target VC
 *  @param block  Imgae
 */
- (void)addTarget:(UIViewController *)target resultBlock:(HeadPortraitBlock)block;

@end
