import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostEntity extends Equatable {
  @override
  final bool complete;
  final String id;
  final String content;
  final String title;
  final int lat;
  final int long;
  final String startedTime;
  final int activeDuration;
  final String photoPath;

  PostEntity(this.complete, this.id, this.content, this.title, this.lat,
      this.long, this.startedTime, this.activeDuration, this.photoPath);

  @override
  String toString() {
    return 'PostEntity { complete: $complete, content: $content, startedTime: $startedTime, id: $id, photoPath: $photoPath}';
  }

  static PostEntity fromJson(Map<String, Object> json) {
    return PostEntity(
        json['complete'] as bool,
        json['id'] as String,
        json['content'] as String,
        json['title'] as String,
        json['lat'] as int,
        json['long'] as int,
        json['startedTime'] as String,
        json['activeDuration'] as int,
        json['photoPath'] as String);
  }

  static PostEntity fromSnapshot(DocumentSnapshot snap) {
    return PostEntity(
        snap.get('complete'),
        snap.id,
        snap.get('content'),
        snap.get('title'),
        snap.get('lat'),
        snap.get('long'),
        snap.get('startedTime'),
        snap.get('activeDuration'),
        snap.get('photoPath'));
  }

  Map<String, Object> toDocument() {
    return {
      'complete': complete,
      'content': content,
      'title': title,
      'lat': lat,
      'long': long,
      'startedTime': startedTime,
      'activeDuration': activeDuration,
      'photoPath': photoPath
    };
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
