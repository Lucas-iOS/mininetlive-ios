//
//  NSUserDefaults+Signin.m
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#import "NSUserDefaults+Signin.h"

#define USER_NAME           @"USER_NAME"
#define USER_TOKEN          @"USER_TOKEN"
#define USER_SHOWINVITED    @"showInvited"
#define USER_UID            @"uid"
#define USER_NICKNAME       @"nickName"
#define USER_GENDER         @"gender"
#define USER_AVATAR         @"avatar"
#define USER_BALANCE        @"balance"
#define USER_INVITECODE     @"inviteCode"
#define USER_QRCODE         @"qrcode"
#define USER_PHONE          @"phone"



@implementation NSUserDefaults (Signin)

- (NSString *)userName {
    return [self valueForKey:USER_NAME];
}

- (void)setUserName:(NSString *)userName {
    [self setValue:userName forKey:USER_NAME];
}

- (NSString *)userToken {
    return [self valueForKey:USER_TOKEN];
}

- (void)setUserToken:(NSString *)userToken {
    [self setValue:userToken forKeyPath:USER_TOKEN];
}

- (NSNumber *)showInvited {
    return [self valueForKey:USER_SHOWINVITED];
}

- (void)setShowInvited:(NSNumber *)showInvited {
    [self setValue:showInvited forKey:USER_SHOWINVITED];
}

- (NSString *)uid {
    return [self valueForKey:USER_UID];
}

- (void)setUid:(NSString *)uid {
    [self setValue:uid forKey:USER_UID];
}

- (NSString *)nickName {
    return [self valueForKey:USER_NICKNAME];
}

- (void)setNickName:(NSString *)nickName {
    [self setValue:nickName forKey:USER_NICKNAME];
}

- (NSNumber *)gender {
    return [self valueForKey:USER_GENDER];
}

- (void)setGender:(NSNumber *)gender {
    [self setValue:gender forKey:USER_GENDER];
}

- (NSString *)avatar {
    return  [self valueForKey:USER_AVATAR];
}

- (void)setAvatar:(NSString *)avatar {
    [self setValue:avatar forKey:USER_AVATAR];
}

- (NSNumber *)balance {
    return [self valueForKey:USER_BALANCE];
}

- (void)setBalance:(NSNumber *)balance {
    [self setValue:balance forKey:USER_BALANCE];
}

- (NSString *)inviteCode {
    return [self valueForKey:USER_INVITECODE];
}

- (void)setInviteCode:(NSString *)inviteCode {
    [self setValue:inviteCode forKey:USER_INVITECODE];
}

- (NSString *)qrcode {
    return [self valueForKey:USER_QRCODE];
}

- (void)setQrcode:(NSString *)qrcode {
    [self setValue:qrcode forKey:USER_QRCODE];
}

- (NSString *)phone {
    return [self valueForKey:USER_PHONE];
}

- (void)setPhone:(NSString *)phone {
    [self setValue:phone forKey:USER_PHONE];
}

- (void)setUserInfo:(WWUserInfoModel *)userInfo {
    [self setUid:userInfo.uid];
    [self setNickName:userInfo.nickname];
    [self setGender:userInfo.gender];
    [self setAvatar:userInfo.avatar];
    [self setBalance:userInfo.balance];
    [self setInviteCode:userInfo.inviteCode];
    [self setQrcode:userInfo.qrcode];
    [self setPhone:userInfo.phone];
}

- (void)removeUserInfo {
    [self removeObjectForKey:USER_TOKEN];
    [self removeObjectForKey:USER_SHOWINVITED];
    [self removeObjectForKey:USER_UID];
    [self removeObjectForKey:USER_NICKNAME];
    [self removeObjectForKey:USER_GENDER];
    [self removeObjectForKey:USER_AVATAR];
    [self removeObjectForKey:USER_BALANCE];
    [self removeObjectForKey:USER_INVITECODE];
    [self removeObjectForKey:USER_QRCODE];
    [self removeObjectForKey:USER_PHONE];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in _tmpArray) {
        [cookieJar deleteCookie:obj];
    }
}

@end
