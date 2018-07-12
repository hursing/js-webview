//
//  DefaultHandler.m
//  JsWebView
//
//  Created by liuhx on 2018/7/12.
//  Copyright © 2018 hursing. All rights reserved.
//

#import "DefaultHandler.h"

@implementation DefaultHandler

+ (instancetype)sharedInstance {
    static DefaultHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)action {
    return nil;
}

- (void)handleJsFromWebView:(WKWebView *)webView info:(NSDictionary *)info {
    NSMutableDictionary *toJs = [[NSMutableDictionary alloc] initWithCapacity:3];
    toJs[@"result"] = @"unsupported";
    invokeCallback(webView, info, toJs);
}

@end
