import 'package:amazone_clone/common/widgets/loader.dart';
import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/features/accounts/services/order_services.dart';
import 'package:amazone_clone/features/accounts/widgets/single_products.dart';
import 'package:amazone_clone/features/order_details/screens/order_details.dart';
import 'package:amazone_clone/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final OrderServices orderServices = OrderServices();
  List<Order>? orderList;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orderList = await orderServices.fetchOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderList == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Oders',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 20),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: GlobalVariable.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: orderList!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetails.routeName,
                          arguments: orderList![index],
                        );
                      },
                      child: SingleProduct(
                          src: orderList![index].products[0].images[0]),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
