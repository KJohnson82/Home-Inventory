import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import 'RoomItems.dart';
import 'package:change_case/change_case.dart';

class Item {
  int? itemId;
  String? itemName;
  String? itemType;
  String? itemSubtype;
  String? itemBrand;
  String? itemModel;
  String? itemDimensions;
  String? itemColor;
  String? itemNotes;

  Item({
    required this.itemId,
    required this.itemName,
    required this.itemType,
    this.itemSubtype,
    this.itemBrand,
    this.itemModel,
    this.itemDimensions,
    this.itemColor,
    this.itemNotes,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemType': itemType,
      'itemSubtype': itemSubtype,
      'itemBrand': itemBrand,
      'itemModel': itemModel,
      'itemDimensions': itemDimensions,
      'itemColor': itemColor,
      'itemNotes': itemNotes,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      itemId: map['itemId'],
      itemName: map['itemName'],
      itemType: map['itemType'],
      itemSubtype: map['itemSubtype'],
      itemBrand: map['itemBrand'],
      itemModel: map['itemModel'],
      itemDimensions: map['itemDimensions'],
      itemColor: map['itemColor'],
      itemNotes: map['itemNotes'],
    );
  }
}

class ItemForm extends StatefulWidget {
  final String roomId;
  final Item? item;
  final String? documentId;

  ItemForm({super.key, required this.roomId, this.item, this.documentId});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemTypeController = TextEditingController();
  final TextEditingController _itemSubtypeController = TextEditingController();
  final TextEditingController _itemBrandController = TextEditingController();
  final TextEditingController _itemModelController = TextEditingController();
  final TextEditingController _itemDimensionsController = TextEditingController();
  final TextEditingController _itemColorController = TextEditingController();
  final TextEditingController _itemNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _itemNameController.text = widget.item!.itemName!;
      _itemTypeController.text = widget.item!.itemType!;
      _itemSubtypeController.text = widget.item!.itemSubtype ?? '';
      _itemBrandController.text = widget.item!.itemBrand ?? '';
      _itemModelController.text = widget.item!.itemModel ?? '';
      _itemDimensionsController.text = widget.item!.itemDimensions ?? '';
      _itemColorController.text = widget.item!.itemColor ?? '';
      _itemNotesController.text = widget.item!.itemNotes ?? '';
    }
  }

  void _addItem() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> itemData = {
        'itemName': _itemNameController.text.toCapitalCase(),
        'itemType': _itemTypeController.text.toCapitalCase(),
        'itemSubtype': _itemSubtypeController.text.toCapitalCase(),
        'itemBrand': _itemBrandController.text.toCapitalCase(),
        'itemModel': _itemModelController.text.toCapitalCase(),
        'itemDimensions': _itemDimensionsController.text,
        'itemColor': _itemColorController.text.toCapitalCase(),
        'itemNotes': _itemNotesController.text,
      };
      Navigator.of(context).pop();

      if (widget.documentId != null ) {
        await _firestore
            .collection('rooms')
            .doc(widget.roomId)
            .collection('items')
            .doc(widget.documentId)
            .update(itemData);
      }
      else {
        await _firestore
            .collection('rooms')
            .doc(widget.roomId)
            .collection('items')
            .add(itemData);
      }

      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: homeventory.primary,
        shadowColor: homeventory.background,
        centerTitle: true,
        title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: homeventory.primary, fontWeight: FontWeight.bold),
                controller: _itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                autofocus: true,
                maxLength: 50,
                maxLines: 1,
              ),
              TextFormField(
                style: TextStyle(color: homeventory.primary, fontWeight: FontWeight.bold),
                controller: _itemTypeController,
                decoration: const InputDecoration(labelText: 'Item Type'),
                maxLength: 50,
                maxLines: 1,
              ),
              TextFormField(
                style: TextStyle(color: homeventory.primary, fontWeight: FontWeight.bold),
                controller: _itemSubtypeController,
                decoration: const InputDecoration(labelText: 'Item Subtype'),
                maxLength: 50,
                maxLines: 1,
              ),
              TextFormField(
                style: TextStyle(color: homeventory.primary, fontWeight: FontWeight.bold),
                controller: _itemBrandController,
                decoration: const InputDecoration(labelText: 'Item Brand'),
                maxLength: 50,
                maxLines: 1,
              ),
              TextFormField(
                style: TextStyle(color: homeventory.primary, fontWeight: FontWeight.bold),
                controller: _itemModelController,
                decoration: const InputDecoration(labelText: 'Item Model'),
                maxLength: 50,
                maxLines: 1,
              ),
              TextFormField(
                style: TextStyle(color: homeventory.primary, fontWeight: FontWeight.bold),
                controller: _itemDimensionsController,
                decoration: const InputDecoration(labelText: 'Item Dimensions'),
                maxLength: 50,
                maxLines: 1,
              ),
              TextFormField(
                style: TextStyle(color: homeventory.primary, fontWeight: FontWeight.bold),
                controller: _itemColorController,
                decoration: const InputDecoration(labelText: 'Item Color'),
                maxLength: 50,
                maxLines: 1,
              ),
              TextFormField(
                style: TextStyle(color: homeventory.primary, fontWeight: FontWeight.bold),
                controller: _itemNotesController,
                decoration: const InputDecoration(labelText: 'Item Notes'),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addItem,
                child: Text(widget.item == null ? 'Add Item' : 'Update Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemTypeController.dispose();
    _itemSubtypeController.dispose();
    _itemBrandController.dispose();
    _itemModelController.dispose();
    _itemDimensionsController.dispose();
    _itemColorController.dispose();
    _itemNotesController.dispose();
    super.dispose();
  }
}
