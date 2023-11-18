import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/core/context_extension.dart';
import 'package:employee_app/pages/add_employee_details/add_employee_details_page.dart';
import 'package:employee_app/pages/employee_list/employee_list_page.dart';
import 'package:employee_app/services/router/bloc/router_bloc.dart';
import 'package:employee_app/services/router/router_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'services/router/bloc/router_state.dart';

class AppView extends StatefulWidget {
  AppView({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  NavigatorState get _navigator => AppView.navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppView.navigatorKey,
      title: 'Employee',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme:
            const AppBarTheme(backgroundColor: ThemeConstants.primaryColor),
        buttonTheme:
            const ButtonThemeData(buttonColor: ThemeConstants.primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r)),
                backgroundColor: ThemeConstants.primaryColor,
                // padding: EdgeInsets.symmetric(
                //     vertical: context.getHeightByPercentage(1.88)),
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.grey)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: ThemeConstants.primaryColor,
            foregroundColor: Colors.white),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r)),
                side: const BorderSide(color: ThemeConstants.primaryColor),
                foregroundColor: ThemeConstants.primaryColor,
                padding: EdgeInsets.symmetric(
                    vertical: context.getHeightByPercentage(1.88)))),
      ),
      builder: (context, child) {
        final List<RouterState> previousTenStates = [];
        return MultiBlocListener(
          listeners: [
            BlocListener<RouterBloc, RouterState>(
                listener: (context, state) async {
              switch (state.route.routeToScreen) {
                case RouteToScreen.addEmployee:
                  _navigator.push(
                      AddEmployeeDetailsPage.route(state.route.arguments));
                  break;
                case RouteToScreen.pop:
                  {
                    _navigator.pop();
                  }
                  break;
                //not needed to handled
                default:
                  break;
              }
            }),
          ],
          child: child!,
        );
      },
      onGenerateRoute: (_) => EmployeeListPage.route(),
    );
  }
}
