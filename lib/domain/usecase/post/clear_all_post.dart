import 'package:clean_arch_demo/data/repository/post/post_repository.dart';
import 'package:clean_arch_demo/domain/repository/post_repository.dart';

class ClearAllPost {
  final PostRepository _repository = PostRepositoryImpl();
  Future<bool> call() async {
    return await _repository.clearAllPost();
  }
}
