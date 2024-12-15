import 'dart:convert';

import 'package:dsbridge_flutter/dsbridge_flutter.dart';

void _defHandler(dynamic value) {
  print("callHandler response: $value");
}

class NativeToJs {
  static void onBackPress(
      DWebViewController controller, OnReturnValue callback) {
    _callHandler(controller, "nvOnBackPress", callback: callback);
  }

  static void onStart(DWebViewController controller) {
    _callHandler(controller, "nvOnStart");
  }

  static void onResume(DWebViewController controller) {
    _callHandler(controller, "nvOnResume");
  }

  static void onPause(DWebViewController controller) {
    _callHandler(controller, "nvOnPause");
  }

  static void onStop(DWebViewController controller) {
    _callHandler(controller, "nvOnStop");
  }

  static void showAdFailed(DWebViewController controller, dynamic error) {
    _callHandlerWithArgs(controller, "nvAdFailed", error);
  }

  static void showAdSuccess(DWebViewController controller, dynamic info) {
    _callHandlerWithArgs(controller, "nvAdShow", info);
  }

  static void adFinish(DWebViewController controller, dynamic adInfo) {
    _callHandlerWithArgs(controller, "nvAdFinish", adInfo);
  }

  static void gameShowed(DWebViewController controller) {
    _callHandler(controller, "nvGameShowed");
  }

  static void _callHandler(
    DWebViewController controller,
    String method, {
    OnReturnValue callback = _defHandler,
  }) {
    controller.callHandler(method, handler: callback);
  }

  static void _callHandlerWithArgs(
    DWebViewController controller,
    String method,
    dynamic args, {
    OnReturnValue callback = _defHandler,
  }) {
    controller.callHandler(method, args: [args], handler: callback);
  }

  String _getRes(dynamic data) {
    return jsonEncode({"data": data});
  }

  String _getErrorRes(String error) {
    return jsonEncode({"error": error});
  }
}
