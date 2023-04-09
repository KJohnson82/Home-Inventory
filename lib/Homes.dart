import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Rooms.dart';
import 'main.dart';


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
        'homeName': _homeNameController.text,
      });
      _homeNameController.clear();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _homes.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final homes = snapshot.data!.docs;

          return GridView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.fromLTRB(100, 50, 100, 50),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
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
                    child: Text(homes[index]['homeName']),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 2,
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
        child: const Icon(Icons.add_home_outlined),
      ),
    );
  }
}
