import 'package:flutter/material.dart';

import '../main.dart';
import 'package:get/get.dart';

class House {
  int? homeId;
  String? homeName;
  List<Room>? rooms;

  House({this.homeId, this.homeName, this.rooms});
}

class HomeController extends GetxController {
  var highestId = 0.obs;

  var homeNameController = TextEditingController();

  List<House> homes = [];
}

List<House> _homes = [];
// House newHouse = House(homeId: highestId + 1, homeName: 'New House', rooms: []);

void main() => runApp(const GetMaterialApp(home: HomesPage()));

class HomesPage extends StatelessWidget {
  const HomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _houseName = TextEditingController();
    int highestId = _homes.isEmpty
        ? 0
        : _homes.map((e) => e.homeId!).reduce((a, b) => a > b ? a : b);

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOMEVENTORY'),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.fromLTRB(50, 50, 50, 100),
          itemCount: _homes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 30,
            crossAxisSpacing: 30,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
                shape: BoxShape.rectangle,
              ),
              child: Text(_homes[index].homeName ?? ''),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.large(
          elevation: 4,
          foregroundColor: Colors.white,
          child: const Icon(
            Icons.house_rounded,
            size: 60,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Enter New Home Name: "),
                  content: TextField(
                    controller: _houseName,
                    decoration: const InputDecoration(hintText: 'Home Name'),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          // _homes[highestId].homeName = _houseName.text;
                          // homeCount();
                          addHouse(context, _houseName.text, highestId);
                        },
                        child: const Text("Save"))
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void addHouse(BuildContext context, String houseName, int highestId) {
  // _homes.add(House());
  _homes.add(House(homeId: highestId + 1, homeName: houseName, rooms: []));
  Navigator.pop(context);



  print(_homes[highestId].homeName);
}


// addHouse(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text("Enter New Home Name: "),
//         content: TextField(
//           controller: _houseName,
//           decoration: const InputDecoration(hintText: 'Home Name'),
//         ),
//         actions: [
//           // ElevatedButton(
//           //     onPressed: () {
//           //       newHouse.homeName = _houseName.text;
//           //       homeCount();
//           //     },
//           //     child: const Text("Save"))
//         ],
//       );
//     },
//   );
// }



// homeCount() {
//   if (highestId >= 0 && highestId < 4) {
//     newHouse.homeId = (newHouse.homeId! + 1);
//   } else if (highestId > 3) {
//     null;
//   }
// }
