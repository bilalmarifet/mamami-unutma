import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class LoadPosts extends PostsEvent {}

class AddPost extends PostsEvent {
  final Post post;

  const AddPost(this.post);

  @override
  List<Object> get props => [post];

  @override
  String toString() => 'AddPost { post: $post }';
}

class AddPhotoToPost extends PostsEvent {
  final File file;

  const AddPhotoToPost(this.file);

  @override
  List<Object> get props => [file];

  @override
  String toString() {
    return 'AddPhoto to posts { photoPath: ${file.path} }';
  }
}

class UpdatePost extends PostsEvent {
  final Post updatedPost;
  const UpdatePost(this.updatedPost);

  @override
  List<Object> get props => [updatedPost];

  @override
  String toString() {
    return 'UpdatePost { updatedPost: $updatedPost }';
  }
}

class DeletePost extends PostsEvent {
  final Post post;
  const DeletePost(this.post);

  @override
  List<Object> get props => [post];

  @override
  String toString() {
    return 'DeletePost { post: $post }';
  }
}

class ClearCompleted extends PostsEvent {}

class ToggleAll extends PostsEvent {}

class PostsUpdated extends PostsEvent {
  final List<Post> posts;

  const PostsUpdated(this.posts);

  @override
  List<Object> get props => [posts];
}
