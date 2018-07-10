package com.liuhx.jswebview.injector;

import android.annotation.SuppressLint;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * @author liuhx
 * @date 2018/7/10.
 */

public class WebViewInjector {

    private static final Map<String, JsHandler> sHandlerMap = new HashMap<>(10);

    static {
        addHandler(new GetIpHandler());
        addHandler(new GetStorageInfoHandler());
        addHandler(new SaveDataHandler());
        addHandler(new SendDataHandler());
    }

    private static void addHandler(JsHandler handler) {
        sHandlerMap.put(handler.action(), handler);
    }

    private WebView mWebView;

    @SuppressLint("SetJavaScriptEnabled")
    public void injectToWebView(WebView webView) {
        mWebView = webView;
        webView.getSettings().setJavaScriptEnabled(true);
        webView.addJavascriptInterface(this, "liuhxJsSdk");
    }

    @JavascriptInterface
    public void invoke(String jsonString) {
        try {
            // 如果有需要，可以使用GSON或fastjson转换成bean
            JSONObject object = new JSONObject(jsonString);
            String action = object.getString("action");
            JsHandler handler = sHandlerMap.get(action);
            if (handler != null) {
                handler.handleJs(mWebView, object);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
