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
    NSString *callback = info[@"callback"];
    NSDictionary *result = @{@"data": @{@"ip": @"102.12312.12312.123"}};
    invokeCallback(webView, callback, result);
}

@end
