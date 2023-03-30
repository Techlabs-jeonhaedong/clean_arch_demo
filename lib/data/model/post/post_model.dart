import 'package:equatable/equatable.dart';

class PostModel extends Equatable {
  final String title;
  final String content;
  final int id;
  const PostModel(
      {required this.title, required this.content, required this.id});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json["title"],
      content: json["content"],
      id: json["id"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "content": content,
      "id": id,
    };
  }

  PostModel copyWith({String? title, String? content, int? id}) {
    return PostModel(
      title: title ?? this.title,
      content: content ?? this.content,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [title, content, id];
}
