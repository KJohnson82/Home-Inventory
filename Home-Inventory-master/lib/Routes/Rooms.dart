import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeinventory/main.dart';
import 'Homes.dart';

class Room {
  int? roomId;
  String? roomDisc;
  List<Item>? roomItems;

  Room({this.roomId, this.roomDisc, this.roomItems});
}

class RoomController extends GetxController {
  var highestId = 0.obs;
  var rooms = <Room>[].obs;

  void addRoom(String roomName) {
    if (rooms.length < 10) {
      int newId = (highestId.value + 1);
      rooms.add(Room(roomId: newId, roomDisc: roomName, roomItems: []));
      highestId.value = newId;
    }
  }
}

void main() => runApp(const GetMaterialApp(home: RoomsPage()));

class RoomsPage extends StatelessWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _roomName = TextEditingController();

    return GetBuilder<RoomController>(
        init: RoomController(),
        builder: (controller) {
          return MaterialApp(
            title: 'Rooms',
            home: Scaffold(
              appBar: AppBar(
                title: const Text('HOMEVENTORY'),
                centerTitle: true,
              ),
              body: Obx(
                () => GridView.builder(
                    padding: const EdgeInsets.all(100),
                    itemCount: controller.rooms.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 40,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        // padding: EdgeInsets.fromLTRB(120, 100, 120 , 100),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(15),
                          shape: BoxShape.rectangle,
                        ),
                        child: Text(controller.rooms[index].roomDisc ?? ''),
                      );
                    }),
              ),
              floatingActionButton: Obx(() => FloatingActionButton.large(
                    elevation: 4,
                    foregroundColor: Colors.white,
                    onPressed: controller.rooms.length >= 10
                        ? null
                        : () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Enter New Room Name: '),
                                    content: TextField(
                                      controller: _roomName,
                                      decoration: const InputDecoration(
                                          hintText: 'Room Name'),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          controller.addRoom(_roomName.text);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Save'),
                                      )
                                    ],
                                  );
                                });
                          },
                    child: const Icon(Icons.add_home_work_outlined),
                  )),
            ),
          );
        });
  }
}
