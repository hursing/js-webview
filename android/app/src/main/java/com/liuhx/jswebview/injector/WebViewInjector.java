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

    private static final String sKeyId = "id";
    private static final String sKeyAction = "action";

    static {
        // 每种action都有自己的handler
        addHandler(new GetIpHandler());
        addHandler(new GetPackageNameHandler());
    }

    private static void addHandler(JsHandler handler) {
        sHandlerMap.put(handler.action(), handler);
    }

    private WebView mWebView;

    @SuppressLint("SetJavaScriptEnabled")
    public void injectToWebView(WebView webView) {
        mWebView = webView;
        webView.getSettings().setJavaScriptEnabled(true);
        webView.addJavascriptInterface(this, "liuhxJsFramework");
    }

    @JavascriptInterface
    public void postMessage(String jsonString) {
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

    static void invokeCallback(final WebView webView, JSONObject fromJs, JSONObject toJs) {
        String callback;
        try {
            callback = fromJs.getString("callback");
            if (callback.isEmpty()) {
                return;
            }
            toJs.put(sKeyId, fromJs.getString(sKeyId));
            toJs.put(sKeyAction, fromJs.getString(sKeyAction));
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        final String url = "javascript:" + callback + "(" + toJs.toString() + ")";

        webView.post(new Runnable() {
            @Override
            public void run() {
                webView.loadUrl(url);
            }
        });
    }
}
