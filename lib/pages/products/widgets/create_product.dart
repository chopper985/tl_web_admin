import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tl_web_admin/constants/controllers.dart';
import 'package:tl_web_admin/helpers/reponsiveness.dart';
import 'package:tl_web_admin/widgets/custom_text.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({Key key}) : super(key: key);

  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Center(
            child: Text('Create New Product'),
          ),
          BuildTextField(titleController, placeholder: 'Ex: Converse Classic'),
          BuildTextField(typeController, placeholder: 'Ex: Men'),
          BuildTextField(descriptionController, placeholder: 'Ex: Color'),
          BuildTextField(priceController,
              placeholder: 'Ex: 100', suffixText: '\$'),
          BuildTextField(imageUrlController, placeholder: 'Ex: url'),
        ]);
  }
}

Padding BuildTextField(TextEditingController nameController,
    {Widget icon,
    String suffixText,
    TextInputType tyle,
    String vali,
    String placeholder,
    Function() handle}) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      child: TextFormField(
        keyboardType: tyle,
        onTap: handle,
        controller: nameController,
        validator: (val) => val.trim().length == 0 ? 'Do not empty' : null,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          fillColor: Colors.black,
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
          ),
          suffixText: suffixText,
          prefixIcon: icon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.normal,
            letterSpacing: 0.5,
          ),
        ),
      ));
}
