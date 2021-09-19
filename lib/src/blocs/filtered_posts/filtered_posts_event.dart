import 'package:equatable/equatable.dart';
import 'package:mamami_unutma/src/models/models.dart';
import 'package:post_repository/post_repository.dart';

abstract class FilteredPostsEvent extends Equatable {
  const FilteredPostsEvent();
}

class UpdateFilter extends FilteredPostsEvent {
  final VisibilityFilter filter;

  const UpdateFilter(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'UpdateFilter {filter: $filter }';
}

class UpdatePosts extends FilteredPostsEvent {
  final List<Post> posts;

  const UpdatePosts(this.posts);
  @override
  List<Object?> get props => [posts];

  @override
  String toString() => 'UpdatePosts { posts: $posts }';
}
