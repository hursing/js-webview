package com.liuhx.jswebview.injector;

import android.webkit.WebView;

import org.json.JSONObject;

/**
 * @author liuhx
 * @date 2018/7/10.
 */

public class SendDataHandler extends JsHandler {
    @Override
    public String action() {
        return "sendData";
    }

    @Override
    public void handleJs(WebView webView, JSONObject object) {

    }
}
