import 'dart:async';

import 'package:employee_app/services/database/models/employee.dart';
import 'package:employee_app/services/database/repository/employee_repository.dart';
import 'package:employee_app/utils/date_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'employee_event.dart';

part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required this.employeeRepository})
      : super(const EmployeeInitial()) {
    on<FetchEmployeeListEvent>(_fetchEmployeeList);
    on<AddEmployeeDetailEvent>(_addEmployeeDetails);
    on<UpdateEmployeeDetailEvent>(_updateEmployeeDetails);
    on<DeleteEmployeeDetailEvent>(_deleteEmployeeDetails);
  }

  final EmployeeRepository employeeRepository;

  Future<void> _addEmployeeDetails(
    AddEmployeeDetailEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    var id = await EmployeeRepository.db.addEmployee(event.employee);
    final state = this.state;
    if (state is EmployeeLoadedState) {
      fetchEmployeeData();
    }
  }

  Future<void> _deleteEmployeeDetails(
    DeleteEmployeeDetailEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    await EmployeeRepository.db.deleteEmployee(event.employee);
    final state = this.state;
    if (state is EmployeeLoadedState) {
      var currentEmployeeList = [...state.currentEmployeeList];
      var previousEmployeeList = [...state.previousEmployeeList];
      int index = state.currentEmployeeList
          .indexWhere((element) => element.id == event.employee.id);
      if (index == -1) {
        index = state.previousEmployeeList
            .indexWhere((element) => element.id == event.employee.id);
        previousEmployeeList.removeAt(index);
      } else {
        currentEmployeeList.removeAt(index);
      }

      emit(
        state.copyWith(
          currentEmployeeList: [...currentEmployeeList],
          previousEmployeeList: [...previousEmployeeList],
        ),
      );
    }
  }

  Future<void> _fetchEmployeeList(
    FetchEmployeeListEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    fetchEmployeeData();
  }

  fetchEmployeeData() async {
    var employeeList = await EmployeeRepository.db.fetchEmployees();
    final currentEmployeeList = employeeList.where((element) {
      if (element.endDate != null) {
        DateTime date = DateHelper.dateDisplayFormat.parse(element.endDate!);
        return date.isAfter(DateTime.now());
      } else {
        return element.endDate == null;
      }
    }).toList();
    final previousEmployeeList = employeeList.where((element) {
      if (element.endDate != null) {
        DateTime date = DateHelper.dateDisplayFormat.parse(element.endDate!);
        return date.isBefore(DateTime.now());
      } else {
        return false;
      }
    }).toList();

    emit(
      EmployeeLoadedState(
        currentEmployeeList: [...currentEmployeeList],
        previousEmployeeList: [...previousEmployeeList],
      ),
    );
  }

  Future<void> _updateEmployeeDetails(
    UpdateEmployeeDetailEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    var id = await EmployeeRepository.db.updateEmployee(event.employee);
    final state = this.state;
    if (state is EmployeeLoadedState) {
      var currentEmployeeList = [...state.currentEmployeeList];
      var previousEmployeeList = [...state.previousEmployeeList];
      int index = state.currentEmployeeList
          .indexWhere((element) => element.id == event.employee.id);
      if (index == -1) {
        index = state.previousEmployeeList
            .indexWhere((element) => element.id == event.employee.id);
        previousEmployeeList[index] = event.employee.copyWith();
      } else {
        currentEmployeeList[index] = event.employee.copyWith();
      }

      emit(
        state.copyWith(
          currentEmployeeList: [...currentEmployeeList],
          previousEmployeeList: [...previousEmployeeList],
        ),
      );
      // fetchEmployeeData();
    }
  }
}
