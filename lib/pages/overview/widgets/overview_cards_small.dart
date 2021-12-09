import 'package:flutter/material.dart';
import 'package:tl_web_admin/providers/order.dart';
import 'package:provider/provider.dart';
import 'info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final order = Provider.of<Order>(context);

    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "Ordered",
            value: order.listOrdered.length.toString(),
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Packages Delivered",
            value: order.listPacked.length.toString(),
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "In Transit",
            value: order.listIntransit.length.toString(),
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Delivered",
            value: order.listDelivered.length.toString(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
