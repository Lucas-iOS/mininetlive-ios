//
//  WWGlobalDefine.h
//  MicroNetwork
//
//  Created by Lucas on 16/5/29.
//  Copyright © 2016年 Lucas. All rights reserved.
//

#ifndef WWGlobalDefine_h
#define WWGlobalDefine_h

#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBA(r,g,b,a)                   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height


#define APP_ID              @"a8b1e53b11e395eba9e3"
#define APP_SECRET          @"f732637e1f7c7f1c67af77ccbfdce3bc"

//FringeWebManager
#define APP_NAME            @"weiwang_ios/"
#define APP_VERSION         @"1.0.0"

//SmaugShareKit
#define SHARE_ID_QQ         @"1105470868"
#define SHARE_APP_KEY_QQ    @"KEYp7UMo1wI05ubSFDm"

#define SHARE_ID_WECHAT     @"wx36d2981a085f6370"
#define SHARE_WECHAT_SECRET @"ec283311299f953cc43cdf311b0156e5"

#define SHARE_ID_WEIBO      @"1711841873"
#define SHARE_WEIBO_SECRET  @"2a174ffa9021fed72301363729ba7305"
#define SHARE_WEIBO_URL     @"https://api.weibo.com/oauth2/default.html"

//IM
#define IM_APP_KEY          @"mininetlive#mininetlive"
#define IM_CLIENT_ID        @"YXA6Zp1gwDYSEeasYzMDSE8dCA"
#define IM_CLIENT_SECRET    @"YXA6WWzjQOVY3DASCGa22MCALGyKzoA"

//Statistics
#define SHARE_INFO          @"shareInfo"
#define SHARE_APPKEY        @"1347ed2c6fe18"
#define SHARE_SECRET        @"7f78dc60106f93e22b42bfef16bdf96a"
#define SHARE_SMS_APPKEY    @"13e8f46c927f9"
#define SHARE_SMS_SECRET    @"1a989984162317f0714f1a82ca1bddf0"

#endif /* WWGlobalDefine_h */
