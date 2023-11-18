import 'package:employee_app/services/router/bloc/router_bloc.dart';
import 'package:employee_app/services/router/bloc/router_event.dart';
import 'package:employee_app/services/router/router_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar(
      {this.titleText, this.isLeading = false, this.actions, super.key});

  final String? titleText;
  final bool isLeading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(titleText ?? '',
            style: TextStyle(color: Colors.white, fontSize: 18.sp)),
        leading: isLeading
            ? BackButton(
                color: Colors.white,
                onPressed: () {
                  context.read<RouterBloc>().add(const RouteChanged(
                      ScreenRoute(routeToScreen: RouteToScreen.pop)));
                },
              )
            : null,
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
