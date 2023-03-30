import 'package:clean_arch_demo/data/model/post/post_model.dart';
import 'package:clean_arch_demo/data/source/local/local_source.dart';
import 'package:clean_arch_demo/domain/repository/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final LocalSource _localSource = LocalSource();
  @override
  Future<bool> deletePost(int id) async {
    return await _localSource.deletePost(id);
  }

  @override
  Future<bool> editPost(String title, String content, int id) async {
    PostModel model = PostModel(title: title, content: content, id: id);
    return await _localSource.editPost(model);
  }

  @override
  Future<List<PostModel>?> fetchAllPosts() async {
    return await _localSource.fetchAllPosts();
  }

  @override
  Future<PostModel?> getPostById(int id) async {
    return await _localSource.getPostById(id);
  }

  @override
  Future<bool> savePost(String title, String content, int id) async {
    PostModel model = PostModel(title: title, content: content, id: id);
    return await _localSource.savePost(model);
  }

  @override
  Future<bool> clearAllPost() async {
    return await _localSource.clearAllPost();
  }
}
