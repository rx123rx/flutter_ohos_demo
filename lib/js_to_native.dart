import 'dart:convert';

import 'package:dsbridge_flutter/dsbridge_flutter.dart';
import 'package:flutter_ohos_demo/event_bus_service.dart';

class JsToNative extends JavaScriptNamespaceInterface {
  @override
  void register() {
    registerFunction(jsWxLogin);
    registerFunction(jsGameLoaded);
    registerFunction(jsSendProgress);
  }

  @pragma('vm:entry-point')
  void jsWxLogin(dynamic msg, CompletionHandler handler) {}

  @pragma('vm:entry-point')
  void jsGameLoaded(dynamic arg, CompletionHandler handler) {
    handler.complete(_getCommonRes());
    EventBusService.i.post(BusEvent("", MethodType.GAME_LOADED, handler));
  }

  @pragma('vm:entry-point')
  void jsSendProgress(dynamic arg, CompletionHandler handler) {
    if (arg is String) {
      EventBusService.i.post(BusEvent(arg, MethodType.SEND_PROGRESS, handler));
    } else {
      handler.complete(_getErrRes("未传进度条参数"));
      print("未传广告参数: $arg");
    }
  }

  String _getRes(dynamic data) {
    return jsonEncode({"data": data});
  }

  String _getCommonRes() {
    return _getRes("ok");
  }

  String _getErrRes(String error) {
    return jsonEncode({"error": error});
  }
}
