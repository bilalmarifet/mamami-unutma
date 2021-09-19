import 'package:equatable/equatable.dart';
import 'package:mamami_unutma/src/models/models.dart';
import 'package:post_repository/post_repository.dart';

abstract class FilteredPostsState extends Equatable {
  const FilteredPostsState();

  @override
  List<Object> get props => [];
}

class FilteredPostsLoading extends FilteredPostsState {}

class FilteredPostsLoaded extends FilteredPostsState {
  final List<Post> filteredPosts;

  final VisibilityFilter activeFilter;

  const FilteredPostsLoaded(
    this.filteredPosts,
    this.activeFilter,
  );

  @override
  List<Object> get props => [filteredPosts, activeFilter];

  @override
  String toString() {
    return 'FilteredPostsLoaded { filteredPosts $filteredPosts, activeFilter: $activeFilter }';
  }
}
