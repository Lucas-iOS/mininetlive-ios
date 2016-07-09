//
//  WWLoginViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWLoginViewController.h"
#import "NSUserDefaults+Signin.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/ShareSDK+Base.h>
#import "WWUtils.h"
#import "WWRegisterStep1ViewController.h"
#import "WWRegisterStepServices.h"
#import "WWLoginServices.h"
#import "WWTabBarViewController.h"
#import "NSUserDefaults+Signin.h"
#import "WWUserTokenModel.h"
#import "WWInviteCodeViewController.h"
#import "SVProgressHUD.h"
#import "EMSDK.h"


typedef enum : NSUInteger {
    ThirdPartyWeChat = 1000,
    ThirdPartyQQ,
    ThirdPartySinaWeibo,
} ThirdParty;

@interface WWLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textAccount;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (strong, nonatomic) UIImageView *navBarHairlineImageView;

@end

@implementation WWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnRegister.layer.borderColor = RGBA(215, 215, 215, 1).CGColor;
    
    self.textAccount.text = [[NSUserDefaults standardUserDefaults] userName];
    [self addCurTextFields:[NSArray arrayWithObjects:self.textAccount,self.textPassword,nil]];

}

- (IBAction)dimissLoginVC:(UIButton *)sender {
    self.tabBar.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Private Method
- (void)loginIM {
    EMError *error = [[EMClient sharedClient] registerWithUsername:[NSUserDefaults standardUserDefaults].uid password:@"123456"];
    if (error == nil) {
        NSLog(@"注册成功");
    } else {
        NSLog(@"环信:%@",error);
    }
}

#pragma mark - IBActions
- (IBAction)btnLoginClick:(UIButton *)sender {
    __weak __block typeof(self) weakSelf = self;
    [SVProgressHUD show];
    [[NSUserDefaults standardUserDefaults] setUserName:self.textAccount.text];
    NSDictionary *dic = @{@"phone":self.textAccount.text,
                          @"password":self.textPassword.text};
    [WWLoginServices requestLogin:dic resultBlock:^(WWbaseModel *baseModel, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
            if (baseModel.ret == KERN_SUCCESS) {
                [weakSelf loginIM];
                [weakSelf storedAndWhetherTheJumpInviteCodeVC:baseModel.data];
            } else {
                [WWUtils showTipAlertWithMessage:baseModel.msg];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
        }
    }];
}

//第三方登录
- (IBAction)btnThirdPartyLoginClick:(UIButton *)sender {
    __weak __block typeof(self) weakSelf = self;
    switch (sender.tag) {
        case ThirdPartyWeChat:
            [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (state == SSDKResponseStateSuccess) {
                    [weakSelf requestTheThirdPartyRegistration:user];
                    NSLog(@"uid=%@",user.uid);
                    NSLog(@"%@",user.credential);
                    NSLog(@"token=%@",user.credential.token);
                    NSLog(@"nickname=%@",user.nickname);
                } else {
                    NSLog(@"%@",error);
                }
            }];
            break;
        case ThirdPartyQQ:
            [ShareSDK getUserInfo:SSDKPlatformTypeQQ
                   onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                 if (state == SSDKResponseStateSuccess) {
                     [weakSelf requestTheThirdPartyRegistration:user];
                     NSLog(@"uid=%@",user.uid);
                     NSLog(@"%@",user.credential);
                     NSLog(@"token=%@",user.credential.token);
                     NSLog(@"nickname=%@",user.nickname);
                 } else {
                     NSLog(@"%@",error);
                 }
                 
             }];
            break;
        case ThirdPartySinaWeibo:
            [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
                   onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (state == SSDKResponseStateSuccess) {
                    [weakSelf requestTheThirdPartyRegistration:user];
                    NSLog(@"uid=%@",user.uid);
                    NSLog(@"%@",user.credential);
                    NSLog(@"token=%@",user.credential.token);
                    NSLog(@"nickname=%@",user.nickname);
                } else {
                    NSLog(@"%@",error);
                }
            }];
            break;
            
        default:
            break;
    }
}

- (void)requestTheThirdPartyRegistration:(SSDKUser *)user {
    
    __weak __block typeof(self) weakSelf = self;
    NSString *expires = [NSString stringWithFormat:@"%zd",[user.credential.expired timeIntervalSinceNow]];
    NSInteger gender;
    if (user.gender == SSDKGenderMale) {
        gender = SSDKGenderMale;
    } else {
        gender = SSDKGenderFemale;
    }
    
    NSString *nickName;
    if (user.nickname.length > 16) {
        nickName = [user.nickname substringToIndex:16];
    } else {
        nickName = user.nickname;
    }
    
    NSString *plat;
    if (user.platformType == SSDKPlatformTypeSinaWeibo) {
        plat = @"SinaWeibo";
    } else if (user.platformType == SSDKPlatformTypeWechat) {
        plat = @"Wechat";
    } else {
        plat = @"QQ";
    }
    
    NSDictionary *userInfo = @{@"plat":plat,
                               @"openid":user.uid,
                               @"access_token":user.credential.token,
                               @"expires_in":expires,
                               @"nickname":nickName,
                               @"gender":@(gender),
                               @"avatar":user.icon};

    [WWLoginServices requestThirdPartyLogin:userInfo resultBlock:^(WWbaseModel *baseModel, NSError *error) {
        if (!error) {
            if (baseModel.ret == KERN_SUCCESS) {
                [weakSelf loginIM];
                [weakSelf storedAndWhetherTheJumpInviteCodeVC:baseModel.data];
            } else if (baseModel.ret == 1000 || baseModel.ret == 1002) {
                //服务器没有账户资料调用第三方注册
                [WWLoginServices requestThirdPartyRegister:userInfo resultBlock:^(WWbaseModel *baseModel, NSError *error) {
                    if (baseModel.ret == KERN_SUCCESS) {
                        [weakSelf loginIM];
                        [weakSelf storedAndWhetherTheJumpInviteCodeVC:baseModel.data];
                    } else {
                        [WWUtils showTipAlertWithMessage:baseModel.msg];
                    }
                }];
            } else {
                [WWUtils showTipAlertWithMessage:baseModel.msg];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
        }
    }];
}

- (void)storedAndWhetherTheJumpInviteCodeVC:(NSDictionary *)data {
    
    WWUserTokenModel *userToken = [WWUserTokenModel modelWithDictionary:data];
    
    [[NSUserDefaults standardUserDefaults] setUserToken:userToken.token];
    [[NSUserDefaults standardUserDefaults] setShowInvited:userToken.showInvited];
    [[NSUserDefaults standardUserDefaults] setUserInfo:userToken.user];
    WWUserInfoModel *user = userToken.user;
    
    if (userToken.showInvited.integerValue == 1) {
        WWInviteCodeViewController *inviteCodeVC = (WWInviteCodeViewController *)[WWUtils getVCWithStoryboard:@"Account" viewControllerId:@"InviteCodeVC"];
        inviteCodeVC.uib = user.uid;
        [self.navigationController pushViewController:inviteCodeVC animated:YES];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
