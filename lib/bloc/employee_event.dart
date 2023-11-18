part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

final class AddEmployeeDetailEvent extends EmployeeEvent {
  const AddEmployeeDetailEvent({required this.employee});

  final Employee employee;

  @override
  List<Object?> get props => [employee];
}

final class FetchEmployeeListEvent extends EmployeeEvent {
  const FetchEmployeeListEvent();

  @override
  List<Object?> get props => [];
}

final class DeleteEmployeeDetailEvent extends EmployeeEvent {
  const DeleteEmployeeDetailEvent({required this.employee});

  final Employee employee;

  @override
  List<Object?> get props => [employee];
}

final class UpdateEmployeeDetailEvent extends EmployeeEvent {
  const UpdateEmployeeDetailEvent({required this.employee});

  final Employee employee;

  @override
  List<Object?> get props => [employee];
}
