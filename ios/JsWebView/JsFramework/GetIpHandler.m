//
//  GetIpHandler.m
//  JsWebView
//
//  Created by liuhx on 2018/7/10.
//  Copyright © 2018 hursing. All rights reserved.
//

#import "GetIpHandler.h"

@implementation GetIpHandler

- (NSString *)action {
    return @"getIp";
}

- (void)handleJsFromWebView:(WKWebView *)webView info:(NSDictionary *)info {
    NSString *idString = info[@"id"];
    NSString *callback = info[@"callback"];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:4];
    result[@"id"] = idString;
    result[@"action"] = [self action];
    result[@"result"] = @"ok";
    result[@"data"] = @{@"ip": @"192.168.1.1"};
    invokeCallback(webView, callback, result);
}

@end
