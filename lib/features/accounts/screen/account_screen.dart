import 'package:amazone_clone/constants/global_variabl.dart';
import 'package:amazone_clone/features/accounts/widgets/below_app_bar.dart';
import 'package:amazone_clone/features/accounts/widgets/orders.dart';
import 'package:amazone_clone/features/accounts/widgets/topbuttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariable.appBarGradient,
              ),
            ),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/amazon_in.png',
                      width: 120,
                      height: 40,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(Icons.notifications_outlined),
                          ),
                          Icon(Icons.search),
                        ],
                      ))
                ])),
      ),
      body: const Column(
        children: [
          BelowAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(
            height: 20,
          ),
          Orders(),
        ],
      ),
    );
  }
}
