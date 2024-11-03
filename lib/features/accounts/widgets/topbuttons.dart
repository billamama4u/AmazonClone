import 'package:amazone_clone/features/accounts/widgets/topbutton.dart';
import 'package:amazone_clone/features/homescreen/Services/homeservices.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final Homeservices homeservices = Homeservices();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Orders', onTap: () {}),
            AccountButton(text: 'Turn Seller', onTap: () {})
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
                text: 'Log Out',
                onTap: () {
                  homeservices.logOut(context);
                }),
            AccountButton(text: 'Your Wishlist', onTap: () {})
          ],
        )
      ],
    );
  }
}
