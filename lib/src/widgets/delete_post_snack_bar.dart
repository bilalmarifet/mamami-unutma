import 'package:flutter/material.dart';
import 'package:post_repository/post_repository.dart';

class DeletePostSnackBar extends SnackBar {
  DeletePostSnackBar({
    Key? key,
    required Post post,
    required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'Deleted ${post.content}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(label: 'Undo', onPressed: onUndo),
        );
}
