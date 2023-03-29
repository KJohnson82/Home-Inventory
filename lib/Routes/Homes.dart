import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeinventory/main.dart';

class House {
  int? homeId;
  String? homeName;
  List<Room>? rooms;

  House({this.homeId, this.homeName, this.rooms});
}

class HomeController extends GetxController {
  var highestId = 0.obs;
  var homes = <House>[].obs;

  void addHouse(String houseName) {
    if (homes.length < 3) {
      int newId = (highestId.value + 1);
      homes.add(House(homeId: newId, homeName: houseName, rooms: []));
      highestId.value = newId;
    }
  }
}

void main() => runApp(const GetMaterialApp(home: HomesPage()));

class HomesPage extends StatelessWidget {
  const HomesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _houseName = TextEditingController();

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return MaterialApp(
          title: 'Material App',
          home: Scaffold(
            appBar: AppBar(
              title: Text('HOMEVENTORY'),
              centerTitle: true,
            ),
            body: Obx(
                  () => GridView.builder(
                // padding: const EdgeInsets.fromLTRB(50, 50, 50, 100),
                padding: const EdgeInsets.all(100),
                itemCount: controller.homes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
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
                    child: Text(controller.homes[index].homeName ?? ''),
                  );
                },
              ),
            ),
            floatingActionButton: Obx(
                  () => FloatingActionButton.large(
                elevation: 4,
                foregroundColor: Colors.white,
                child: const Icon(
                  Icons.add_home_outlined,
                  size: 60,
                ),
                onPressed: controller.homes.length >= 3
                    ? null
                    : () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Enter New Home Name: "),
                        content: TextField(
                          controller: _houseName,
                          decoration: const InputDecoration(
                              hintText: 'Home Name'),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              controller.addHouse(_houseName.text);
                              Navigator.pop(context);
                            },
                            child: const Text("Save"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
