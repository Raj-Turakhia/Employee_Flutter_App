class DummyEmployee {
  final String name;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;
  DummyEmployee({
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  });
}
