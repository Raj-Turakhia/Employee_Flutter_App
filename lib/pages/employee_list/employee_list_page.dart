import 'package:employee_app/pages/employee_list/employee_list_screen.dart';
import 'package:flutter/material.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EmployeeListPage());
  }
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  Widget build(BuildContext context) {
    return const EmployeeListScreen();
  }
}
