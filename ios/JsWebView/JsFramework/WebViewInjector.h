//
//  WebViewInjector.h
//  JsWebView
//
//  Created by liuhx on 2018/7/10.
//  Copyright © 2018 hursing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WebViewInjector : NSObject <WKScriptMessageHandler>

- (void)injectToWebView:(WKWebView *)webView;

@end
