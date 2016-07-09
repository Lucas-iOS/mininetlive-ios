//
//  WWRegisterStep2ViewController.m
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWRegisterStep2ViewController.h"
#import "WWUtils.h"
#import "WWRegisterStep3ViewController.h"
#import "WWRegisterStepServices.h"
#import "SVProgressHUD.h"


@interface WWRegisterStep2ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *sendAgainButton;
@property (weak, nonatomic) IBOutlet UITextField *validateCode;
@property (weak, nonatomic) IBOutlet UILabel *labelPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UITextField *textInviteCode;

@end

@implementation WWRegisterStep2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addCurTextFields:[NSArray arrayWithObjects:self.validateCode, self.textPassword,nil]];
    
    self.labelPhoneNumber.text = self.phoneNumber;
    [self startTime];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private method
- (void)startTime {
    __block int time = 60;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC), 1 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        if (time == 0) {
            dispatch_source_cancel(timer);
        }
        [_sendAgainButton setTitle:[NSString stringWithFormat:@"%d秒", time--] forState:UIControlStateNormal];
        [_sendAgainButton setEnabled:NO];
    });
    
    dispatch_source_set_cancel_handler(timer, ^{
        NSLog(@"cancel");
        [_sendAgainButton setTitle:@"重新发送" forState:UIControlStateNormal];
        [_sendAgainButton setEnabled:YES];
    });
    //启动
    dispatch_resume(timer);
}

#pragma mark - IBActions
- (IBAction)nextStepButton:(id)sender {
    
    if (![self checkIfCodeIsCorrect]) {
        return;
    }
    
    [self verifyCode];
}

- (IBAction)btnOnceAgainSendClick:(UIButton *)sender {
    [self sendSmsCode];
}

- (BOOL)checkIfCodeIsCorrect {
    if (!self.validateCode.text || [self.validateCode.text isEqualToString:@""]) {
        NSString *strTip = [NSString stringWithFormat:@"请输入验证码"];
        [WWUtils showTipAlertWithMessage:strTip];
        return NO;
    }
    
    if (!self.textPassword.text || [self.textPassword.text isEqualToString:@""] || self.textPassword.text.length < 6) {
        NSString *strTip = [NSString stringWithFormat:@"请输入6位数密码"];
        [WWUtils showTipAlertWithMessage:strTip];
        return NO;
    }
    
    return YES;
}

- (void)verifyCode {
    //Verify Code
    [SVProgressHUD show];
    [WWRegisterStepServices requestVerifyPhone:self.phoneNumber andVcode:self.validateCode.text resultBlock:^(WWbaseModel *baseModel, NSError *error) {
        
        if (!error) {
            [SVProgressHUD dismiss];
            if (baseModel.ret == KERN_SUCCESS) {
                [self performSegueWithIdentifier:@"signup3" sender:nil];
            } else {
                [WWUtils showTipAlertWithMessage:baseModel.msg];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
        }
    }];
}

- (void)sendSmsCode {
    [SVProgressHUD show];
    [WWRegisterStepServices sendVerificationCode:self.phoneNumber resultBlock:^(WWbaseModel *baseModel, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
            if (baseModel.ret == KERN_SUCCESS) {
                [self startTime];
            } else {
                [WWUtils showTipAlertWithMessage:baseModel.msg];
            }
        } else {
            [SVProgressHUD showErrorWithStatus:@"连接服务器失败"];
        }
    }];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"signup3"]) {
        WWRegisterStep3ViewController *registerStep3VC = (WWRegisterStep3ViewController *)segue.destinationViewController;
        registerStep3VC.phoneNumber = self.phoneNumber;
        registerStep3VC.textPassword = self.textPassword.text;
        registerStep3VC.textInviteCode = self.textInviteCode.text;
    }
}


@end
