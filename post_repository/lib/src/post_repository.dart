import 'dart:async';
import 'dart:io';

import 'models/models.dart';

abstract class PostRepository {
  Future<void> addPost(Post post);

  Stream<List<Post>> posts();

  Future<void> deletePost(Post post);

  Future<void> updatePost(Post post);

  Future<String?> uploadImage(File file);
}
