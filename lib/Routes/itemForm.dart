import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeinventory/Routes/RoomItems.dart';
import 'package:homeinventory/main.dart';


class ItemController extends GetxController {
  final items = <Item>[].obs;
  void addItem(Item item) {
    items.add(item);
  }
}

// void main() => runApp(ItemFormPage());

class ItemFormPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _itemTypeController = TextEditingController();
  final _itemSubtypeController = TextEditingController();
  final _itemBrandController = TextEditingController();
  final _itemModelController = TextEditingController();
  final _itemDimensionsController = TextEditingController();
  final _itemColorController = TextEditingController();
  final _notesController = TextEditingController();
  final _highestId = 0.obs;

  ItemFormPage({super.key});

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newItem = Item(
        itemId: _highestId.value +1,
        itemName: _itemNameController.text,
        itemType: _itemTypeController.text,
        itemSubtype: _itemSubtypeController.text,
        itemBrand: _itemBrandController.text,
        itemModel: _itemModelController.text,
        itemDimensions: _itemDimensionsController.text,
        itemColor: _itemColorController.text,
        itemNotes: _notesController.text,
      );
      Get.find<ItemController>().addItem(newItem);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Item')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) => value!.isEmpty ? 'Please enter an Item Name' : null,
              ),
              TextFormField(
                controller: _itemTypeController,
                decoration: InputDecoration(labelText: 'Item Type'),
                validator: (value) => value!.isEmpty ? 'Please enter type of Item' : null,
              ),
              TextFormField(
                controller: _itemSubtypeController,
                decoration: InputDecoration(labelText: 'Item SubType'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Subtype' : null,
              ),
              TextFormField(
                controller: _itemBrandController,
                decoration: InputDecoration(labelText: 'Item Brand'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Brand' : null,
              ),
              TextFormField(
                controller: _itemModelController,
                decoration: InputDecoration(labelText: 'Item Model'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Model' : null,
              ),
              TextFormField(
                controller: _itemDimensionsController,
                decoration: InputDecoration(labelText: 'Item Dimensions'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Dimensions' : null,
              ),
              TextFormField(
                controller: _itemColorController,
                decoration: InputDecoration(labelText: 'Item Color'),
                validator: (value) => value!.isEmpty ? 'Please enter the item Color' : null,
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Item Notes'),
                validator: (value) => value!.isEmpty ? 'Please enter any additional item information' : null,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}