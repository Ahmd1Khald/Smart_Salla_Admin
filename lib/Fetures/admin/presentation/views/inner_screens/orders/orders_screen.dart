import 'package:flutter/material.dart';

import '../../../../../../Core/consts/app_strings.dart';
import '../../../../../../Core/services/assets_manager.dart';
import '../../../../../../Core/widgets/empty_bag.dart';
import '../../../../../../Core/widgets/title_text.dart';
import 'orders_widget.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({Key? key}) : super(key: key);

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(
            label: AppStrings.placedOrderString,
          ),
        ),
        body: isEmptyOrders
            ? EmptyBagWidget(
                imagePath: AssetsImages.orderBag,
                title: AppStrings.noPlacedOrderString,
                subtitle: "",
              )
            : ListView.separated(
                itemCount: 15,
                itemBuilder: (ctx, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: OrdersWidgetFree(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ));
  }
}
