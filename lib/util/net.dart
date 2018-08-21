import 'dart:async';
import 'package:http/http.dart' as http;

class Net {
  // get 请求的封装
  static Future<String> get(String url, Map<String, String> params) async {
    if (params != null && params.isNotEmpty) {
      // 如果参数不为空，则把参数拼接到地址后面
      StringBuffer queryStringBuffer = new StringBuffer('?');
      params.forEach((key, value) {
        queryStringBuffer.write("$key=$value&");
      });
      String queryString = queryStringBuffer.toString();
      url += queryString;
    }
    print("get $url");
    http.Response res = await http.get(url);
    return res.body;
  }
  // post 请求的封装
  static Future<String> post(String url, Map<String, String> params) async {
    print("post $url");
    http.Response res = await http.post(url, body: params);
    return res.body;
  }
}