//
//  GetStorageInfoHandler.m
//  JsWebView
//
//  Created by liuhx on 2018/7/11.
//  Copyright © 2018 hursing. All rights reserved.
//

#import "GetPackageNameHandler.h"

@implementation GetPackageNameHandler

- (NSString *)action {
    return @"getPackageName";
}

- (void)handleJsFromWebView:(WKWebView *)webView info:(NSDictionary *)info {
    NSString *name = [[NSBundle mainBundle] bundleIdentifier];
    NSMutableDictionary *toJs = [[NSMutableDictionary alloc] initWithCapacity:4];
    toJs[@"result"] = @"ok";
    toJs[@"data"] = @{@"name": name};
    invokeCallback(webView, info, toJs);
}

@end
