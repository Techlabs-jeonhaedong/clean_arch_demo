import 'package:clean_arch_demo/data/model/post/post_model.dart';
import 'package:clean_arch_demo/presentation/controller/post/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  int? id;
  @override
  void initState() {
    id = Get.arguments["id"];
    PostController postController = Get.find<PostController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (id != null) {
        titleController.text = (await postController.getPostById(id!))!.title!;
        contentController.text =
            (await postController.getPostById(id!))!.content!;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () => id == null
                  ? controller.savePost(
                      titleController.text, contentController.text)
                  : controller.editPost(
                      titleController.text, contentController.text, id!),
              child: const Text(
                "저장",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: TextField(
                      controller: titleController,
                      maxLines: 1,
                      decoration:
                          const InputDecoration.collapsed(hintText: '제목'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: TextField(
                      controller: contentController,
                      maxLines: 15,
                      decoration:
                          const InputDecoration.collapsed(hintText: '내용'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
