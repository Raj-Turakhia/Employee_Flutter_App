import 'package:employee_app/services/router/router_service.dart';
import 'package:equatable/equatable.dart';

class RouterState extends Equatable {
  RouterState(
      {this.route = const ScreenRoute(routeToScreen: RouteToScreen.home)});

  final ScreenRoute route;
  final int randomInt = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [route, randomInt];
}
