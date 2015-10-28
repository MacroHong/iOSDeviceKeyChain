//
//  DevicesKeyChain.m
//  KeyChain
//
//  Created by MacroHong on 15/7/6.
//  Copyright (c) 2015年 MacroHong. All rights reserved.
//

#import "DevicesKeyChain.h"

#define SERVIVENAME @"com.oeffect.ksudi"
#define KEYNAME @"ksudi"


@implementation DevicesKeyChain

// 单例获取模拟设备号
+ (NSString *)DevicesKeyChain {
    NSString *string = [self getDevicesKeyChain];
    if (string == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        string = [self createUuidStr];
        [dic setObject:string forKey:KEYNAME];
        [self save:SERVIVENAME data:dic];
    }
    return string;
}

// 单例,删除设备中的模拟设备号
+ (void)DeleteDevicesKeyChain {
    [self delete:SERVIVENAME];
}

// 从设备"keychain"中获取模拟设备号
+ (NSString *)getDevicesKeyChain {
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[self load:SERVIVENAME];
    NSString *retStr = [usernamepasswordKVPair objectForKey:KEYNAME];
    return retStr;
}

// 产生一个32位的随机码(数字和字母的组合)作为设备的模拟设备号
+ (NSString *)createUuidStr {
    CFUUIDRef uuid_ref = CFUUIDCreate(nil);
    CFStringRef uuid_string_ref = CFUUIDCreateString(nil, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

// 把数据保存到设备的"keychain"中
+ (void)save:(NSString *)service data:(id)data {
    // Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    // Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    // Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    // Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

// 获取"keychain"的查询字典
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    NSMutableDictionary *retDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   (__bridge_transfer id)kSecClassGenericPassword,
                                   (__bridge_transfer id)kSecClass,
                                   service,
                                   (__bridge_transfer id)kSecAttrService,
                                   service,
                                   (__bridge_transfer id)kSecAttrAccount,
                                   (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,
                                   (__bridge_transfer id)kSecAttrAccessible,
                                   nil];
    return retDic;
}

// 加载"keychain"中与模拟设备号相关的字典
+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

// 删除"keychain"中的模拟设备号
+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}



@end
