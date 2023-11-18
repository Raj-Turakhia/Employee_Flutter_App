import 'package:employee_app/app_view.dart';
import 'package:employee_app/bloc/employee_bloc.dart';
import 'package:employee_app/services/database/repository/employee_repository.dart';
import 'package:employee_app/services/router/bloc/router_bloc.dart';
import 'package:employee_app/services/router/router_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({
    Key? key,
    required this.routerService,
    required this.employeeRepository,
  }) : super(key: key);

  final AppRouterService routerService;
  final EmployeeRepository employeeRepository;

  // This is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: routerService),
        RepositoryProvider.value(value: employeeRepository)
      ],
      child: ScreenUtilInit(
        designSize: const Size(408, 798),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => RouterBloc(routerService),
            ),
            BlocProvider(
              create: (_) =>
                  EmployeeBloc(employeeRepository: employeeRepository)
                    ..add(const FetchEmployeeListEvent()),
            ),
          ],
          child: AppView(),
        ),
      ),
    );
  }
}
