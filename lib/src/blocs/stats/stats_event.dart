import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class StatsUpdated extends StatsEvent {
  final List<Post> posts;

  const StatsUpdated(this.posts);

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'StatsUpdated { posts $posts}';
}
