import 'package:amazone_clone/common/widgets/bottombar.dart';
import 'package:amazone_clone/features/address/screencs/address.dart';
import 'package:amazone_clone/features/admin/screen/add_product_screen.dart';
import 'package:amazone_clone/features/auth/authscreens/authscreen.dart';
import 'package:amazone_clone/features/homescreen/Screens/categoryscreen.dart';
import 'package:amazone_clone/features/homescreen/Screens/homescreen.dart';
import 'package:amazone_clone/features/order_details/screens/order_details.dart';
import 'package:amazone_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazone_clone/features/search/screens/searchscreen.dart';
import 'package:amazone_clone/models/order.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routesettings) {
  switch (routesettings.name) {
    case Authscreen.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => const Authscreen());

    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => const HomeScreen());

    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routesettings, builder: (_) => const AddProductScreen());

    case CategoryDealScreen.routeName:
      var category = routesettings.arguments as String;
      return MaterialPageRoute(
          settings: routesettings,
          builder: (_) => CategoryDealScreen(
                category: category,
              ));
    case SearchScreen.routeName:
      var searchQuery = routesettings.arguments as String;
      return MaterialPageRoute(
          settings: routesettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    case ProductDetailScreen.routeName:
      var products = routesettings.arguments as Product;
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => ProductDetailScreen(
          product: products,
        ),
      );
    case AddressScreen.routeName:
      var totalAmounts = routesettings.arguments as String;
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmounts,
        ),
      );
    case OrderDetails.routeName:
      var order = routesettings.arguments as Order;
      return MaterialPageRoute(
        settings: routesettings,
        builder: (_) => OrderDetails(
          order: order,
        ),
      );

    default:
      return MaterialPageRoute(
          settings: routesettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("Page Does not Exist!!"),
                ),
              ));
  }
}
