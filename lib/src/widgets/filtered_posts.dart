import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/filtered_posts/filtered_posts_bloc.dart';
import 'package:mamami_unutma/src/blocs/filtered_posts/filtered_posts_state.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_bloc.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_event.dart';
import 'package:mamami_unutma/src/screens/details_screen.dart';
import 'package:mamami_unutma/src/widgets/delete_post_snack_bar.dart';
import 'package:mamami_unutma/src/widgets/post_item.dart';

import 'loading_indicator.dart';

class FilteredPosts extends StatelessWidget {
  FilteredPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredPostsBloc, FilteredPostsState>(
        builder: (context, state) {
      if (state is FilteredPostsLoading) {
        return LoadingIndicator();
      } else if (state is FilteredPostsLoaded) {
        final posts = state.filteredPosts;
        return Scaffold(
          appBar: AppBar(
            title: Text('Mamama Dokunma'),
          ),
          body: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostItem(
                  onDismissed: (direction) {
                    context.read<PostsBloc>().add(DeletePost(post));
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeletePostSnackBar(
                        post: post,
                        onUndo: () {
                          context.read<PostsBloc>().add(AddPost(post));
                        },
                      ),
                    );
                  },
                  onTap: () async {
                    final removedPost = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return DetailsScreen(id: post.id);
                      }),
                    );
                    if (removedPost != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        DeletePostSnackBar(
                          post: post,
                          onUndo: () {
                            context.read<PostsBloc>().add(AddPost(post));
                          },
                        ),
                      );
                    }
                  },
                  oncheckboxChanged: (_) {
                    context.read<PostsBloc>().add(
                        UpdatePost(post.copyWith(complete: !post.complete)));
                  },
                  post: post);
            },
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
