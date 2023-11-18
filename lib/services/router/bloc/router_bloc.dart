import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employee_app/services/router/bloc/router_event.dart';
import 'package:employee_app/services/router/bloc/router_state.dart';
import 'package:employee_app/services/router/router_service.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc(this._routerService) : super(RouterState()) {
    on<RouteChanged>(_onRouteChanged);
    _routeToScreenSubscription = _routerService.route.listen(
      (route) => add(RouteChanged(route)),
    );
  }

  final AppRouterService _routerService;
  late StreamSubscription<ScreenRoute> _routeToScreenSubscription;

  @override
  Future<void> close() {
    return super.close();
  }

  void _onRouteChanged(RouteChanged event, Emitter<RouterState> emit) {
    emit(RouterState(route: event.route));
  }
}
