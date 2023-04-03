// import 'dart:html';
import 'package:flutter/material.dart';
// import 'package:firebase_core_web/firebase_core_web_interop.dart';
// import 'firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:get/get.dart';
// import 'Theme/colorTheme.dart';

/*
Initial form is setup
Needs to add:
Styling from theme
fields clear on submit
Title changes to what is added in the name field after submit
form drawer closes on submit
Creates a new item add adds to list of items
Add edit button
Figure out how to add a form in a flutter bottom sheet


 */

class Item {
  int? itemId;
  String? itemName;
  String? itemType;
  String? itemSubtype;
  String? itemBrand;
  String? itemModel;
  String? itemDimensions;
  String? itemNotes;
  // File? itemImage;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemType,
    this.itemSubtype,
    this.itemBrand,
    this.itemModel,
    this.itemDimensions,
    this.itemNotes,
    // this.itemImage,
  });
}

class ItemController extends GetxController {
  var highestId = 0.obs;
  final items = <int, Item>{}.obs;

  void addItem(Item item) {
    int newId = (highestId.value + 1);
    items[item.itemId!] = item;
    highestId.value = newId;
  }
}

class ItemFormPage extends StatelessWidget {
  const ItemFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
      ),
      title: 'Material App',
      home: ItemForm(),
    );
  }
}

class ItemForm extends StatefulWidget {
  const ItemForm({Key? key}) : super(key: key);

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final itemController = Get.put(ItemController());

  // String? _itemName;
  // String? _itemType;
  // String? _itemSubtype;
  // String? _itemBrand;
  // String? _itemModel;
  // String? _itemDimensions;
  // String? _notes;
  // // File? _imageFile;

  final _itemNameController = TextEditingController();
  final _itemTypeController = TextEditingController();
  final _itemSubtypeController = TextEditingController();
  final _itemBrandController = TextEditingController();
  final _itemModelController = TextEditingController();
  final _itemDimensionsController = TextEditingController();
  final _itemColorController = TextEditingController();
  final _notesController = TextEditingController();

  // void _selectImage() async {
  //   // Add image selection logic here
  // }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemTypeController.dispose();
    _itemSubtypeController.dispose();
    _itemBrandController.dispose();
    _itemModelController.dispose();
    _itemDimensionsController.dispose();
    _itemColorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newItem = Item(
        itemId: itemController.highestId.value,
        itemName: _itemNameController.text,
        itemType: _itemTypeController.text,
        itemSubtype: _itemSubtypeController.text,
        itemBrand: _itemBrandController.text,
        itemModel: _itemModelController.text,
        itemDimensions: _itemDimensionsController.text,
        itemNotes: _notesController.text,
      );

      itemController.addItem(newItem);

      _itemNameController.clear();
      _itemTypeController.clear();
      _itemSubtypeController.clear();
      _itemBrandController.clear();
      _itemModelController.clear();
      _itemDimensionsController.clear();
      _notesController.clear();

      Get.snackbar('Success', 'Item added successfully',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(itemController.items.isNotEmpty
            ? '${itemController.items.values.last.itemName}'
            : 'Add New Item')),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          // controller: ScrollController(),
          children: [
            TextFormField(
              controller: _itemNameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item name';
                }
                return null;
              },
              onSaved: (value) => _itemNameController.text = value!,
            ),
            TextFormField(
              controller: _itemTypeController,
              decoration: const InputDecoration(labelText: 'Item Type'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item type';
                }
                return null;
              },
              onSaved: (value) => _itemTypeController.text = value!,
            ),
            TextFormField(
              controller: _itemSubtypeController,
              decoration: const InputDecoration(labelText: 'Item Subtype'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item subtype';
                }
                return null;
              },
              onSaved: (value) => _itemSubtypeController.text = value!,
            ),
            TextFormField(
              controller: _itemBrandController,
              decoration: const InputDecoration(labelText: 'Item Brand'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item brand';
                }
                return null;
              },
              onSaved: (value) => _itemBrandController.text = value!,
            ),
            TextFormField(
              controller: _itemModelController,
              decoration: const InputDecoration(labelText: 'Item Model'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an item model';
                }
                return null;
              },
              onSaved: (value) => _itemModelController.text = value!,
            ),
            TextFormField(
              controller: _itemDimensionsController,
              decoration: const InputDecoration(labelText: 'Item Dimensions'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter item dimensions';
                }
                return null;
              },
              onSaved: (value) => _itemDimensionsController.text = value!,
            ),
            TextFormField(
              controller: _notesController,
              maxLines: 6,
              decoration: const InputDecoration(label: Text('Notes: ')),
              onSaved: (value) =>  _notesController.text = value!,
            ),
            ElevatedButton(onPressed: _submitForm, child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
