import '../models/payroll_model.dart';
class PayrollService {
  PayrollResult calculate(double salary) {
    double taxPercent = 0;

    if (salary <= 3000) {
      taxPercent = 5;
    } else if (salary <= 6000) {
      taxPercent = 10;
    } else if (salary <= 10000) {
      taxPercent = 15;
    } else {
      taxPercent = 20;
    }

    double tax = salary * (taxPercent / 100);
    double netSalary = salary - tax;

    return PayrollResult(
      grossSalary: salary,
      tax: tax,
      netSalary: netSalary,
      taxPercent: taxPercent,
    );
  }
}