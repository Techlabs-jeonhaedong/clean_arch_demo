import 'dart:convert';

import 'package:clean_arch_demo/const/pref_key.dart';
import 'package:clean_arch_demo/data/model/post/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSource {
  LocalSource._privateConstructor();
  static final LocalSource _instance = LocalSource._privateConstructor();

  SharedPreferences? _preferences;
  factory LocalSource() {
    return _instance;
  }

  Future<void> _prefInit() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> savePost(PostModel model) async {
    if (_preferences == null) {
      await _prefInit();
    }
    try {
      List<String> postJsonList =
          _preferences!.getStringList(PrefKey.postKey) ?? [];
      String newPostJson = jsonEncode(model.toJson());
      postJsonList.add(newPostJson);

      await _preferences!.setStringList(PrefKey.postKey, postJsonList);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deletePost(int id) async {
    if (_preferences == null) {
      await _prefInit();
    }
    try {
      List<String> postJsonList =
          _preferences!.getStringList(PrefKey.postKey) ?? [];
      postJsonList.removeWhere((element) {
        PostModel tempModel = PostModel.fromJson(jsonDecode(element));
        if (tempModel.id == id) {
          return true;
        }
        return false;
      });
      await _preferences!.setStringList(PrefKey.postKey, postJsonList);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> editPost(PostModel model) async {
    if (_preferences == null) {
      await _prefInit();
    }
    try {
      await deletePost(model.id);
      await savePost(model);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<PostModel>?> fetchAllPosts() async {
    if (_preferences == null) {
      await _prefInit();
    }
    try {
      return _preferences!
              .getStringList(PrefKey.postKey)
              ?.map((e) => PostModel.fromJson(jsonDecode(e)))
              .toList() ??
          [];
    } catch (_) {
      return null;
    }
  }

  Future<PostModel?> getPostById(int id) async {
    if (_preferences == null) {
      await _prefInit();
    }
    List<PostModel>? postList = await fetchAllPosts();
    if (postList == null) {
      return null;
    }
    return postList.firstWhere((element) => element.id == id);
  }

  Future<bool> clearAllPost() async {
    if (_preferences == null) {
      await _prefInit();
    }
    try {
      await _preferences!.remove(PrefKey.postKey);
      return true;
    } catch (_) {
      return false;
    }
  }
}
