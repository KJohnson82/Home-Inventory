// import 'dart:developer';
//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:hvtest1/RoomItems.dart';
//
// class Item {
//   int? itemId;
//   String? itemName;
//   String? itemType;
//   String? itemSubtype;
//   String? itemBrand;
//   String? itemModel;
//   String? itemDimensions;
//   String? itemColor;
//   String? itemNotes;
//
//   Item({
//     required this.itemId,
//     required this.itemName,
//     required this.itemType,
//     this.itemSubtype,
//     this.itemBrand,
//     this.itemModel,
//     this.itemDimensions,
//     this.itemColor,
//     this.itemNotes,
//   });
//
//
//   Map<String, dynamic> toMap() {
//     return {
//       'itemId': itemId,
//       'itemName': itemName,
//       'itemType': itemType,
//       'itemSubtype': itemSubtype,
//       'itemBrand': itemBrand,
//       'itemModel': itemModel,
//       'itemDimensions': itemDimensions,
//       'itemColor': itemColor,
//       'itemNotes': itemNotes,
//     };
//   }
//
//
//   factory Item.fromMap(Map<String, dynamic> map) {
//     return Item(
//       itemId: map['itemId'],
//       itemName: map['itemName'],
//       itemType: map['itemType'],
//       itemSubtype: map['itemSubtype'],
//       itemBrand: map['itemBrand'],
//       itemModel: map['itemModel'],
//       itemDimensions: map['itemDimensions'],
//       itemColor: map['itemColor'],
//       itemNotes: map['itemNotes'],
//     );
//   }
// }
//
// class ItemController {
//   final items = <Item>{};
//
//   int get highestId => items.isNotEmpty ? items.last.itemId! : 0;
//
//   void addItem(Item item) {
//     items.add(item);
//     FirebaseDatabase.instance.ref().parent?.push().set(item);
//   }
// }
//
// class ItemFormPage extends StatefulWidget {
//   const ItemFormPage({Key? key, required this.itemController, required this.roomItemController}) : super(key: key);
//   final ItemController itemController;
//   final RoomItemController roomItemController;
//
//   @override
//   _ItemFormPageState createState() => _ItemFormPageState();
// }
//
// class _ItemFormPageState extends State<ItemFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _itemNameController = TextEditingController();
//   final _itemTypeController = TextEditingController();
//   final _itemSubtypeController = TextEditingController();
//   final _itemBrandController = TextEditingController();
//   final _itemModelController = TextEditingController();
//   final _itemDimensionsController = TextEditingController();
//   final _itemColorController = TextEditingController();
//   final _notesController = TextEditingController();
//
//   // final ItemController _itemController = ItemController();
//   ItemController get _itemController => widget.itemController;
//   RoomItemController get controller => widget.roomItemController;
//
//   void _submitForm(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       final newItem = Item(
//         itemId: _itemController.highestId + 1,
//         itemName: _itemNameController.text,
//         itemType: _itemTypeController.text,
//         itemSubtype: _itemSubtypeController.text,
//         itemBrand: _itemBrandController.text,
//         itemModel: _itemModelController.text,
//         itemDimensions: _itemDimensionsController.text,
//         itemColor: _itemColorController.text,
//         itemNotes: _notesController.text,
//       );
//
//
//       // _itemController.addItem(newItem);
//       // RoomItem roomItem = _roomItemController.items.firstWhere((roomItem) => roomItem.itemId == newItem.itemId);
//       // roomItem.items ??= <Item>[];
//       // roomItem.items!.add(newItem);
//
//       RoomItem roomItem = widget.roomItemController.items.firstWhere(
//             (item) => item.itemId == newItem.itemId,
//         orElse: () => RoomItem(itemId: newItem.itemId, itemDesc: newItem.itemName, items: []),
//       );
//
//
//
//       if (!widget.roomItemController.items.contains(roomItem)) {
//         widget.roomItemController.items.add(roomItem);
//
//         roomItem.items?.add(newItem);
//       }
//
//       FocusScope.of(context).unfocus();
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HOMEVENTORY'),
//         centerTitle: true,
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             shrinkWrap: false,
//             children: [
//               TextFormField(
//                 controller: _itemNameController,
//                 decoration: const InputDecoration(labelText: 'Item Name'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter an Item Name' : null,
//
//               ),
//               TextFormField(
//                 controller: _itemTypeController,
//                 decoration: const InputDecoration(labelText: 'Item Type'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter type of Item' : null,
//               ),
//               TextFormField(
//                 controller: _itemSubtypeController,
//                 decoration: const InputDecoration(labelText: 'Item SubType'),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Please enter the item Subtype' : null,
//               ),
//               TextFormField(
//                 controller: _itemBrandController,
//                 decoration: const InputDecoration(labelText: 'Item Brand'),
//                 // validator: (value) =>
//                 //     value!.isEmpty ? 'Please enter the item Brand' : null,
//               ),
//               TextFormField(
//                 controller: _itemModelController,
//                 decoration: const InputDecoration(labelText: 'Item Model'),
//                 // validator: (value) =>
//                 //     value!.isEmpty ? 'Please enter the item Model' : null,
//               ),
//               TextFormField(
//                 controller: _itemDimensionsController,
//                 decoration: const InputDecoration(labelText: 'Item Dimensions'),
//                 // validator: (value) =>
//                 //     value!.isEmpty ? 'Please enter the item Dimensions' : null,
//               ),
//               TextFormField(
//                 controller: _itemColorController,
//                 decoration: const InputDecoration(labelText: 'Item Color'),
//                 // validator: (value) =>
//                 //     value!.isEmpty ? 'Please enter the item Color' : null,
//               ),
//               TextFormField(
//                 controller: _notesController,
//                 decoration: const InputDecoration(labelText: 'Item Notes'),
//                 // validator: (value) => value!.isEmpty
//                 //     ? 'Please enter any additional item information'
//                 //     : null,
//               ),
//               ElevatedButton(
//                 child: const Text('Submit'),
//                 onPressed: () async => [
//                   _submitForm(context),
//                   print(_itemNameController.text),
//                   print(_itemTypeController.text),
//                   print(_itemSubtypeController.text),
//                   print(_itemBrandController.text),
//                   print(_itemModelController.text),
//                   print(_itemDimensionsController.text),
//                   print(_itemColorController.text),
//                 ],
//
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _itemNameController.dispose();
//     _itemTypeController.dispose();
//     _itemSubtypeController.dispose();
//     _itemBrandController.dispose();
//     _itemModelController.dispose();
//     _itemDimensionsController.dispose();
//     _itemColorController.dispose();
//     _notesController.dispose();
//     super.dispose();
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'RoomItems.dart';

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
//
// class ItemController {
//   final items = <Item>{};
//
//   int get highestId => items.isNotEmpty ? items.last.itemId! : 0;
//
//   void addItem(Item item, String homeName, String roomName) {
//     items.add(item);
//     FirebaseFirestore.instance
//         .collection('homes')
//         .doc(homeName)
//         .collection('rooms')
//         .doc(roomName)
//         .collection('items')
//         .add(item.toMap());
//   }
// }
//
// class ItemFormPage extends StatefulWidget {
//   const ItemFormPage({Key? key, required this.itemController, required this.roomItemController}) : super(key: key);
//   final ItemController itemController;
//   final RoomItemController roomItemController;
//
//   @override
//   _ItemFormPageState createState() => _ItemFormPageState();
// }
//
// class _ItemFormPageState extends State<ItemFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _itemNameController = TextEditingController();
//   final _itemTypeController = TextEditingController();
//   final _itemSubtypeController = TextEditingController();
//   final _itemBrandController = TextEditingController();
//   final _itemModelController = TextEditingController();
//   final _itemDimensionsController = TextEditingController();
//   final _itemColorController = TextEditingController();
//   final _notesController = TextEditingController();
//
//   // final ItemController _itemController = ItemController();
//   ItemController get _itemController => widget.itemController;
//   RoomItemController get controller => widget.roomItemController;
//
//   void _submitForm(BuildContext context) {
//     if (_formKey.currentState!.validate()) {
//       final newItem = Item(
//         itemId: _itemController.highestId + 1,
//         itemName: _itemNameController.text,
//         itemType: _itemTypeController.text,
//         itemSubtype: _itemSubtypeController.text,
//         itemBrand: _itemBrandController.text,
//         itemModel: _itemModelController.text,
//         itemDimensions: _itemDimensionsController.text,
//         itemColor: _itemColorController.text,
//         itemNotes: _notesController.text,
//       );
//
//       String homeName = "your_home_name"; // Replace with the actual home name
//       String roomName = "your_room_name"; // Replace with the actual room name
//       _itemController.addItem(newItem, homeName, roomName);
//
//       FocusScope.of(context).unfocus();
//       Navigator.pop(context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HOMEVENTORY'),
//         centerTitle: true,
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             shrinkWrap: false,
//             children: [
//               TextFormField(
//                 controller: _itemNameController,
//                 decoration: const InputDecoration(labelText: 'Item Name'),
//                 validator: (value) =>
//                 value!.isEmpty ? 'Please enter an Item Name' : null,
//
//               ),
//               TextFormField(
//                 controller: _itemTypeController,
//                 decoration: const InputDecoration(labelText: 'Item Type'),
//                 validator: (value) =>
//                 value!.isEmpty ? 'Please enter type of Item' : null,
//               ),
//               TextFormField(
//                 controller: _itemSubtypeController,
//                 decoration: const InputDecoration(labelText: 'Item SubType'),
//                 validator: (value) =>
//                 value!.isEmpty ? 'Please enter the item Subtype' : null,
//               ),
//               TextFormField(
//                 controller: _itemBrandController,
//                 decoration: const InputDecoration(labelText: 'Item Brand'),
//                 // validator: (value) =>
//                 //     value!.isEmpty ? 'Please enter the item Brand' : null,
//               ),
//               TextFormField(
//                 controller: _itemModelController,
//                 decoration: const InputDecoration(labelText: 'Item Model'),
//                 // validator: (value) =>
//                 //     value!.isEmpty ? 'Please enter the item Model' : null,
//               ),
//               TextFormField(
//                 controller: _itemDimensionsController,
//                 decoration: const InputDecoration(labelText: 'Item Dimensions'),
//                 // validator: (value) =>
//                 //     value!.isEmpty ? 'Please enter the item Dimensions' : null,
//               ),
//               TextFormField(
//                 controller: _itemColorController,
//                 decoration: const InputDecoration(labelText: 'Item Color'),
//                 // validator: (value) =>
//                 //     value!.isEmpty ? 'Please enter the item Color' : null,
//               ),
//               TextFormField(
//                 controller: _notesController,
//                 decoration: const InputDecoration(labelText: 'Item Notes'),
//                 // validator: (value) => value!.isEmpty
//                 //     ? 'Please enter any additional item information'
//                 //     : null,
//               ),
//               ElevatedButton(
//                 child: const Text('Submit'),
//                 onPressed: () async => [
//                   _submitForm(context),
//                   print(_itemNameController.text),
//                   print(_itemTypeController.text),
//                   print(_itemSubtypeController.text),
//                   print(_itemBrandController.text),
//                   print(_itemModelController.text),
//                   print(_itemDimensionsController.text),
//                   print(_itemColorController.text),
//                 ],
//
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _itemNameController.dispose();
//     _itemTypeController.dispose();
//     _itemSubtypeController.dispose();
//     _itemBrandController.dispose();
//     _itemModelController.dispose();
//     _itemDimensionsController.dispose();
//     _itemColorController.dispose();
//     _notesController.dispose();
//     super.dispose();
//   }
// }



