import 'package:dsbridge_flutter/dsbridge_flutter.dart';
import 'package:event_bus/event_bus.dart';

typedef BusEventListener = void Function(BusEvent event)?;

class EventBusService {
  late EventBus _eventBus;

  EventBusService._() {
    _eventBus = EventBus();
  }

  static EventBusService? _instance;

  static EventBusService get i => _instance ??= EventBusService._();

  void register(BusEventListener listener) {
    _eventBus.on<BusEvent>().listen(listener);
  }

  void post(BusEvent event) {
    _eventBus.fire(event);
  }

  void destroy() {
    _eventBus.destroy();
  }
}

class BusEvent {
  final String? msg;
  final MethodType? methodType;
  final CompletionHandler? handler;

  BusEvent(this.msg, this.methodType, this.handler);

  @override
  String toString() {
    return 'BusEvent{msg: $msg, methodType: $methodType, handler: $handler}';
  }
}

enum MethodType {
  LAUNCH_GAME,
  GET_USER_INFO,
  LOGOUT,
  DEACTIVATE_ACCOUNT,
  AD_SHOW,
  SEND_PROGRESS,
  GAME_LOADED,
  SHOW_LOGIN,
  SHOW_RED_PACK_ANIM,
  LAUNCH_WITHDRAW_PAGE,
  SHOW_CLOSE_GAME_DIALOG,
  FINISH_CURRENT_PAGE,
  LOGIN_SUCCEED,
  H5_PAGE_LAUNCHED,
}
