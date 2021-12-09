import 'package:flutter/material.dart';
import 'package:tl_web_admin/constants/controllers.dart';
import 'package:tl_web_admin/helpers/reponsiveness.dart';
import 'package:tl_web_admin/pages/orders/widgets/orders_table.dart';
import 'package:tl_web_admin/pages/orders/widgets/orders_widget.dart';
import 'package:tl_web_admin/pages/overview/widgets/info_card.dart';
import 'package:tl_web_admin/providers/order.dart';
import 'package:tl_web_admin/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = false;
  bool _isInit = true;
  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      Provider.of<Order>(context)
          .fetchAllOrder()
          .then((_) => _isLoading = false);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);
    double _width = MediaQuery.of(context).size.width;
    final _status = order.status;

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              top: ResponsiveWidget.isSmallScreen(context)
                                  ? 56
                                  : 6),
                          child: CustomText(
                            text: menuController.activeItem.value,
                            size: 24,
                            weight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    SizedBox(
                      height: _width / 64,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            InfoOrderCard(
                              title: "All",
                              value: '',
                              onTap: () {
                                order.setStatus('All');
                              },
                              topColor: Colors.grey,
                            ),
                            SizedBox(
                              width: _width / 64,
                            ),
                            InfoOrderCard(
                              title: "Ordered",
                              value: '',
                              onTap: () {
                                order.setStatus('Ordered');
                              },
                              topColor: Colors.orange,
                            ),
                            SizedBox(
                              width: _width / 64,
                            ),
                            InfoOrderCard(
                              title: "Packages Delivered",
                              value: '',
                              topColor: Colors.lightGreen,
                              onTap: () {
                                order.setStatus('Packed');
                              },
                            ),
                            SizedBox(
                              width: _width / 64,
                            ),
                            InfoOrderCard(
                              title: "In Transit",
                              value: '',
                              topColor: Colors.brown,
                              onTap: () {
                                order.setStatus('In transit');
                              },
                            ),
                            SizedBox(
                              width: _width / 64,
                            ),
                            InfoOrderCard(
                              title: "Delivered",
                              value: '',
                              onTap: () {
                                order.setStatus('Delivered');
                              },
                            ),
                            SizedBox(
                              width: _width / 64,
                            ),
                            InfoOrderCard(
                              title: "Cancel",
                              topColor: Colors.redAccent,
                              value: '',
                              onTap: () {
                                order.setStatus('Cancel');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: _width / 128,
                    ),
                    Container(
                        height: 60,
                        width: 20,
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              (_status == 'Ordered' ||
                                      _status == 'In transit' ||
                                      _status == 'Packed')
                                  ? Colors.blue
                                  : Colors.grey,
                              (_status == 'Ordered' ||
                                      _status == 'In transit' ||
                                      _status == 'Packed')
                                  ? Colors.blue.withOpacity(0.6)
                                  : Colors.grey.withOpacity(0.6)
                            ]),
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            onPressed: () {
                              if (_status == 'Ordered' ||
                                  _status == 'In transit' ||
                                  _status == 'Packed') order.changeStatus();
                            },
                            child: Text('Change Status',
                                style: TextStyle(color: Colors.white)))),
                    OrdersTable()
                  ],
                )),
              ],
            ),
          );
  }
}
