import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tl_web_admin/constants/style.dart';
import 'package:tl_web_admin/providers/order.dart';
import 'package:tl_web_admin/providers/order_item.dart';
import 'package:tl_web_admin/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class OrdersTable extends StatefulWidget {
  @override
  State<OrdersTable> createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
  List<OrderItem> selectOrder = [];

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);
    final snapshotData = order.listDefautl;
    final status = order.status;
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
        child: DataTable2(
            onSelectAll: (val) => {
                  for (int i = 0; i < snapshotData.length; i++)
                    {order.addSelect(val, snapshotData[i])},
                  print(order.listSelect.length)
                },
            dataRowHeight: 100,
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            showCheckboxColumn: true,
            columns: [
              DataColumn(
                label: Text('Status'),
              ),
              DataColumn(
                label: Text('Customer Name'),
              ),
              DataColumn(
                label: Text('Phone number'),
              ),
              DataColumn(
                label: Text('Date'),
              ),
              DataColumn2(
                label: Text('Address'),
                size: ColumnSize.L,
              ),
              DataColumn2(
                label: Text("List Product"),
                size: ColumnSize.L,
              ),
            ],
            rows: List<DataRow>.generate(
                snapshotData.length,
                (index) => DataRow(
                        selected:
                            order.listSelect.contains(snapshotData[index]),
                        onSelectChanged: (status == 'Ordered' ||
                                status == 'In transit' ||
                                status == 'Packed')
                            ? (val) {
                                order.addSelect(val, snapshotData[index]);
                              }
                            : null,
                        cells: [
                          DataCell(
                              CustomText(text: snapshotData[index].status)),
                          DataCell(
                              CustomText(text: snapshotData[index].userName)),
                          DataCell(CustomText(
                              text: snapshotData[index].phoneNumber)),
                          DataCell(CustomText(
                              text: snapshotData[index]
                                  .dateTime
                                  .toIso8601String())),
                          DataCell(
                              CustomText(text: snapshotData[index].address)),
                          DataCell(ListView.builder(
                            itemBuilder: (context, index) => Text('>' +
                                snapshotData[index].productsOrder[index].title),
                            itemCount: snapshotData[index].productsOrder.length,
                          )),
                          // DataCell(Row(children: [
                          //   IconButton(onPressed: (){}, icon: Icon(Icons.c
                          // ],)),
                        ]))));
  }
}
