import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_bloc.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_event.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_state.dart';
import 'package:mamami_unutma/src/models/models.dart';

class ExtraActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      if (state is PostsLoaded) {
        final allComplete = state.posts.every((element) => element.complete);
        return PopupMenuButton<ExtraAction>(
          onSelected: (action) {
            switch (action) {
              case ExtraAction.clearCompleted:
                context.read<PostsBloc>().add(ClearCompleted());
                break;
              case ExtraAction.toggleAllComplete:
                context.read<PostsBloc>().add(ToggleAll());
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuItem<ExtraAction>>[
            PopupMenuItem<ExtraAction>(
              value: ExtraAction.toggleAllComplete,
              child: Text(
                  allComplete ? 'Mark all incomplete' : 'Mark all complete'),
            ),
            PopupMenuItem<ExtraAction>(
              value: ExtraAction.clearCompleted,
              child: Text('Clear completed'),
            ),
          ],
        );
      }

      return Container();
    });
  }
}
