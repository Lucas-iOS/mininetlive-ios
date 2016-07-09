//
//  WWUtils.h
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WWUtils : NSObject

//#define RGBA(r,g,b,a)                   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define PATHFORPLIST                    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]
#define SYSTEMVERSION                   [[UIDevice currentDevice] systemVersion].floatValue

#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBA(r,g,b,a)                   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/**
 *
 */
+ (void)showTipAlertWithMessage:(NSString *)message;

+ (void)showTipAlertWithTitle:(NSString *)title message:(NSString *)message;



/**
 *  @brief Method to get currrent viewController
 */
+ (UIViewController *)getCurrentVC;

+ (UIViewController *)getVCWithStoryboard:(NSString *)storyboardName viewControllerId:(NSString *)vcId;

+ (void)showLoginVCWithTargetVC:(UIViewController *)targetVC;

@end
