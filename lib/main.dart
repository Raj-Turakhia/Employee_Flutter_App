import 'package:employee_app/employee_app.dart';
import 'package:employee_app/services/database/repository/employee_repository.dart';
import 'package:employee_app/services/router/router_service.dart';
import 'package:flutter/material.dart';

void main() {
  var appRouterService = AppRouterService();
  runApp(EmployeeApp(
    routerService: appRouterService,
    employeeRepository: EmployeeRepository.db,
  ));
}
