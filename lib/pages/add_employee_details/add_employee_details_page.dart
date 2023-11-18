import 'package:employee_app/pages/add_employee_details/add_employee_details_screen.dart';
import 'package:flutter/material.dart';

class AddEmployeeDetailsPage extends StatefulWidget {
  const AddEmployeeDetailsPage({Key? key}) : super(key: key);

  @override
  State<AddEmployeeDetailsPage> createState() => _EmployeeListPageState();

  static Route<void> route(Object? arguments) {
    return MaterialPageRoute<void>(
      builder: (_) => const AddEmployeeDetailsPage(),
      settings: RouteSettings(
        arguments: arguments,
      ),
    );
  }
}

class _EmployeeListPageState extends State<AddEmployeeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return const AddEmployeeDetailsScreen();
  }
}
