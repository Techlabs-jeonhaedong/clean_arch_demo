import 'package:clean_arch_demo/data/model/post/post_model.dart';
import 'package:clean_arch_demo/data/repository/post/post_repository.dart';
import 'package:clean_arch_demo/domain/repository/post_repository.dart';

class DeletePost {
  final PostRepository _repository = PostRepositoryImpl();

  Future<bool> call(int id) async {
    return await _repository.deletePost(id);
  }
}
