package com.liuhx.jswebview.injector;

import android.webkit.WebView;

import org.json.JSONObject;

/**
 * @author liuhx
 * @date 2018/7/10.
 */

public abstract class JsHandler {
    abstract String action();

    // 如果有需要，可以用Gson或fastjson转换成bean，而不是用JSONObject
    abstract void handleJs(WebView webView, JSONObject object);

    void invokeCallback(final WebView webView, String callback, String result) {
        final String url = "javascript:" + callback + "(" + result.toString() + ")";

        webView.post(new Runnable() {
            @Override
            public void run() {
                webView.loadUrl(url);
            }
        });
    }
}
