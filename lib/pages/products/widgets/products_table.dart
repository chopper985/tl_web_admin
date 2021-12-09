import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tl_web_admin/constants/style.dart';
import 'package:tl_web_admin/providers/product.dart';
import 'package:tl_web_admin/providers/products.dart';
import 'package:tl_web_admin/widgets/custom_text.dart';
import 'package:provider/provider.dart';

/// Example without datasource
class ProductsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
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
        child: FutureBuilder<List<Product>>(
            future: product.fetchProducts(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Container()
                  : DataTable2(
                      dataRowHeight: 100,
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 600,
                      columns: [
                        DataColumn2(
                          label: Text("Products Name"),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('Type'),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(
                          label: Text('Description'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('Price'),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(
                          label: Text('Image'),
                          size: ColumnSize.L,
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          snapshot.data.length,
                          (index) => DataRow(cells: [
                                DataCell(CustomText(
                                    text: snapshot.data[index].title)),
                                DataCell(CustomText(
                                    text: snapshot.data[index].type)),
                                DataCell(CustomText(
                                    text: snapshot.data[index].description)),
                                DataCell(Row(
                                  children: [
                                    CustomText(
                                        text: snapshot.data[index].price
                                                .toString() +
                                            '\$'),
                                  ],
                                )),
                                DataCell(CustomText(
                                    text: snapshot.data[index].imageUrl)),
                              ])));
            }));
  }
}
