import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'ItemsForm.dart';
import 'Rooms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main.dart';

class Home {
  int? homeId;
  String? homeName;
  Map<Object, Room>? rooms;

  Home({this.homeId, this.homeName, Map<int, Room>? rooms}) {
    this.rooms = rooms ?? {};
  }
}

class HomeController {
  DatabaseReference homesRef = FirebaseDatabase.instance.ref('homes');
  var homes = <String, Home>{};
  var highestId = 0;
  // var homes = <int, Home>{};

  void addHome(String homeName) {
    if (homes.length < 3) {
      int newId = (highestId + 1);
      // homes[newId] = Home(homeId: newId, homeName: homeName, rooms: {});
      final newHomeRef = FirebaseDatabase.instance.ref().child('homes').push();
      final newHomeKey = newHomeRef.key;
      highestId = newId;
      // FirebaseDatabase.instance.ref().child('homes').push().set({
      //   'homeId': homes[newId]?.homeId,
      //   'homeName': homes[newId]?.homeName,
      //   // 'homeRooms': homes[newId]?.rooms,
      // });
      if (newHomeKey != null) {
        homes[newHomeKey] =
            Home(homeId: homes.length + 1, homeName: homeName, rooms: {});
        newHomeRef.set({
          'homeId': homes[newHomeKey]?.homeId,
          'homeName': homes[newHomeKey]?.homeName,
          // 'homeRooms': homes[newHomeKey]?.rooms,
        });
        print(homes[newId]?.homeId);
        print(homes[newId]?.homeName);
        print(homes[newId]?.rooms);
      }
    }
  }

  Future<void> getHomes() async {
    DataSnapshot snapshot = await homesRef.get();
    if (snapshot.value != null) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      homes.clear();

      print('FB Data: $data');
      for (var key in data.keys) {
        Map<dynamic, dynamic>? homeData = data[key] as Map<dynamic, dynamic>;
        int? homeId = homeData['homeId'];
        if (homeId == null) {
          continue;
        }
        String homeName = homeData['homeName'];

        homes[key] = Home(
          homeId: homeId,
          homeName: homeName,
          rooms: {},
        );
        if (homeData['rooms'] != null) {
          Map<dynamic, dynamic> roomDataMap =
              homeData['rooms'] as Map<dynamic, dynamic>;
          for (var roomKey in roomDataMap.keys) {
            Map<dynamic, dynamic> roomData =
                roomDataMap[roomKey] as Map<dynamic, dynamic>;
            int roomId = roomData['roomId'];
            String roomDesc = roomData['roomName'];
            // You can modify this to retrieve items if needed
            Map<Object, Item>? items = {};

            homes[homeId]!.rooms![roomId] =
                Room(roomId: roomId, roomDesc: roomDesc, items: items);
          }
        }
      }
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
  void initState() {
    super.initState();
    controller.getHomes().then((value) {
      print('Homes fetched: ${controller.homes}');
      setState(() {});
    });
  }

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
          print('Index: $index, HomeId: $homeId, Home: $home');
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoomsPage(
                            homeName: home?.homeName ?? '',
                          ),
                      settings: RouteSettings(
                        arguments: home?.homeName ?? '',
                      )));
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
                              print(_homeName.text);
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
