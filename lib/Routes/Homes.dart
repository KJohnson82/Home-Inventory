import 'package:change_case/change_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hvtest1/firestore_instance.dart';
import '../theme.dart';
import 'Rooms.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:page_transition/page_transition.dart';

// Home Class
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
  // Calls the list of already created home objects from the firestore database
  final _homes = FirestoreInstance.getInstance().collection("homes");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _homeNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Used to help keep count of the num of house objects
  int homeCount = 0;

  // Adds a new Home Object
  void _addHome() async {
    if (_formKey.currentState!.validate()) {
      await _homes.add({
        'homeName': _homeNameController.text.toCapitalCase(),
      });
      _homeNameController.clear();
      // Sets the state after the object is created to cause the page to rebuild
      setState(() {});
      // Adds home to the homeCount list to keep track of number of objects
      homeCount = homeCount + 1;
    }
    Navigator.of(context).pop();
  }

  // Allows you to change the name of an existing home object
  void _editHome(String documentId, String newName) async {
    if (_formKey.currentState!.validate()) {
      await _homes.doc(documentId).update({
        'homeName': newName.toCapitalCase(),
      });
      _homeNameController.clear();
      setState(() {});
      // Navigator.of(context).pop();
    }
  }

  // Keeps track of the home objects count, the delay was to prevent app crashing
  void updateHomeCount(int count) async {
    await Future.delayed(const Duration(milliseconds: 1));
    setState(() {
      homeCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Sets the phone icons to use dark mode
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        backgroundColor: homeventory.primary,
        title: const Text('HOMEVENTORY: HOMES', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold,)),
        centerTitle: true,
      ),
      // Streams the data from the firestore database. returns as snapshots
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
        color: homeventory.primary,
        surfaceTintColor: homeventory.tertiary,
        elevation: 10,
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
        stream: _homes.orderBy('homeName', descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final homes = snapshot.data!.docs;
          updateHomeCount(homes.length);

          return GridView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
            itemCount: homes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemBuilder: (context, index) {
              // Makes the created container objects clickable
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: RoomsPage(
                            homeId: homes[index].id,
                            homeName: homes[index]['homeName'],
                          ),
                          type: PageTransitionType.rightToLeft,
                          duration: const Duration(milliseconds: 300)));
                },
                // Opens as dialog box to allow you to edit or delete a created object
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              backgroundColor: homeventory.secondary,
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
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    TextButton(
                                      child: Row(
                                        children: [
                                          const Text('Confirm  '),
                                          Icon(Icons.check)
                                        ],
                                      ),
                                      onPressed: () {
                                        String documentId = homes[index].id;
                                        _editHome(
                                            documentId, _homeNameController.text);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                    child: Row(
                                    children: [
                                    const Text('Delete  '),
                                    Icon(Icons.delete)
                                    ],
                                    ),
                                      onPressed: () {
                                        String documentId = homes[index].id;
                                        // db
                                        FirestoreInstance.getInstance()
                                            .collection('homes')
                                            .doc(documentId)
                                            .delete();
                                        _homeNameController.clear();
                                        Navigator.of(context).pop();
                                        updateHomeCount(homeCount - 1);
                                      },
                                    ),
                                  ],
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
                    elevation: 8,
                    color: Colors.transparent,
                    shadowColor: homeventory.background,
                    surfaceTintColor: Colors.transparent,
                    child: Container(
                      height: 50,
                      width: 50,
                      // color: homeventory.secondary,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: homeventory.secondary,
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: const [
                        //   BoxShadow(
                        //       color: Colors.black12,
                        //       spreadRadius: 1,
                        //       blurRadius: 10,
                        //       offset: Offset(2, 6))
                        // ],
                        shape: BoxShape.rectangle,
                      ),
                      child: Text(
                        //Displays the created objects name
                        homes[index]['homeName'],
                        style: TextStyle(
                          color: homeventory.onSecondary,
                          fontSize: 30,
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
        //Checks to see how many home objects exist and if it less than three allows you to add a new object, if not, it makes the button non-clickable
        elevation: 3,
        // onPressed: () {
        //   showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: const Text('Add A New Home'),
        //         content: Form(
        //           key: _formKey,
        //           child: TextFormField(
        //             controller: _homeNameController,
        //             decoration: const InputDecoration(labelText: 'Home Name'),
        //             focusNode: _focusNode,
        //             autofocus: true,
        //             validator: (value) {
        //               if (value == null || value.isEmpty) {
        //                 return 'Please enter a name';
        //               }
        //               return null;
        //             },
        //             onEditingComplete: () {
        //               _addHome();
        //               _homeNameController.clear();
        //             },
        //           ),
        //         ),
        //         actions: <Widget>[
        //           TextButton(
        //             child: const Text('Save'),
        //             onPressed: () {
        //               _addHome();
        //               _homeNameController.clear();
        //               Navigator.of(context).pop();
        //             },
        //           ),
        //         ],
        //       );
        //     },
        //   );
        // },
        onPressed: homeCount < 3
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: homeventory.secondary,
                      title: const Text('Add A New Home'),
                      content: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _homeNameController,
                          decoration:
                              const InputDecoration(labelText: 'Home Name'),
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
                            Navigator.of(context).pop();
                            _addHome();
                            _homeNameController.clear();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            : () {},
        child: Icon(
          Icons.add_home_outlined,
          size: 50,
          // color: homeventory.primary,
        ),
      ),
    );
  }
}
