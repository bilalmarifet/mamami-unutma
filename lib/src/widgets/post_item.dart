import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_repository/post_repository.dart';

class PostItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool?> oncheckboxChanged;
  final Post post;

  PostItem(
      {Key? key,
      required this.onDismissed,
      required this.onTap,
      required this.oncheckboxChanged,
      required this.post});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: Key('__post_item_${post.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(
          value: post.complete,
          onChanged: oncheckboxChanged,
        ),
        title: Hero(
          tag: '${post.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              post.content,
              style: theme.textTheme.headline6,
            ),
          ),
        ),
        subtitle: post.content.isNotEmpty
            ? Text(
                post.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}
