import 'package:dsbridge_flutter/dsbridge_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ohos_demo/event_bus_service.dart';
import 'package:flutter_ohos_demo/js_to_native.dart';
import 'package:flutter_ohos_demo/native_to_js.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_ohos/webview_flutter_ohos.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class JsCallDartPage extends StatefulWidget {
  final String url;

  const JsCallDartPage({super.key, required this.url});

  @override
  State<JsCallDartPage> createState() => _JsCallDartPageState();
}

class _JsCallDartPageState extends State<JsCallDartPage> {
  late final DWebViewController _controller;

  @override
  void initState() {
    // #docregion platform_features
    EventBusService.i.register(_listenBusEvent);
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final DWebViewController controller =
        DWebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setBackgroundColor(Colors.white)
      // ..loadFlutterAsset('assets/js-call-dart.html')
      ..loadRequest(Uri.parse(widget.url))
      ..addJavaScriptObject(JsToNative())
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          print('process=$progress');
        },
        onPageStarted: (url) {
          print('url onPageStarted');
        },
        onPageFinished: (url) {
          print('url onPageFinished');
        },
      ));
    final platform = controller.platform;
    if (platform is OhosWebViewController) {
      OhosWebViewController.enableDebugging(true);
    } else if (platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
    }
    _controller = controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('JavaScript call Dart'),
      ),
      body: DWebViewWidget(controller: _controller),
      // floatingActionButton: favoriteButton(),
    );
  }

  void _listenBusEvent(BusEvent event) {
    switch (event.methodType) {
      case MethodType.LAUNCH_GAME:
        // TODO: Handle this case.
        break;
      case MethodType.GET_USER_INFO:
        // TODO: Handle this case.
        break;
      case MethodType.LOGOUT:
        // TODO: Handle this case.
        break;
      case MethodType.DEACTIVATE_ACCOUNT:
        // TODO: Handle this case.
        break;
      case MethodType.AD_SHOW:
        // TODO: Handle this case.
        break;
      case MethodType.SEND_PROGRESS:
        print('SEND_PROGRESS ${event.msg}');
        break;
      case MethodType.GAME_LOADED:
        NativeToJs.onResume(_controller);
        break;
      case MethodType.SHOW_LOGIN:
        // TODO: Handle this case.
        break;
      case MethodType.SHOW_RED_PACK_ANIM:
        // TODO: Handle this case.
        break;
      case MethodType.LAUNCH_WITHDRAW_PAGE:
        // TODO: Handle this case.
        break;
      case MethodType.SHOW_CLOSE_GAME_DIALOG:
        // TODO: Handle this case.
        break;
      case MethodType.FINISH_CURRENT_PAGE:
        // TODO: Handle this case.
        break;
      case MethodType.LOGIN_SUCCEED:
        // TODO: Handle this case.
        break;
      case MethodType.H5_PAGE_LAUNCHED:
        // TODO: Handle this case.
        break;
      case null:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
