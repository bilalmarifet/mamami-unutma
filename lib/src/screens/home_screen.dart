import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/tab/tab_bloc.dart';
import 'package:mamami_unutma/src/blocs/tab/tab_event.dart';
import 'package:mamami_unutma/src/models/app_tab.dart';
import 'package:mamami_unutma/src/screens/add_edit_screen.dart';
import 'package:mamami_unutma/src/screens/add_photo_screen.dart';
import 'package:mamami_unutma/src/widgets/filter_button.dart';
import 'package:mamami_unutma/src/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        // final camera = await context.read<TabBloc>().getAvailableCameras();
        return Scaffold(
            // appBar: AppBar(
            //     // title: Text('Mamami Birak'),
            //     // actions: [
            //     //   FilterButton(
            //     //     visible: activeTab == AppTab.posts,
            //     //   ),
            //     // ExtraActions()
            //     // ],
            //     ),
            body: activeTab == AppTab.posts
                ? FilteredPosts()
                : (activeTab == AppTab.stats
                    ? Stats()
                    : AddPhotoScreen(
                        // camera: camera,
                        )),
            bottomNavigationBar: Container(
              height: 100,
              color: Colors.blueAccent,
              child: TabSelector(
                activeTab: activeTab,
                onTabSelected: (tab) =>
                    context.read<TabBloc>().add(UpdateTab(tab)),
              ),
            ));
      },
    );
  }
}
