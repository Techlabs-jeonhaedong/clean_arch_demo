import 'package:clean_arch_demo/data/model/post/post_model.dart';
import 'package:clean_arch_demo/domain/usecase/post/clear_all_post.dart';
import 'package:clean_arch_demo/domain/usecase/post/delete_post.dart';
import 'package:clean_arch_demo/domain/usecase/post/edit_post.dart';
import 'package:clean_arch_demo/domain/usecase/post/fetch_all_posts.dart';
import 'package:clean_arch_demo/domain/usecase/post/get_post_by_id.dart';
import 'package:clean_arch_demo/domain/usecase/post/save_post.dart';
import 'package:clean_arch_demo/presentation/screen/post_write_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  //usecase
  final SavePost _savePost = SavePost();
  final EditPost _editPost = EditPost();
  final FetchAllPosts _fetchAllPosts = FetchAllPosts();
  final GetPostById _getPostById = GetPostById();
  final DeletePost _deletePost = DeletePost();
  final ClearAllPost _clearAllPost = ClearAllPost();

  RxList<PostModel> postList = ([].cast<PostModel>()).obs;

  @override
  void onInit() async {
    postList.value = (await fetchAllPosts() ?? []);
    _sortPosts();

    super.onInit();
  }

  Future<void> savePost(String title, String content) async {
    bool result = await _savePost(title, content, getNewId());
    if (result) {
      postList.value = (await fetchAllPosts() ?? []);
    }
    _sortPosts();
    Get.back();
  }

  Future<void> editPost(String title, String content, int id) async {
    bool result = await _editPost(title, content, id);
    if (result) {
      postList.value = (await fetchAllPosts() ?? []);
    }
    _sortPosts();

    Get.back();
  }

  Future<List<PostModel>?> fetchAllPosts() async {
    return await _fetchAllPosts();
  }

  Future<PostModel?> getPostById(int id) async {
    return await _getPostById(id);
  }

  Future<void> deletePost(int id) async {
    bool result = await _deletePost(id);
    if (result) {
      postList.value = (await fetchAllPosts() ?? []);
    }
    _sortPosts();
  }

  Future<bool> clearAllPost() async {
    return await _clearAllPost();
  }

  int getNewId() {
    if (postList.isEmpty) {
      return 0;
    }
    _sortPosts();
    return postList.first.id + 1;
  }

  void _sortPosts() {
    postList.sort((a, b) {
      return b.id.compareTo(a.id);
    });
    update();
  }

  void goToWriteScreen({int? id}) {
    Get.to(() => const WriteScreen(), arguments: {"id": id});
  }
}