class ItemForm extends StatefulWidget {
  final String roomId;

  ItemForm({super.key, required this.roomId});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemTypeController = TextEditingController();
  TextEditingController _itemSubtypeController = TextEditingController();
  TextEditingController _itemBrandController = TextEditingController();
  TextEditingController _itemModelController = TextEditingController();
  TextEditingController _itemDimensionsController = TextEditingController();
  TextEditingController _itemColorController = TextEditingController();
  TextEditingController _itemNotesController = TextEditingController();

  void _addItem() async {
    if (_formKey.currentState!.validate()) {
      await _firestore
          .collection('rooms')
          .doc(widget.roomId)
          .collection('items')
          .add({
        'itemName': _itemNameController.text,
        'itemType': _itemTypeController.text,
        'itemSubtype': _itemSubtypeController.text,
        'itemBrand': _itemBrandController.text,
        'itemModel': _itemModelController.text,
        'itemDimensions': _itemDimensionsController.text,
        'itemColor': _itemColorController.text,
        'itemNotes': _itemNotesController.text,
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _itemTypeController,
                decoration: const InputDecoration(labelText: 'Item Type'),
              ),
              TextFormField(
                controller: _itemSubtypeController,
                decoration: const InputDecoration(labelText: 'Item Subtype'),
              ),
              TextFormField(
                controller: _itemBrandController,
                decoration: const InputDecoration(labelText: 'Item Brand'),
              ),
              TextFormField(
                controller: _itemModelController,
                decoration: const InputDecoration(labelText: 'Item Model'),
              ),
              TextFormField(
                controller: _itemDimensionsController,
                decoration: const InputDecoration(labelText: 'Item Dimensions'),
              ),
              TextFormField(
                controller: _itemColorController,
                decoration: const InputDecoration(labelText: 'Item Color'),
              ),
              TextFormField(
                controller: _itemNotesController,
                decoration: const InputDecoration(labelText: 'Item Notes'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addItem,
                child: const Text('Add Item'),
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
