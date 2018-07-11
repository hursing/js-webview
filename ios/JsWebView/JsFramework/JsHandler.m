//
//  JsHandler.m
//  JsWebView
//
//  Created by liuhx on 2018/7/10.
//  Copyright © 2018 hursing. All rights reserved.
//

#import "JsHandler.h"

void invokeCallback(WKWebView *webView, NSDictionary *fromJs, NSMutableDictionary *toJs) {
    NSString *callback = fromJs[@"callback"];
    if (!callback) {
        return;
    }
    toJs[@"id"] = fromJs[@"id"];
    toJs[@"action"] = fromJs[@"action"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:toJs options:0 error:nil];
    NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *js = [NSString stringWithFormat:@"%@(%@)", callback, resultString];
    [webView evaluateJavaScript:js completionHandler:nil];
}
