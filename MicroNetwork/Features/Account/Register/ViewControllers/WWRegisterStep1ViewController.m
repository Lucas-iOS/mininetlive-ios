//
//  WWRegisterStep1ViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWRegisterStep1ViewController.h"
#import "WWRegisterStep2ViewController.h"
#import "WWUtils.h"
#import "WWRegisterStepServices.h"
#import "SVProgressHUD.h"


@interface WWRegisterStep1ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;


@end

@implementation WWRegisterStep1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCurTextFields:[NSArray arrayWithObjects:self.phoneNumber,nil]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)btnSendCode:(UIButton *)sender {
    
    if (![self checkIfPhoneNumberIsCorrect]) {
        return;
    }
    
    [self sendSmsCode];
}

#pragma mark - Private Method
- (void)sendSmsCode {
    [SVProgressHUD show];
    [WWRegisterStepServices sendVerificationCode:self.phoneNumber.text resultBlock:^(WWbaseModel *baseModel, NSError *error) {

        if (!error) {
            [SVProgressHUD dismiss];
            if (baseModel.ret == KERN_SUCCESS) {
                [self performSegueWithIdentifier:@"signup2" sender:nil];
            } else {
                [WWUtils showTipAlertWithMessage:baseModel.msg];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
        }
    }];
}

- (BOOL)checkIfPhoneNumberIsCorrect {
    if (!self.phoneNumber.text || [self.phoneNumber.text isEqualToString:@""]) {
        NSString *strTip = [NSString stringWithFormat:@"请输入手机号码"];
        [WWUtils showTipAlertWithMessage:strTip];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[WWRegisterStep2ViewController class]]) {
        WWRegisterStep2ViewController *registerStep2VC = segue.destinationViewController;
        registerStep2VC.phoneNumber = self.phoneNumber.text;
    }
}


@end
