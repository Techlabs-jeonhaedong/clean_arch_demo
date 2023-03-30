import 'package:clean_arch_demo/data/model/post/post_model.dart';
import 'package:clean_arch_demo/data/repository/post/post_repository.dart';
import 'package:clean_arch_demo/domain/repository/post_repository.dart';

class FetchAllPosts {
  final PostRepository _repository = PostRepositoryImpl();

  Future<List<PostModel>?> call() async {
    return await _repository.fetchAllPosts();
  }
}
