import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import 'Rooms.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

class Home {
  String? homeName;
  Map<Object, Room>? rooms;

  Home({this.homeName, Map<int, Room>? rooms}) {
    this.rooms = rooms ?? {};
  }
}

class HomesPage extends StatefulWidget {
  const HomesPage({super.key});

  @override
  _HomesPageState createState() => _HomesPageState();
}

class _HomesPageState extends State<HomesPage> {
  final _homes = db.collection("homes");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _homeNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _addHome() async {
    if (_formKey.currentState!.validate()) {
      await _homes.add({
        'homeName': _homeNameController.text.toUpperCase(),
      });
      _homeNameController.clear();
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  void _editHome(String documentId, String newName) async {
    if (_formKey.currentState!.validate()) {
      await _homes.doc(documentId).update({
        'homeName': newName.toUpperCase(),
      });
      _homeNameController.clear();
      setState(() {});
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
        color: homeventory.primary,
        surfaceTintColor: homeventory.primary,
        elevation: 3,
        notchMargin: 8,
        shape: const AutomaticNotchedShape(
          ContinuousRectangleBorder(
              // borderRadius: BorderRadius.all(
              //   Radius.circular(1),
              // )),
              ),
          StadiumBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Icon(Icons.home_filled, size: 40,),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 100, 0),
              child: SizedBox(
                height: 40,
                width: 60,
                child: Column(
                  children: [
                    // Icon(
                    //   Icons.home_work,
                    //   size: 40,
                    //   color: homeventory.secondary,
                    //   semanticLabel: "Rooms",
                    // ),
                    // Text(
                    //   'Rooms',
                    //   style:
                    //       TextStyle(color: homeventory.secondary, fontSize: 15),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 60,
              child: Column(
                children: [
                  // Icon(
                  //   Icons.list_alt,
                  //   size: 40,
                  //   color: homeventory.secondary,
                  //   semanticLabel: "Items",
                  // ),
                  // Text(
                  //   'Items',
                  //   style:
                  //       TextStyle(color: homeventory.secondary, fontSize: 15),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _homes.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final homes = snapshot.data!.docs;
          return GridView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            itemCount: homes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              // childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomsPage(
                          homeId: homes[index].id,
                          homeName: homes[index]['homeName'],
                        ),
                      ));
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              title: Text(
                                  'Edit or Delete ${homes[index]["homeName"]}?'),
                              content: Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: _homeNameController,
                                  decoration: InputDecoration(
                                      labelText: 'Edit: Home Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Confirm'),
                                  onPressed: () {
                                    String documentId = homes[index].id;
                                    _editHome(
                                        documentId, _homeNameController.text);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    String documentId = homes[index].id;
                                    db
                                        .collection('homes')
                                        .doc(documentId)
                                        .delete();
                                    _homeNameController.clear();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Card(
                    color: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: Container(
                      height: 50,
                      width: 50,
                      // color: homeventory.secondary,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: homeventory.secondary,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(2, 6))
                        ],
                        shape: BoxShape.rectangle,
                      ),
                      child: Text(
                        homes[index]['homeName'],
                        style: TextStyle(
                          color: homeventory.onPrimaryContainer,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoogleFonts.poppins()",
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.large(
        // elevation: 3,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Add A New Home'),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _homeNameController,
                    decoration: const InputDecoration(labelText: 'Home Name'),
                    focusNode: _focusNode,
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                    onEditingComplete: () {
                      _addHome();
                      _homeNameController.clear();
                    },
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Save'),
                    onPressed: () {
                      _addHome();
                      _homeNameController.clear();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add_home_outlined,
          color: homeventory.primary,
        ),
      ),
    );
  }
}
