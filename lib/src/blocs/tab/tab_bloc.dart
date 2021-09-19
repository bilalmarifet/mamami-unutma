import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:mamami_unutma/src/models/app_tab.dart';
import 'package:permission_handler/permission_handler.dart';

import '../blocs.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.posts);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }

  // Future<CameraDescription> getAvailableCameras() async {
  //   // Obtain a list of the available cameras on the device.

  // }
}
