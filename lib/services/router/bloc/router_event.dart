import 'package:employee_app/services/router/router_service.dart';
import 'package:equatable/equatable.dart';

abstract class RouterEvent extends Equatable {
  const RouterEvent();

  @override
  List<Object?> get props => [];
}

class RouteChanged extends RouterEvent {
  const RouteChanged(this.route);

  final ScreenRoute route;

  @override
  List<Object?> get props => [route];
}
