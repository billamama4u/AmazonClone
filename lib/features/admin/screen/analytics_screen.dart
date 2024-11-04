import 'package:amazone_clone/common/widgets/loader.dart';
import 'package:amazone_clone/features/admin/models/sales.dart';
import 'package:amazone_clone/features/admin/services/admin_service.dart';
import 'package:amazone_clone/features/admin/widgets/earning_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminService adminService = AdminService();
  int? totalSales;
  List<Sales>? earnings;
  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  void getEarnings() async {
    var earningData = await adminService.fetchAnalytics(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                'Total Sales: \$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              EarningChart(
                sales: earnings,
              ),
            ],
          );
  }
}
