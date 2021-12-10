import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tl_web_admin/constants/controllers.dart';
import 'package:tl_web_admin/helpers/reponsiveness.dart';
import 'package:tl_web_admin/pages/products/widgets/create_product.dart';
import 'package:tl_web_admin/pages/products/widgets/edit_product.dart';
import 'package:tl_web_admin/pages/products/widgets/products_table.dart';
import 'package:tl_web_admin/providers/local.dart';
import 'package:tl_web_admin/providers/order.dart';
import 'package:tl_web_admin/providers/products.dart';
import 'package:tl_web_admin/widgets/custom_text.dart';
import 'package:get/get.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  TextEditingController _keysearch = TextEditingController();
  bool _isInit = true;
  String dropdownValue = 'All';
  List<String> type = ['Men', 'Women', 'Kid'];
  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      _keysearch.text = '';
      Provider.of<Products>(context).fetchProducts();
      Provider.of<Local>(context).changeProductScreenStatus('Default');
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final local = Provider.of<Local>(context);
    final status = local.productScreenStatus;
    return Container(
        child: status == 'Default'
            ? Column(
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
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                                padding: EdgeInsets.all(8),
                                height: size.height / 14,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Colors.green,
                                      Colors.green.withOpacity(0.6)
                                    ]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                                child: TextButton(
                                    onPressed: () {
                                      local.changeProductScreenStatus('Create');
                                    },
                                    child: Text('Create New Product',
                                        style:
                                            TextStyle(color: Colors.white)))),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              height: size.height / 10,
                              child: TextField(
                                controller: _keysearch,
                                onSubmitted: (val) {
                                  setState(() {
                                    _keysearch.text = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Search ?",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 28,
                                  ),
                                  suffixIcon: _keysearch.text.length != 0
                                      ? IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            setState(() {
                                              _keysearch.text = '';
                                            });
                                          })
                                      : null,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: DropButtonCustom(context, dropdownValue,
                                  (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              })),
                          Expanded(flex: 2, child: Container())
                        ],
                      ),
                      ProductsTable(
                          keyword: _keysearch.text, type: dropdownValue)
                    ],
                  )),
                ],
              )
            : status == 'Create'
                ? CreateProduct()
                : EditProduct());
  }
}

Container DropButtonCustom(
    BuildContext context, String dropdownValue, Function(String) handle) {
  final size = MediaQuery.of(context).size;
  return Container(
    height: size.height / 14,
    child: DropdownButtonFormField<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 0,
      style: const TextStyle(color: Colors.deepPurple),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.black, width: 1)),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.5,
        ),
      ),
      onChanged: handle,
      items: <String>['All', 'Men', 'Women', 'Kid']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              value == 'All'
                  ? Icon(Icons.style_outlined, color: Colors.grey)
                  : value == 'Men'
                      ? Icon(Icons.male, color: Colors.blue)
                      : value == 'Women'
                          ? Icon(Icons.female, color: Colors.pink.shade300)
                          : Icon(Icons.child_care, color: Colors.green),
              SizedBox(
                width: 10,
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}