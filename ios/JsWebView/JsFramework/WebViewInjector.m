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

NSMutableDictionary<NSString*, id<JsHandler>> *s_jsHandlers = nil;

void addJsHandler(id<JsHandler> handler) {
    [s_jsHandlers setObject:handler forKey:[handler action]];
}

void initHandlersIfNeed() {
    if (!s_jsHandlers) {
        s_jsHandlers = [[NSMutableDictionary alloc] initWithCapacity:10];
        // 每种action都有自己的handler
        addJsHandler(GetIpHandler.new);
        addJsHandler(GetPackageNameHandler.new);
    }
}

@interface WebViewInjector ()

@property (nonatomic) WKWebView *webView;

@end

@implementation WebViewInjector

- (void)injectToWebView:(WKWebView *)webView {
    self.webView = webView;
    initHandlersIfNeed();
}

#pragma mark - WKScriptMessageHandler methods
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;
    if (![body isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *action = body[@"action"];
    id<JsHandler> handler = s_jsHandlers[action];
    if (handler) {
        [handler handleJsFromWebView:self.webView info:body];
    }
}

@end
