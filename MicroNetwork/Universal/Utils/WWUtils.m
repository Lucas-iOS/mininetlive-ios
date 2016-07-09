//
//  WWUtils.m
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWUtils.h"
#import "WWLoginViewController.h"

@interface WWUtils ()

@property (strong, nonatomic) UIActivityIndicatorView *waitingIndicator;

@end

@implementation WWUtils

#pragma mark - Instancen
+ (instancetype)shareInstance {
    static WWUtils *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WWUtils alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Tips and waiting
+ (void)showTipAlertWithMessage:(NSString *)message {
    [self showTipAlertWithTitle:@"提示" message:message];
}

+ (void)showTipAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
}


#pragma mark - VC and views
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (UIViewController *)getVCWithStoryboard:(NSString *)storyboardName viewControllerId:(NSString *)vcId {
    UIStoryboard *SB = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *targetVC = [SB instantiateViewControllerWithIdentifier:vcId];
    
    return targetVC;
}

#pragma mark - Show Login VC
+ (void)showLoginVCWithTargetVC:(UIViewController *)targetVC {
    UINavigationController *loginNav = (UINavigationController *)[WWUtils getVCWithStoryboard:@"Account" viewControllerId:@"RegisterNavVC"];
    [targetVC presentViewController:loginNav animated:YES completion:nil];
}

@end
