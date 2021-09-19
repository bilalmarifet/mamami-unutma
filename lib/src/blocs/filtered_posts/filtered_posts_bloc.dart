import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_bloc.dart';
import 'package:mamami_unutma/src/models/models.dart';
import 'package:post_repository/post_repository.dart';

import '../blocs.dart';

class FilteredPostsBloc extends Bloc<FilteredPostsEvent, FilteredPostsState> {
  final PostsBloc _postsBloc;
  late StreamSubscription _postsSubscription;

  FilteredPostsBloc({required PostsBloc postsBloc})
      : _postsBloc = postsBloc,
        super(
          postsBloc.state is PostsLoaded
              ? FilteredPostsLoaded(
                  (postsBloc.state as PostsLoaded).posts,
                  VisibilityFilter.all,
                )
              : FilteredPostsLoading(),
        ) {
    _postsSubscription = postsBloc.stream.listen((state) {
      if (state is PostsLoaded) add(UpdatePosts(state.posts));
    });
  }
  @override
  Stream<FilteredPostsState> mapEventToState(FilteredPostsEvent event) async* {
    if (event is UpdateFilter) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is UpdatePosts) {
      yield* _mapPostsUpdatedToState(event);
    }
  }

  Stream<FilteredPostsState> _mapUpdateFilterToState(
    UpdateFilter event,
  ) async* {
    final currentState = _postsBloc.state;
    if (currentState is PostsLoaded) {
      yield FilteredPostsLoaded(
        _mapPostsToFilteredPosts(currentState.posts, event.filter),
        event.filter,
      );
    }
  }

  Stream<FilteredPostsState> _mapPostsUpdatedToState(
    UpdatePosts event,
  ) async* {
    final visibilityFilter = state is FilteredPostsLoaded
        ? (state as FilteredPostsLoaded).activeFilter
        : VisibilityFilter.all;
    yield FilteredPostsLoaded(
      _mapPostsToFilteredPosts(
        (_postsBloc.state as PostsLoaded).posts,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Post> _mapPostsToFilteredPosts(
      List<Post> posts, VisibilityFilter filter) {
    return posts.where((post) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !post.complete;
      } else {
        return post.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    _postsSubscription.cancel();
    return super.close();
  }
}
