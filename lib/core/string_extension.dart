extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
  bool isNullOrEmpty() {
    return ["", null].contains(this);
  }
}
