import 'package:clean_arch_demo/presentation/controller/post/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(PostController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GetX<PostController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: controller.goToWriteScreen,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: controller.postList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.grey),
                    ),
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => controller
                                  .deletePost(controller.postList[index].id),
                              child: const Text("삭제"),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () => controller.goToWriteScreen(
                                  id: controller.postList[index].id),
                              child: const Text("수정"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(controller.postList[index].title),
                        const SizedBox(height: 10),
                        Text(controller.postList[index].content),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
