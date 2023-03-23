import 'package:flutter/material.dart';

import '../main.dart';

TextEditingController _houseName = TextEditingController();

class House {
  int? homeId;
  String? homeName;
  List<Room>? rooms;

  House({this.homeId, this.homeName, this.rooms});
}

int highestId = _homes.isEmpty
    ? 0
    : _homes.map((e) => e.homeId!).reduce((a, b) => a > b ? a : b);
List<House> _homes = [];
House newHouse = House(homeId: highestId + 1, homeName: 'New House', rooms: []);


void main() => runApp(const HomesPage());

class HomesPage extends StatelessWidget {
  const HomesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOMEVENTORY'),
        ),
        body: GridView.builder(
          padding: EdgeInsets.fromLTRB(50, 50, 50, 100),
          itemCount: _homes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            );
          },
        ),
        floatingActionButton: FloatingActionButton.large(
          elevation: 4,
          foregroundColor: Colors.white,
          child: Icon(
            Icons.house_rounded,
            size: 60,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Enter New Home Name: "),
                    content: TextField(
                      controller: _houseName,
                      decoration: InputDecoration(hintText: 'Home Name'),
                    ),
                    actions: [
                      addHouse(context),
                      // ElevatedButton(onPressed: () {
                      //   addHouse(context);
                      // }, child: child)
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


addHouse(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Enter New Home Name: "),
        content: TextField(
          controller: _houseName,
          decoration: const InputDecoration(hintText: 'Home Name'),
        ),
        actions: [
          ElevatedButton(onPressed: () {
            newHouse.homeName = _houseName.text;
            homeCount();
          }, child: const Text("Save"))
        ],
      );
    },
  );
}

homeCount() {
  if (highestId >= 0 && highestId < 4) {
    newHouse.homeId = (newHouse.homeId! + 1);
  }
  else if (highestId > 3) {
    null;
  }
}


// class newHome extends StatefulWidget {
//   const newHome({Key? key}) : super(key: key);
//
//   @override
//   State<newHome> createState() => _newHomeState();
// }
//
// class _newHomeState extends State<newHome> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//             ),
//             itemBuilder: itemBuilder,
//         ),
//       ],
//     );
//   }
// }
