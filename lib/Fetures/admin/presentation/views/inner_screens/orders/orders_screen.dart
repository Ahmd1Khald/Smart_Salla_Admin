import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../Core/widgets/title_text.dart';
import '../../../../data/models/order_model.dart';
import '../../../controller/providers/order_provider.dart';
import 'orders_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(
            label: 'Placed orders',
          ),
        ),
        body: FutureBuilder<List<OrdersModel>>(
          future: ordersProvider.fetchOrder(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: SelectableText(
                    "An error has been occured ${snapshot.error}"),
              );
            } else if (snapshot.data == null ||
                ordersProvider.getOrders.isEmpty) {
              return const Center(
                  child: TitlesTextWidget(
                label: "No Orders found",
                fontSize: 40,
              ));
            }
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrdersWidgetFree(
                    ordersModelAdvanced: ordersProvider.getOrders[index],
                    func: () async {
                      await ordersProvider.clearOrderFromFirebase(
                          orderId: ordersProvider.getOrders[index].orderId);
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }),
        ));
  }
}
