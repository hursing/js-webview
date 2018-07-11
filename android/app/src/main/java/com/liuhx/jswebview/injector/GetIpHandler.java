package com.liuhx.jswebview.injector;

import android.webkit.WebView;

import org.json.JSONException;
import org.json.JSONObject;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

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
        JSONObject toJs = new JSONObject();
        try {
            String ip = getIpAddressString();
            if (ip.isEmpty()) {
                toJs.put("result", "network error");
            } else {
                toJs.put("result", "ok");
                JSONObject data = new JSONObject();
                data.put("ip", ip);
                toJs.put("data", data);
            }
        } catch (JSONException e) {
            e.printStackTrace();
            return;
        }
        WebViewInjector.invokeCallback(webView, object, toJs);
    }

    private static String getIpAddressString() {
        try {
            for (Enumeration<NetworkInterface> enNetI = NetworkInterface
                    .getNetworkInterfaces(); enNetI.hasMoreElements(); ) {
                NetworkInterface netI = enNetI.nextElement();
                for (Enumeration<InetAddress> enumIpAddr = netI
                        .getInetAddresses(); enumIpAddr.hasMoreElements(); ) {
                    InetAddress inetAddress = enumIpAddr.nextElement();
                    if (inetAddress instanceof Inet4Address && !inetAddress.isLoopbackAddress()) {
                        return inetAddress.getHostAddress();
                    }
                }
            }
        } catch (SocketException e) {
            e.printStackTrace();
        }
        return "";
    }
}
