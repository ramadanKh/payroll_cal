import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/payroll_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final salaryController = TextEditingController();
  final payrollService = PayrollService();

  double? gross;
  double? tax;
  double? taxP;
  double? net;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Payroll & Tax Calculator"),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: salaryController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter Gross Salary",
                        prefixIcon: Icon(Icons.monetization_on_outlined),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        double salary =
                            double.tryParse(salaryController.text) ?? 0;

                        var result = payrollService.calculate(salary);

                        setState(() {
                          gross = result.grossSalary;
                          tax = result.tax;
                          taxP = result.taxPercent;
                          net = result.netSalary;
                        });
                      },
                      child: const Text(
                        "Calculate",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (gross != null)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Results",
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                      ,

                      const SizedBox(height: 10),

                      buildResultRow("Gross Salary:", gross!),
                      buildResultRow("Tax:", tax!),
                      buildResultRow("Tax Percentage:", taxP!),
                      buildResultRow("Net Salary:", net!),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildResultRow(String title, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text("${value.toStringAsFixed(2)} \$"),
        ],
      ),
    );
  }
}
