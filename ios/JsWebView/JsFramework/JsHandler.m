//
//  JsHandler.m
//  JsWebView
//
//  Created by liuhx on 2018/7/10.
//  Copyright © 2018 hursing. All rights reserved.
//

#import "JsHandler.h"

void invokeCallback(WKWebView *webView, NSString *callback, NSDictionary *result) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:result options:0 error:nil];
    NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *js = [NSString stringWithFormat:@"%@(%@)", callback, resultString];
    [webView evaluateJavaScript:js completionHandler:nil];
}
