//
//  ViewController.m
//  JsWebView
//
//  Created by liuhx on 2018/7/10.
//  Copyright © 2018 hursing. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WebViewInjector.h"

@interface ViewController ()

@property (nonatomic) WKWebView *webView;
@property (nonatomic) WebViewInjector *injector;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.injector = [[WebViewInjector alloc] init];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *controller = [[WKUserContentController alloc] init];
    [controller addScriptMessageHandler:self.injector name:@"liuhxJsFramework"];
    config.userContentController = controller;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.injector injectToWebView:self.webView];
    [self.view addSubview:self.webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test-framework" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
