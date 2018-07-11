//
//  WebViewInjector.m
//  JsWebView
//
//  Created by liuhx on 2018/7/10.
//  Copyright © 2018 hursing. All rights reserved.
//

#import "WebViewInjector.h"

#import "GetIpHandler.h"
#import "GetPackageNameHandler.h"

@interface WebViewInjector ()

@property (nonatomic) WKWebView *webView;
@property (nonatomic) NSMutableDictionary<NSString*, id<JsHandler>> *jsHandlers;

@end

@implementation WebViewInjector

- (void)injectToWebView:(WKWebView *)webView {
    self.webView = webView;
    self.jsHandlers = [[NSMutableDictionary alloc] initWithCapacity:10];
    // 每种action的handler都有自己的handler
    [self addJsHandler:GetIpHandler.new];
    [self addJsHandler:GetPackageNameHandler.new];
}

- (void)addJsHandler:(id<JsHandler>)handler {
    [self.jsHandlers setObject:handler forKey:[handler action]];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;
    if (![body isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *action = body[@"action"];
    id<JsHandler> handler = self.jsHandlers[action];
    if (handler) {
        [handler handleJsFromWebView:self.webView info:body];
    }
}

@end
