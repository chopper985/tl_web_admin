import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tl_web_admin/constants/controllers.dart';
import 'package:tl_web_admin/helpers/reponsiveness.dart';
import 'package:tl_web_admin/pages/orders/widgets/orders_table.dart';
import 'package:tl_web_admin/pages/orders/widgets/orders_widget.dart';
import 'package:tl_web_admin/providers/order.dart';
import 'package:tl_web_admin/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = false;
  bool _isInit = true;
  DateTime selectedDate = DateTime.now();
  DateFormat formatDate = DateFormat('dd/MM/yyyy');
  TextEditingController dateController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
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

  Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: dateController.text.isEmpty
          ? DateTime.now().add(Duration(seconds: 1))
          : this.selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now());
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);
    double _width = MediaQuery.of(context).size.width;
    final _status = order.status;

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: _formkey,
            child: Container(
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
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                                height: 58,
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
                                          _status == 'Packed')
                                        order.changeStatus();
                                    },
                                    child: Text('Change Status',
                                        style:
                                            TextStyle(color: Colors.white)))),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: TextFormField(
                                  readOnly: true,
                                  keyboardType: TextInputType.datetime,
                                  controller: dateController,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: Colors.black,
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.5,
                                    ),
                                    suffixIcon: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 5, 0),
                                          child: Text(dateController.text,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                              )),
                                        ),
                                        Spacer(),
                                        if (dateController.text.isNotEmpty)
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  dateController.text = '';
                                                });
                                              },
                                              icon: Icon(Icons.close,
                                                  color: Colors.red)),
                                        IconButton(
                                          icon: Icon(Icons.calendar_today),
                                          onPressed: () async {
                                            final selectedDate =
                                                await _selectDateTime(context);
                                            if (selectedDate != null) {
                                              setState(() {
                                                this.selectedDate = DateTime(
                                                  selectedDate.year,
                                                  selectedDate.month,
                                                  selectedDate.day,
                                                );
                                                dateController.text = formatDate
                                                    .format(this.selectedDate);
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1)),
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                )),
                          ),
                          Expanded(child: Container(), flex: 13)
                        ],
                      ),
                      OrdersTable(
                        date: dateController.text,
                      )
                    ],
                  )),
                ],
              ),
            ),
          );
  }
}
