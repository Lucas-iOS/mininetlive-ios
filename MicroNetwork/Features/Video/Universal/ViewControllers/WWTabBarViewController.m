//
//  WWTabBarViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/5.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWTabBarViewController.h"
#import "WWUtils.h"
#import "WWLoginViewController.h"
#import "NSUserDefaults+Signin.h"


#define TABBARITEMS @[@"首页",@"直播",@"我的"]

@interface WWTabBarViewController ()

@end

@implementation WWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UINavigationController *recordedNav = (UINavigationController *)[WWUtils getVCWithStoryboard:@"Recorded" viewControllerId:@"RecordedNav"];
    recordedNav.title = TABBARITEMS[0];
    recordedNav.tabBarItem = [self createTabbarItemWithIndex:0 imgaeName:@"ic_home" selectedImageName:@"ic_home_selected"];
    
    UINavigationController *liveNav = (UINavigationController *)[WWUtils getVCWithStoryboard:@"Live" viewControllerId:@"LiveNav"];
    liveNav.title = TABBARITEMS[1];
    liveNav.tabBarItem = [self createTabbarItemWithIndex:1 imgaeName:@"ic_live" selectedImageName:@"ic_live_selected"];
    
    UINavigationController *userNav = (UINavigationController *)[WWUtils getVCWithStoryboard:@"User" viewControllerId:@"UserNav"];
    userNav.title = TABBARITEMS[2];
    userNav.tabBarItem = [self createTabbarItemWithIndex:2 imgaeName:@"ic_me" selectedImageName:@"ic_me_selected"];

    self.viewControllers = @[recordedNav, liveNav, userNav];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],
                                                           NSForegroundColorAttributeName:RGBA(74, 144, 226, 1)}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITabBarItem *)createTabbarItemWithIndex:(int)index imgaeName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:TABBARITEMS[index] image:[UIImage imageNamed:imageName] selectedImage:[[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    item.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    return item;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    NSInteger index = [TABBARITEMS indexOfObject:item.title];
//    if (index == 2 && [NSUserDefaults standardUserDefaults].userToken.length == 0) {
//        UINavigationController *loginNav = (UINavigationController *)[WWUtils getVCWithStoryboard:@"Account" viewControllerId:@"RegisterNavVC"];
//        for (UIViewController *vc in loginNav.viewControllers) {
//            if ([vc isKindOfClass:[WWLoginViewController class]]) {
//                WWLoginViewController *loginVC = (WWLoginViewController *)vc;
//                loginVC.tabBar = self;
//            }
//        }
//        [self presentViewController:loginNav animated:YES completion:nil];
//    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
