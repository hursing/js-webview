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
#import "DefaultHandler.h"

@interface WebViewInjector ()

@property (nonatomic) WKWebView *webView;
@property (nonatomic) NSMutableDictionary<NSString*, id<JsHandler>> *jsHandlers;

@end

@implementation WebViewInjector

- (void)addJsHandler:(id<JsHandler>) handler {
    [self.jsHandlers setObject:handler forKey:[handler action]];
}

- (void)injectToWebView:(WKWebView *)webView {
    self.webView = webView;
    if (!self.jsHandlers) {
        self.jsHandlers = [[NSMutableDictionary alloc] initWithCapacity:10];
        // 每种action都有自己的handler
        [self addJsHandler:GetIpHandler.new];
        [self addJsHandler:GetPackageNameHandler.new];
    }
}

#pragma mark - WKScriptMessageHandler methods
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSDictionary *body = message.body;
    if (![body isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSString *action = body[@"action"];
    id<JsHandler> handler = self.jsHandlers[action];
    if (!handler) {
        handler = [DefaultHandler sharedInstance];
    }
    [handler handleJsFromWebView:self.webView info:body];
}

@end
