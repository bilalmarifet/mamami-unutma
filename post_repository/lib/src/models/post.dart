import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class Post {
  final bool complete;
  final String id;
  final String content;
  final String title;
  final int lat;
  final int long;
  final String startedTime;
  final int activeDuration;
  final String photoPath;
  Post(this.content, this.title,
      {this.complete = false,
      String note = '',
      required this.id,
      required this.activeDuration,
      required this.lat,
      required this.long,
      required this.startedTime,
      required this.photoPath});

  Post copyWith(
      {bool? complete,
      String? id,
      String? content,
      String? title,
      int? lat,
      int? long,
      String? startedTime,
      int? activeDuration,
      String? photoPath}) {
    return Post(content ?? this.content, title ?? this.title,
        id: id ?? this.id,
        activeDuration: activeDuration ?? this.activeDuration,
        lat: lat ?? this.lat,
        long: long ?? this.long,
        startedTime: startedTime ?? this.startedTime,
        photoPath: photoPath ?? this.photoPath);
  }

  @override
  int get hashCode =>
      complete.hashCode ^
      content.hashCode ^
      lat.hashCode ^
      long.hashCode ^
      startedTime.hashCode ^
      title.hashCode ^
      activeDuration.hashCode ^
      photoPath.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          content == other.content &&
          title == other.title &&
          lat == other.lat &&
          id == other.id &&
          long == other.long &&
          startedTime == other.startedTime &&
          activeDuration == other.activeDuration &&
          photoPath == other.photoPath;

  @override
  String toString() {
    return 'Todo { complete: $complete, content: $content, title: $title, startedTime: $startedTime, activeDuration: $activeDuration, photoPath: $photoPath  }';
  }

  PostEntity toEntity() {
    return PostEntity(complete, id, content, title, lat, long, startedTime,
        activeDuration, photoPath);
  }

  static Post fromEntity(PostEntity entity) {
    return Post(entity.content, entity.title,
        id: entity.id,
        activeDuration: entity.activeDuration,
        lat: entity.lat,
        long: entity.long,
        startedTime: entity.startedTime,
        photoPath: entity.photoPath);
  }
}
