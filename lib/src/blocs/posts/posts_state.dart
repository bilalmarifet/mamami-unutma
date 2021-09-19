import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<Post> posts;

  const PostsLoaded([this.posts = const []]);

  @override
  List<Object> get props => [posts];

  @override
  String toString() {
    return 'PostsLoaded { posts: $posts }';
  }
}

class PostsGetPhotoLocation extends PostsState {
  final String photoPath;

  const PostsGetPhotoLocation(this.photoPath);

  @override
  List<Object> get props => [photoPath];

  @override
  String toString() {
    return 'photoPath { posts: $photoPath }';
  }
}

class PostsNotLoaded extends PostsState {}
