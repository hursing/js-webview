package com.liuhx.jswebview.injector;

import android.webkit.WebView;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * @author liuhx
 * @date 2018/7/10.
 */

public class GetPackageNameHandler implements JsHandler {
    @Override
    public String action() {
        return "getPackageName";
    }

    @Override
    public void handleJs(WebView webView, JSONObject object) {
        JSONObject toJs = new JSONObject();
        try {
            String name = webView.getContext().getPackageName();
            toJs.put("result", "ok");
            JSONObject data = new JSONObject();
            data.put("name", name);
            toJs.put("data", data);
        } catch (JSONException e) {
            e.printStackTrace();
            return;
        }
        WebViewInjector.invokeCallback(webView, object, toJs);
    }
}
