import 'package:clean_arch_demo/data/model/post/post_model.dart';
import 'package:clean_arch_demo/domain/usecase/post/clear_all_post.dart';
import 'package:clean_arch_demo/domain/usecase/post/delete_post.dart';
import 'package:clean_arch_demo/domain/usecase/post/edit_post.dart';
import 'package:clean_arch_demo/domain/usecase/post/fetch_all_posts.dart';
import 'package:clean_arch_demo/domain/usecase/post/get_post_by_id.dart';
import 'package:clean_arch_demo/domain/usecase/post/save_post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  test("포스트 저장 테스트", () async {
    ClearAllPost clear = ClearAllPost();
    await clear();
    SavePost savePost = SavePost();
    bool result = await savePost("제목", "내용", 0);
    expect(result, true);
  });

  test("포스트 리스트 불러오기 테스트", () async {
    ClearAllPost clear = ClearAllPost();
    await clear();

    SavePost savePost = SavePost();
    FetchAllPosts fetchAllPosts = FetchAllPosts();

    await savePost("제목", "내용", 0);
    await savePost("제목2", "내용2", 1);

    List<PostModel>? fetchedPosts = await fetchAllPosts();

    expect(fetchedPosts != null, true);
    expect(fetchedPosts!.length, 2);
  });

  test("포스트 아이디로 불러오기 테스트", () async {
    ClearAllPost clear = ClearAllPost();
    await clear();

    SavePost savePost = SavePost();
    GetPostById getPostById = GetPostById();

    await savePost("제목", "내용", 0);
    await savePost("제목2", "내용2", 1);

    PostModel? postModel = await getPostById(0);
    expect(postModel != null, true);
    expect(postModel!.id, 0);
    expect(postModel!.title, "제목");
  });

  test("포스트 내용 수정", () async {
    ClearAllPost clear = ClearAllPost();
    await clear();

    SavePost savePost = SavePost();
    EditPost editPost = EditPost();
    GetPostById getPostById = GetPostById();

    await savePost("제목", "내용", 0);
    await savePost("제목2", "내용2", 1);

    PostModel postModel = (await getPostById(0))!;

    bool result = await editPost("수정된 제목", "수정된 내용", 0);
    expect(result, true);

    postModel = (await getPostById(0))!;
    expect(postModel.title, "수정된 제목");
  });

  test("포스트 삭제", () async {
    ClearAllPost clear = ClearAllPost();
    await clear();

    SavePost savePost = SavePost();
    DeletePost deletePost = DeletePost();
    FetchAllPosts fetchAllPosts = FetchAllPosts();
    GetPostById getPostById = GetPostById();

    await savePost("제목", "내용", 0);
    await savePost("제목2", "내용2", 1);

    PostModel postModel = (await getPostById(0))!;
    bool result = await deletePost(postModel.id);
    expect(result, true);

    List<PostModel> list = (await fetchAllPosts())!;
    expect(list.length, 1);
  });
}
