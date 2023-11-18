import 'package:employee_app/bloc/employee_bloc.dart';
import 'package:employee_app/constants/constants.dart';
import 'package:employee_app/constants/string_constants.dart';
import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/core/context_extension.dart';
import 'package:employee_app/pages/employee_list/widgets/employee_list_view.dart';
import 'package:employee_app/services/database/models/employee.dart';
import 'package:employee_app/services/router/bloc/router_bloc.dart';
import 'package:employee_app/services/router/bloc/router_event.dart';
import 'package:employee_app/services/router/router_service.dart';
import 'package:employee_app/widget/common_image_text_widget.dart';
import 'package:employee_app/widget/common_text.dart';
import 'package:employee_app/widget/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
        titleText: StringConstants.employeeList,
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoadedState) {
            return state.currentEmployeeList.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        EmployeeListView(
                          employeeList: state.currentEmployeeList,
                          headerTitle: StringConstants.currentEmployees,
                          onTap: (Employee value) {
                            context.read<RouterBloc>().add(
                                  RouteChanged(
                                    ScreenRoute(
                                      routeToScreen: RouteToScreen.addEmployee,
                                      arguments: value,
                                    ),
                                  ),
                                );
                          },
                        ),
                        if (state.previousEmployeeList.isNotEmpty)
                          EmployeeListView(
                            employeeList: state.previousEmployeeList,
                            headerTitle: StringConstants.previousEmployees,
                            onTap: (Employee value) {
                              context.read<RouterBloc>().add(
                                    RouteChanged(
                                      ScreenRoute(
                                        routeToScreen:
                                            RouteToScreen.addEmployee,
                                        arguments: value,
                                      ),
                                    ),
                                  );
                            },
                          ),
                      ],
                    ),
                  )
                : const Center(
                    child: CommonImageTextWidget(
                      icon: AppConstants.IMG_NO_EMPLOYEE,
                      title: StringConstants.noEmployeeFound,
                    ),
                  );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoadedState) {
            return state.currentEmployeeList.isNotEmpty
                ? Container(
                    padding: EdgeInsets.only(
                      bottom: context.getHeightByPercentage(5.51),
                      top: context.getHeightByPercentage(1.5),
                      left: context.getWidthByPercentage(3.92),
                    ),
                    color: ThemeConstants.dividerColor,
                    child: const CommonText(
                        text: StringConstants.swipeToDelete,
                        fontColor: ThemeConstants.textColor,
                        fontWeight: FontWeight.w400),
                  )
                : const SizedBox.shrink();
          }
          return Container();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: context.getHeightByPercentage(2.26),
        ),
        child: SizedBox(
          width: context.getWidthByPercentage(12.25),
          height: context.getHeightByPercentage(6.26),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            onPressed: () {
              context.read<RouterBloc>().add(const RouteChanged(
                  ScreenRoute(routeToScreen: RouteToScreen.addEmployee)));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
