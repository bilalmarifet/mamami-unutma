import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_bloc.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_event.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_state.dart';
import 'package:mamami_unutma/src/screens/add_edit_screen.dart';

class DetailsScreen extends StatelessWidget {
  final String id;

  DetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      if (state is! PostsLoaded) {
        throw StateError('Cannot render details without valid posts');
      }
      final post = state.posts.firstWhere((element) => element.id == id);
      return Scaffold(
        appBar: AppBar(
          title: Text('Post Details'),
          actions: [
            IconButton(
                tooltip: 'Delete Posts',
                onPressed: () {
                  context.read<PostsBloc>().add(DeletePost(post));
                  Navigator.of(context).pop(post);
                },
                icon: Icon(Icons.delete))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Checkbox(
                      value: post.complete,
                      onChanged: (_) {
                        context.read<PostsBloc>().add(UpdatePost(
                            post.copyWith(complete: !post.complete)));
                      },
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: '${post.id}__postTag',
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                            child: Text(
                              post.content,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                        Text(
                          post.content,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: 'Edit Post',
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed('/addPost');

              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //     return AddEditScreen(
              //         onSave: (task, note) {
              //           context.read<PostsBloc>().add(
              //                 UpdatePost(post.copyWith(content: task)),
              //               );
              //         },
              //         isEditing: true,
              //         post: post);
              //   }));
              // },
            }),
      );
    });
  }
}
