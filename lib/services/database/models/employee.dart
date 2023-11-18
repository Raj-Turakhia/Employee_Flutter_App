class Employee {
  static const IdField = 'id';
  static const NameField = 'name';
  static const RoleField = 'role';
  static const StartDateField = 'start_date';
  static const EndDateField = 'end_date';

  int? id;
  String? name;
  String? role;
  String? startDate;
  String? endDate;

  Employee({this.id, this.name, this.role, this.startDate, this.endDate});

  Employee copyWith(
      { int? id, String? name, String? role, String? startDate, String? endDate}) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,);
  }

  Map<String, dynamic> toMap() {
    return {
      IdField: id,
      NameField: name,
      RoleField: role,
      StartDateField: startDate,
      EndDateField: endDate
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(id: map[IdField],
      name: map[NameField],
      role: map[RoleField],
      startDate: map[StartDateField],
      endDate: map[EndDateField],);
  }
}
