import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'entities/entities.dart';
import 'models/models.dart';
import 'post_repository.dart';

class FirebasePostRepository implements PostRepository {
  final postCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> addPost(Post post) {
    return postCollection.add(post.toEntity().toDocument());
  }

  @override
  Stream<List<Post>> posts() {
    return postCollection.snapshots().map((event) {
      return event.docs
          .map((e) => Post.fromEntity(PostEntity.fromSnapshot(e)))
          .toList();
    });
  }

  @override
  Future<String?> uploadImage(File file) async {
    String fileName = file.path;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    try {
      final result = await firebaseStorageRef.putFile(file);
      result.ref.getDownloadURL().then((value) {
        return value;
      });
    } catch (e) {}
  }

  @override
  Future<void> deletePost(Post post) {
    return postCollection.doc(post.id).delete();
  }

  @override
  Future<void> updatePost(Post post) {
    return postCollection.doc(post.id).update(post.toEntity().toDocument());
  }
}
