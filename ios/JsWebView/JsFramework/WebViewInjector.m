//
//  WebViewInjector.m
//  JsWebView
//
//  Created by liuhx on 2018/7/10.
//  Copyright © 2018 hursing. All rights reserved.
//

#import "WebViewInjector.h"

@interface WebViewInjector ()

@property (nonatomic) UIWebView *webView;

@end

@implementation WebViewInjector

- (void)injectToWebView:(UIWebView *)webView {
    self.webView = webView;
}

@end
