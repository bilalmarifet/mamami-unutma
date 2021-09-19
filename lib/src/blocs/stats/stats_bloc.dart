import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_bloc.dart';
import 'package:mamami_unutma/src/blocs/stats/stats_state.dart';

import '../blocs.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  late StreamSubscription _postSubscription;
  StatsBloc({required PostsBloc postsBloc}) : super(StatsLoading()) {
    final postsState = postsBloc.state;
    if (postsState is PostsLoaded) add(StatsUpdated(postsState.posts));
    _postSubscription = postsBloc.stream.listen((state) {
      if (state is PostsLoaded) {
        add(StatsUpdated(state.posts));
      }
    });
  }

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is StatsUpdated) {
      final numActive =
          event.posts.where((element) => !element.complete).toList().length;
      final numCompleted =
          event.posts.where((element) => element.complete).length;

      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    _postSubscription.cancel();
    return super.close();
  }
}
