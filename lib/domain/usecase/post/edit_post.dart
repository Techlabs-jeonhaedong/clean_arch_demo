import 'package:clean_arch_demo/data/model/post/post_model.dart';
import 'package:clean_arch_demo/data/repository/post/post_repository.dart';
import 'package:clean_arch_demo/domain/repository/post_repository.dart';

class EditPost {
  final PostRepository _repository = PostRepositoryImpl();

  Future<bool> call(String title, String content, int id) async {
    return await _repository.editPost(title, content, id);
  }
}
