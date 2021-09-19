import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_event.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_state.dart';
import 'package:post_repository/post_repository.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository _postRepository;
  StreamSubscription? _postSubscription;

  PostsBloc({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(PostsLoading());

  PostsState get initialState => PostsLoading();

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is LoadPosts) {
      yield* _mapLoadPostsToState();
    } else if (event is AddPost) {
      yield* _mapAddPostToState(event);
    } else if (event is UpdatePost) {
      yield* _mapUpdatePostToState(event);
    } else if (event is DeletePost) {
      yield* _mapDeletePostToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    } else if (event is PostsUpdated) {
      yield* _mapPostsUpdateToState(event);
    } else if (event is AddPhotoToPost) {
      yield* _mapAddPhotoToPost(event);
    }
  }

  Stream<PostsState> _mapLoadPostsToState() async* {
    _postSubscription?.cancel();
    _postSubscription =
        _postRepository.posts().listen((posts) => add(PostsUpdated(posts)));
  }

  Stream<PostsState> _mapAddPostToState(AddPost event) async* {
    _postRepository.addPost(event.post);
  }

  Stream<PostsState> _mapUpdatePostToState(UpdatePost event) async* {
    _postRepository.updatePost(event.updatedPost);
  }

  Stream<PostsState> _mapDeletePostToState(DeletePost event) async* {
    _postRepository.deletePost(event.post);
  }

  Stream<PostsState> _mapToggleAllToState() async* {
    final currentState = state;
    if (currentState is PostsLoaded) {
      final allComplete = currentState.posts.every((post) => post.complete);
      final List<Post> updatedPosts = currentState.posts
          .map((post) => post.copyWith(complete: !allComplete))
          .toList();
      updatedPosts.forEach((updatedPost) {
        _postRepository.updatePost(updatedPost);
      });
    }
  }

  Stream<PostsState> _mapClearCompletedToState() async* {
    final currentState = state;
    if (currentState is PostsLoaded) {
      final List<Post> completedPosts =
          currentState.posts.where((post) => post.complete).toList();
      completedPosts.forEach((completedPost) {
        _postRepository.deletePost(completedPost);
      });
    }
  }

  Stream<PostsState> _mapPostsUpdateToState(PostsUpdated event) async* {
    yield PostsLoaded(event.posts);
  }

  @override
  Future<void> close() {
    _postSubscription?.cancel();
    return super.close();
  }

  Stream<PostsState> _mapAddPhotoToPost(AddPhotoToPost event) async* {
    final result = await _postRepository.uploadImage(event.file);
    yield PostsGetPhotoLocation(result ?? "");
  }

  Future<PostsState> _mapAddPhotoToPostFuture(AddPhotoToPost event) async {
    final result = await _postRepository.uploadImage(event.file);
    return PostsGetPhotoLocation(result ?? "");
  }
}
