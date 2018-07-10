package com.liuhx.jswebview;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;

import com.liuhx.jswebview.injector.WebViewInjector;

public class MainActivity extends Activity {
    WebView mWebView;
    WebViewInjector mInjector;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mWebView = findViewById(R.id.webview);
        mInjector = new WebViewInjector();
        mInjector.injectToWebView(mWebView);

        mWebView.loadUrl("file:///android_asset/test-framework.html");
    }
}
