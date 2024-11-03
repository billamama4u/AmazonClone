import 'package:amazone_clone/common/widgets/loader.dart';
import 'package:amazone_clone/features/accounts/widgets/single_products.dart';
import 'package:amazone_clone/features/admin/services/admin_service.dart';
import 'package:amazone_clone/features/order_details/screens/order_details.dart';
import 'package:amazone_clone/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreeen extends StatefulWidget {
  const OrdersScreeen({super.key});

  @override
  State<OrdersScreeen> createState() => _OrdersScreeenState();
}

class _OrdersScreeenState extends State<OrdersScreeen> {
  final AdminService adminService = AdminService();
  List<Order>? orderList;

  @override
  void initState() {
    super.initState();
    getAllOrders();
  }

  void getAllOrders() async {
    orderList = await adminService.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? const Loader()
        : GridView.builder(
            itemCount: orderList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final orderData = orderList![index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetails.routeName,
                    arguments: orderData,
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(src: orderData.products[0].images[0]),
                ),
              );
            },
          );
  }
}
