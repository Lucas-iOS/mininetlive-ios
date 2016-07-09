//
//  WWPayView.m
//  MicroNetwork
//
//  Created by Lucas on 16/6/9.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "WWPayView.h"
#import "FileOwner.h"
#import "WWUtils.h"
#import "SVProgressHUD.h"


#define BTN_SELECT_BACKGROUNDCOLOR     RGBA(246, 124, 21, 1)
#define BTN__BACKGROUNDCOLOR           RGBA(234, 234, 234, 1)
#define DEFAULT_LINE_0                   @"188"
#define DEFAULT_LINE_1                   @"888"
#define DEFAULT_LINE_2                   @"9988"


@interface WWPayView  () <UITextFieldDelegate>

@property (strong, nonatomic) UIButton *currentBtn;
@property (strong, nonatomic) NSString *money;
@property (weak, nonatomic) IBOutlet UILabel *labelPayAmount;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldMoney;
@end

@implementation WWPayView

+ (id)loadFromNib {

    return [self loadFromNibNamed:NSStringFromClass(self)];
}

+ (id)loadFromNibNamed:(NSString *)nibName {
    
    return [FileOwner viewFromNibNamed:nibName];
}

- (void)selectMethodOfPayment:(kMethod)method andPayAmount:(NSString *)payAmount {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    if (method == kMethodATip) {
        self.title.text = @"打赏红包";
        self.btnView.frame = CGRectMake(SCREEN_WIDTH * 0.5 - self.payView.frame.size.width * 0.5, SCREEN_HEIGHT  * 0.5 - self.btnView.frame.size.height * 0.5, self.payView.frame.size.width, 74);
        [self addSubview:self.btnView];
        self.textFieldMoney.delegate = self;
        [self.textFieldMoney setValue:BTN_SELECT_BACKGROUNDCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        [self.textFieldMoney setValue:[UIFont boldSystemFontOfSize:17] forKeyPath:@"_placeholderLabel.font"];
    } else {
        self.title.text = @"支付金额";
        self.labelPayAmount.text = payAmount;
    }
}

#pragma mark - IBActions
- (IBAction)btnChoicePayment:(UIButton *)sender {

    [self.textFieldMoney resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(choicePaymentClick:andMoney:)]) {
        if (self.textFieldMoney.text.length > 0) {
            self.money = [NSString stringWithFormat:@"%zd",self.textFieldMoney.text.integerValue * 100];
        }
        if ([self.money isEqualToString:@""] || !self.money) {
            [SVProgressHUD showInfoWithStatus:@"请输入金额"];
            return;
        }
        [self.delegate choicePaymentClick:sender.tag andMoney:self.money];
        [self removeFromSuperview];
    }
}

- (IBAction)btnSelectTheDefaultPaymentAmount:(UIButton *)sender {
    sender.selected = YES;
    sender.userInteractionEnabled = NO;
    sender.backgroundColor = BTN_SELECT_BACKGROUNDCOLOR;
    [self.textFieldMoney resignFirstResponder];
    
    if (sender != self.currentBtn) {
        self.currentBtn.selected = NO;
        self.currentBtn.userInteractionEnabled = YES;
        self.currentBtn.backgroundColor = BTN__BACKGROUNDCOLOR;
        self.currentBtn = sender;
    }
    
    switch (sender.tag) {
        case 0:
            self.money = DEFAULT_LINE_0;
            break;
        case 1:
            self.money = DEFAULT_LINE_1;
            break;
        case 2:
            self.money = DEFAULT_LINE_2;
            break;
            
        default:
            break;
    }
}

#pragma mark - TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentBtn.selected = NO;
    self.currentBtn.userInteractionEnabled = YES;
    self.currentBtn.backgroundColor = BTN__BACKGROUNDCOLOR;
    
    textField.backgroundColor = BTN_SELECT_BACKGROUNDCOLOR;
    textField.textColor = [UIColor whiteColor];
    
    CGFloat y = 0;
    if (SCREEN_HEIGHT == 480) {
        y = 120;
    } else if (SCREEN_HEIGHT == 568) {
        y = 100;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, - y, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.backgroundColor = BTN__BACKGROUNDCOLOR;
    textField.textColor = BTN_SELECT_BACKGROUNDCOLOR;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch =  [touches anyObject];
    if ([touch.view isKindOfClass:[self class]]) {
        [self.textFieldMoney resignFirstResponder];
        [self removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
