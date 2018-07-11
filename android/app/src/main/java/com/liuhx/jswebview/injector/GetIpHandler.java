package com.liuhx.jswebview.injector;

import android.webkit.WebView;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * @author liuhx
 * @date 2018/7/10.
 */

public class GetIpHandler implements JsHandler {
    @Override
    public String action() {
        return "getIp";
    }

    @Override
    public void handleJs(WebView webView, JSONObject object) {
        JSONObject result = new JSONObject();
        String callback = null;
        try {
            result.put("id", object.getString("id"));
            result.put("action", action());
            result.put("result", "ok");
            JSONObject data = new JSONObject();
            data.put("ip", "192.168.0.1");
            result.put("data", data);
            callback = object.getString("callback");
        } catch (JSONException e) {
            e.printStackTrace();
        }
        if (callback != null) {
            WebViewInjector.invokeCallback(webView, callback, result.toString());
        }
    }
}
