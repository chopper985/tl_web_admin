import 'package:flutter/material.dart';
import 'package:tl_web_admin/pages/overview/widgets/info_card.dart';
import 'package:tl_web_admin/providers/order.dart';
import 'package:provider/provider.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final order = Provider.of<Order>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: "Ordered",
              value: order.listOrdered.length.toString(),
              onTap: () {},
              topColor: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Packages Delivered",
              value: order.listPacked.length.toString(),
              topColor: Colors.lightGreen,
              onTap: () {},
            ),
          ],
        ),
        SizedBox(
          height: _width / 64,
        ),
        Row(
          children: [
            InfoCard(
              title: "In Transit",
              value: order.listIntransit.length.toString(),
              topColor: Colors.redAccent,
              onTap: () {},
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Delivered",
              value: order.listDelivered.length.toString(),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
