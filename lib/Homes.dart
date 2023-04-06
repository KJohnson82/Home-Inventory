import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Rooms.dart';
import 'package:firebase_core/firebase_core.dart';

class Home {
  int? homeId;
  String? homeName;
  Map<Object, Room>? rooms;

  Home({this.homeId, this.homeName, Map<int, Room>? rooms}) {
    this.rooms = rooms ?? {};
  }
}

class HomeController {
  var highestId = 0;
  var homes = <int, Home>{};


  void addHome(String homeName) {
    if (homes.length < 3) {
      int newId = (highestId + 1);
      homes[newId] = Home(homeId: newId, homeName: homeName, rooms: {});
      highestId = newId;
      FirebaseDatabase.instance.ref().child('homes').push().set({
        'homeId': homes[newId]?.homeId,
        'homeName': homes[newId]?.homeName,
        'homeRooms': homes[newId]?.rooms,
      });
    }
  }

}

class HomesPage extends StatefulWidget {
  HomesPage({Key? key}) : super(key: key);

  @override
  _HomesPageState createState() => _HomesPageState();
}

class _HomesPageState extends State<HomesPage> {
  final TextEditingController _homeName = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.builder(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.fromLTRB(100, 50, 100, 50),
          itemCount: controller.homes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            final homeId = controller.homes.keys.toList()[index];
            final home = controller.homes[homeId];
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RoomsPage(homeName: home?.homeName ?? '',),
                    settings: RouteSettings(arguments: home?.homeName ?? '',)
                    ));
                print('This was pressed ${home?.homeName}');
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
                  child: Text(home?.homeName ?? ''),
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.large(
          elevation: 4,
          foregroundColor: Colors.white,
          onPressed: controller.homes.length >= 3
              ? null
              : () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Enter New Home Name: "),
                        content: TextField(
                          controller: _homeName,
                          decoration:
                              const InputDecoration(hintText: 'Home Name'),
                          focusNode: _focusNode,
                          autofocus: true,
                          onSubmitted: (value) {
                            setState(() {
                              controller.addHome(_homeName.text);
                            });
                            _homeName.clear();
                            Navigator.pop(context);
                          },
                          onTap: () {
                            _focusNode.requestFocus();
                          },
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  controller.addHome(_homeName.text);
                                });
                                _homeName.clear();
                                Navigator.pop(context);
                              },
                              child: const Text("Save"))
                        ],
                      );
                    },
                  );
                },
          child: const Icon(
            Icons.add_home_work_outlined,
            size: 60,
          ),
        ),
      );
  }
}

// void main() {
//   runApp(HomesPage());
// }
