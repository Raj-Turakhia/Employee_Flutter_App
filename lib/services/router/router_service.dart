import 'dart:async';

enum RouteToScreen {
  home,
  addEmployee,
  pop,
}

class ScreenRoute {
  const ScreenRoute(
      {required this.routeToScreen, this.arguments, this.popAndPush = false});

  final RouteToScreen routeToScreen;
  final Object? arguments;
  final bool popAndPush;
}

abstract class RouterService {
  Stream<ScreenRoute> get route;

  void routeTo(ScreenRoute route);
}

class AppRouterService extends RouterService {
  final _controller = StreamController<ScreenRoute>();

  AppRouterService();

  void dispose() => _controller.close();

  @override
  void routeTo(ScreenRoute route) {
    _controller.add(route);
  }

  @override
  Stream<ScreenRoute> get route async* {
    yield const ScreenRoute(routeToScreen: RouteToScreen.home);
    yield* _controller.stream;
  }
}
