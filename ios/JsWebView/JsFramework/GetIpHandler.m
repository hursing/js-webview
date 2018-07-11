//
//  GetIpHandler.m
//  JsWebView
//
//  Created by liuhx on 2018/7/10.
//  Copyright © 2018 hursing. All rights reserved.
//

#import "GetIpHandler.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation GetIpHandler

- (NSString *)action {
    return @"getIp";
}

- (void)handleJsFromWebView:(WKWebView *)webView info:(NSDictionary *)info {
    NSString *ip = [GetIpHandler getIPAddress];
    NSMutableDictionary *toJs = [[NSMutableDictionary alloc] initWithCapacity:4];
    if (ip) {
        toJs[@"result"] = @"ok";
        toJs[@"data"] = @{@"ip": ip};
    } else {
        toJs[@"result"] = @"network error";
    }
    invokeCallback(webView, info, toJs);
}

+ (NSString *)getIPAddress {
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // 检索当前接口,在成功时,返回0
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // 循环链表的接口
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // 检查接口是否en0 wifi连接在iPhone上
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // 得到NSString从C字符串
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // 释放内存
    freeifaddrs(interfaces);
    return address;
}

@end
