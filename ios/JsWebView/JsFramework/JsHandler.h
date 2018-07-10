//
//  JsHandler.h
//  JsWebView
//
//  Created by liuhx on 2018/7/10.
//  Copyright © 2018 hursing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@protocol JsHandler

- (NSString *)action;
- (void)handleJsFromWebView:(WKWebView *)webView info:(NSDictionary *)info;

@end

extern void invokeCallback(WKWebView *webView, NSString *callback, NSDictionary *result);
