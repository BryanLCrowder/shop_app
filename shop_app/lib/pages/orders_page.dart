import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../providers/orders.dart';
import '../widgets/app_drawer.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: const Text("Your Orders")),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, i) =>
                      OrderItems(order: orderData.orders[i]),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          },
        )
        // _isLoading ? const Center(child:  CircularProgressIndicator()) : ListView.builder(
        //   itemBuilder: (ctx, i) => OrderItems(order: orderData.orders[i]),
        //   itemCount: orderData.orders.length,
        // ),
        );
  }
}
