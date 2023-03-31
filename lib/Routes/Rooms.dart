import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeinventory/main.dart';
import 'Homes.dart';
import 'RoomItems.dart';

class Room {
  int? roomId;
  String? roomName;
  List<Item>? items;

  Room({this.roomId, this.roomName, this.items});
}

var home = Get.arguments as Home;

class RoomController extends GetxController {
  var highestId = 0.obs;
  var rooms = <Room>[].obs;

  void addRoom(String roomName) {
    if (rooms.length < 10) {
      int newId = (highestId.value + 1);
      rooms.add(Room(roomId: newId, roomName: roomName, items: []));
      highestId.value = newId;
    }
  }
}

void main() => runApp(GetMaterialApp(home: RoomsPage()));

class RoomsPage extends StatelessWidget {
  RoomsPage({Key? key}) : super(key: key);
  final TextEditingController _roomName = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomController>(
      init: RoomController(),
      builder: (controller) {
        return MaterialApp(
          title: 'Rooms',
          home: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () => Get.back(),
              ),
              title: Text('HOMEVENTORY: ${home.homeName}'),
              centerTitle: true,
            ),
            body: Obx(
              () => GridView.builder(
                padding: const EdgeInsets.all(50),
                itemCount: controller.rooms.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 40,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15),
                      shape: BoxShape.rectangle,
                    ),
                    child: Text(controller.rooms[index].roomName ?? ''),
                  );
                },
              ),
            ),
            floatingActionButton: Obx(
              () => FloatingActionButton.large(
                elevation: 4,
                foregroundColor: Colors.white,
                onPressed: controller.rooms.length >= 10
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Enter New Room Name: "),
                              content: TextField(
                                controller: _roomName,
                                decoration: const InputDecoration(
                                    hintText: 'Room Name'),
                                focusNode: _focusNode,
                                autofocus: true,
                                onSubmitted: (value) {
                                  controller.addRoom(_roomName.text);
                                  _roomName.clear();
                                  Navigator.pop(context);
                                },
                                onTap: () {
                                  _focusNode.requestFocus();
                                },
                                onTapOutside: (event) {
                                  _focusNode.unfocus();
                                },
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    controller.addRoom(_roomName.text);
                                    _roomName.clear();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Save"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                child: const Icon(
                  Icons.add_home_outlined,
                  size: 60,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
