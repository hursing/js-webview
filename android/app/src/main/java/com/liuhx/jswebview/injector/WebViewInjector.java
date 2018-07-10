package com.liuhx.jswebview.injector;

import android.webkit.WebView;

/**
 * @author liuhx
 * @date 2018/7/10.
 */

public class WebViewInjector {
    WebView mWebView;

    public void injectToWebView(WebView webView) {
        mWebView = webView;
    }


}
