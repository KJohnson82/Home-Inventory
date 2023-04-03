// import 'package:flutter/material.dart';
// import 'package:homeinventory/Routes/Rooms.dart';
//
// import '../main.dart';
// import 'package:get/get.dart';
// import '../Routes.dart';
// import 'Rooms.dart';
//
//
// class Home {
//   int? homeId;
//   String? homeName;
//   List<Room>? rooms;
//
//   Home({this.homeId, this.homeName, this.rooms});
// }
//
// class HomeController extends GetxController {
//   var highestId = 0.obs;
//   // var homes = <Home>[].obs;
//   var homes = <int, Home>{}.obs;
//   void addHome(String homeName) {
//     if (homes.length < 3) {
//       int newId = (highestId.value + 1);
//       // homes.add(Home(homeId: newId, homeName: homeName, rooms: []));
//       homes[newId] = Home(homeId: newId, homeName: homeName, rooms: []);
//       highestId.value = newId;
//     }
//   }
// }
//
// // List<Home> _homes = [];
// // House newHouse = House(homeId: highestId + 1, homeName: 'New House', rooms: []);
//
// void main() => runApp(GetMaterialApp(home: HomesPage()));
//
// class HomesPage extends StatelessWidget {
//   HomesPage({super.key});
//
//   final TextEditingController _homeName = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//         init: HomeController(),
//         builder: (controller) {
//           return MaterialApp(
//             title: 'Homes',
//             home: Scaffold(
//               appBar: AppBar(
//                 title: const Text('HOMEVENTORY:  Homes'),
//                 centerTitle: true,
//               ),
//               body: Obx(
//                 () => GridView.builder(
//                   scrollDirection: Axis.vertical,
//                   padding: const EdgeInsets.fromLTRB(100, 50, 100, 50),
//                   itemCount: controller.homes.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 1,
//                     mainAxisSpacing: 30,
//                     crossAxisSpacing: 50,
//                   ),
//                   itemBuilder: (BuildContext context, int index) {
//                     // return Container(
//                     //   alignment: Alignment.center,
//                     //   decoration: BoxDecoration(
//                     //     color: Colors.amber,
//                     //     borderRadius: BorderRadius.circular(15),
//                     //     shape: BoxShape.rectangle,
//                     //   ),
//                     //   child: Text(controller.homes[index].homeName ?? ''),
//                     // );
//                     return InkWell(
//                       onTap: () {
//                         Get.to(RoomsPage(), arguments: controller.homes[index]);
//                         print(
//                             'This was pressed ${controller.homes[index].homeName}');
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: Colors.amber,
//                           borderRadius: BorderRadius.circular(15),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black12,
//                               spreadRadius: 1,
//                               blurRadius: 10,
//                               offset: Offset(2, 6)
//                             )
//                           ],
//                           shape: BoxShape.rectangle,
//                         ),
//                         child: Text(controller.homes[index].homeName ?? ''),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               floatingActionButton: Obx(
//                 () => FloatingActionButton.large(
//                   elevation: 4,
//                   foregroundColor: Colors.white,
//                   onPressed: controller.homes.length >= 3
//                       ? null
//                       : () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: const Text("Enter New Home Name: "),
//                                 content: TextField(
//                                   controller: _homeName,
//                                   decoration: const InputDecoration(
//                                       hintText: 'Home Name'),
//                                   focusNode: _focusNode,
//                                   autofocus: true,
//                                   onSubmitted: (value) {
//                                     controller.addHome(_homeName.text);
//                                     _homeName.clear();
//                                     Navigator.pop(context);
//                                   },
//                                   onTap: () {
//                                     _focusNode.requestFocus();
//                                   },
//                                   onTapOutside: (event) {
//                                     _focusNode.unfocus();
//                                   },
//                                 ),
//                                 actions: [
//                                   ElevatedButton(
//                                       onPressed: () {
//                                         controller.addHome(_homeName.text);
//                                         _homeName.clear();
//                                         Navigator.pop(context);
//                                       },
//                                       child: const Text("Save"))
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                   child: const Icon(
//                     Icons.add_home_work_outlined,
//                     size: 60,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

import 'package:flutter/material.dart';
import 'package:homeinventory/Routes/Rooms.dart';

import '../main.dart';
import 'package:get/get.dart';
import '../Routes.dart';
import 'Rooms.dart';

class Home {
  int? homeId;
  String? homeName;
  Map<Object, Room>? rooms;

  Home({this.homeId, this.homeName, Map<int, Room>? rooms}) {
    this.rooms = rooms ?? {};
  }
}

class HomeController extends GetxController {
  var highestId = 0.obs;
  var homes = <int, Home>{}.obs;
  void addHome(String homeName) {
    if (homes.length < 3) {
      int newId = (highestId.value + 1);
      homes[newId] = Home(homeId: newId, homeName: homeName, rooms: {});
      highestId.value = newId;
    }
  }
}

// void main() => runApp(GetMaterialApp(home: HomesPage()));

class HomesPage extends StatelessWidget {
  HomesPage({Key? key}) : super(key: key);

  final TextEditingController _homeName = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return MaterialApp(
            title: 'Homes',
            home: Scaffold(
              appBar: AppBar(
                title: const Text('HOMEVENTORY:  Homes'),
                centerTitle: true,
              ),
              body: Obx(
                () => GridView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.fromLTRB(100, 50, 100, 50),
                  itemCount: controller.homes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    // mainAxisSpacing: 30,
                    // crossAxisSpacing: 50,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final home = controller.homes.values.toList()[index];
                    return InkWell(
                      onTap: () {
                        Get.to(RoomsPage(), arguments: [home.homeId, home.homeName, home.rooms]);
                        print('This was pressed ${home.homeName}');
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
                          child: Text(home.homeName ?? ''),
                        ),
                      ),
                    );
                  },
                ),
              ),
              floatingActionButton: Obx(
                () => FloatingActionButton.large(
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
                                  decoration: const InputDecoration(
                                      hintText: 'Home Name'),
                                  focusNode: _focusNode,
                                  autofocus: true,
                                  onSubmitted: (value) {
                                    controller.addHome(_homeName.text);
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
                                        controller.addHome(_homeName.text);
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
              ),
            ),
          );
        });
  }
}
