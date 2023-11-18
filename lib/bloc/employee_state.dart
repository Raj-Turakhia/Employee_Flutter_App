part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {
  final int? id;

  const EmployeeInitial({this.id});

  @override
  List<Object?> get props => [id];
}

class EmployeeLoadedState extends EmployeeState {
  final List<Employee> currentEmployeeList;
  final List<Employee> previousEmployeeList;

  const EmployeeLoadedState(
      {required this.currentEmployeeList, required this.previousEmployeeList});

  @override
  List<Object?> get props => [currentEmployeeList, previousEmployeeList];

  EmployeeLoadedState copyWith(
      {List<Employee>? currentEmployeeList,
      List<Employee>? previousEmployeeList}) {
    return EmployeeLoadedState(
      currentEmployeeList: currentEmployeeList ?? this.currentEmployeeList,
      previousEmployeeList: previousEmployeeList ?? this.previousEmployeeList,
    );
  }
}
