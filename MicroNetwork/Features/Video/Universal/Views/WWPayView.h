//
//  WWPayView.h
//  MicroNetwork
//
//  Created by Lucas on 16/6/9.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kMethodATip = 0,
    kMethodBuy,
} kMethod;

typedef enum : NSUInteger {
    kPaymentAliPay = 0,
    kPaymentWechat,
} kPayment;

@protocol PayViewDelegate <NSObject>

- (void)choicePaymentClick:(kPayment)payment andMoney:(NSString *)money;

@end

@interface WWPayView : UIView <UITextFieldDelegate>

+ (id)loadFromNib;
- (void)selectMethodOfPayment:(kMethod)method andPayAmount:(NSString *)payAmount;

@property (weak, nonatomic) id <PayViewDelegate> delegate;


@end
