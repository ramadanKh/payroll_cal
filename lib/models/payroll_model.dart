class PayrollResult {
  final double grossSalary;
  final double tax;
  final double netSalary;
  final double taxPercent;

  PayrollResult({
    required this.grossSalary,
    required this.tax,
    required this.netSalary,
    required this.taxPercent,
  });
}
