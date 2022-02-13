import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(GetMaterialApp(home: Home()));
  });
}

class Controller extends GetxController {
  RxInt count = 0.obs;

  void add() {
    count++;
    update();
  }
}

class Home extends StatelessWidget {
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HI'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('${controller.count}',
                style: const TextStyle(fontSize: 45, color: Colors.red))),
            ElevatedButton(
                onPressed: () {
                  Get.to(AnotherScreen());
                },
                child: const Text('Go to another screen'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => controller.add(),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  final Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Screen'),
      ),
      body: Center(
        child: Obx(() => Text('${controller.count}',
            style: const TextStyle(fontSize: 45, color: Colors.red))),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => controller.add(),
      ),
    );
  }
}
