import 'package:clean_arch_demo/data/model/post/post_model.dart';

abstract class PostRepository {
  Future<bool> savePost(String title, String content, int id);
  Future<bool> editPost(String title, String content, int id);
  Future<bool> deletePost(int id);
  Future<bool> clearAllPost();
  Future<List<PostModel>?> fetchAllPosts();
  Future<PostModel?> getPostById(int id);
}
