import 'package:amazone_clone/common/widgets/loader.dart';
import 'package:amazone_clone/features/homescreen/Services/homeservices.dart';
import 'package:amazone_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:flutter/material.dart';

class Dealoftheday extends StatefulWidget {
  const Dealoftheday({super.key});

  @override
  State<Dealoftheday> createState() => _DealofthedayState();
}

class _DealofthedayState extends State<Dealoftheday> {
  final Homeservices homeService = Homeservices();
  Product? product;

  @override
  void initState() {
    super.initState();
    fetchDOD();
  }

  fetchDOD() async {
    product = await homeService.fetchDOTDProduct(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ProductDetailScreen.routeName,
                    arguments: product,
                  );
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the Day',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: const Text(
                        '\$100',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text(
                        'Lund',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images
                              .map(
                                (e) => Image.network(
                                  e,
                                  fit: BoxFit.fitWidth,
                                  width: 100,
                                  height: 100,
                                ),
                              )
                              .toList()),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(color: Colors.cyan[800]),
                      ),
                    )
                  ],
                ),
              );
  }
}
