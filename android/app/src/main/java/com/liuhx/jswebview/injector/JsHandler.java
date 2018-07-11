package com.liuhx.jswebview.injector;

import android.webkit.WebView;

import org.json.JSONObject;

/**
 * @author liuhx
 * @date 2018/7/10.
 */

public interface JsHandler {
    String action();

    // 如果有需要，可以用Gson或fastjson转换成bean，而不是用JSONObject
    void handleJs(WebView webView, JSONObject object);
}
