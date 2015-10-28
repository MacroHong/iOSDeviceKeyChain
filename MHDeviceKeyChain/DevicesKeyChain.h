//
//  DevicesKeyChain.h
//  KeyChain
//
//  Created by MacroHong on 15/7/6.
//  Copyright (c) 2015年 MacroHong. All rights reserved.
//

/*!
 *  模拟产生一个设备号
 *  一台设备唯一
 *  APP删除再安装,设备号仍然不变
 */
#import <Foundation/Foundation.h>

// 定义服务名,以及应用名
#define SERVIVENAME @"blog.csdn.net/macro_13" // 通常去公司的官网
#define KEYNAME @"DevicesKeyChain" // App的包名


/*!
 *  @author Macro QQ:778165728, 15-07-06
 *
 *  @brief  产生设备码(一台设备唯一)
 */
@interface DevicesKeyChain : NSObject

/*!
 *  @author Macro QQ:778165728, 15-07-06
 *
 *  @brief  类方法,获取唯一的设备标识符
 *
 *  @return 设备标识的字符串
 */
+ (NSString *)DevicesKeyChain;

/*!
 *  @author Macro QQ:778165728, 15-07-06
 *
 *  @brief  删除
 */
//测试用
//+ (void)DeleteDevicesKeyChain;
//+ (NSString *)createUuidStr;

@end
