import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/authentication_bloc/bloc.dart';
import 'package:mamami_unutma/src/blocs/posts/posts_bloc.dart';
import 'package:mamami_unutma/src/screens/add_photo_screen.dart';
import 'package:mamami_unutma/src/services/camera_service.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'src/blocs/blocs.dart';
import 'src/screens/add_edit_screen.dart';
import 'src/screens/home_screen.dart';
import 'src/blocs/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocOberser();
  CameraServices();
  runApp(MamamiUnutma());
}

class MamamiUnutma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) {
              return AuthenticationBloc(
                userRepository: FirebaseUserRepository(),
              )..add(AppStarted());
            },
          ),
          BlocProvider<PostsBloc>(
            create: (context) {
              return PostsBloc(
                postRepository: FirebasePostRepository(),
              )..add(LoadPosts());
            },
          )
        ],
        child: MaterialApp(
          title: 'Firestore Posts',
          routes: {
            '/': (context) {
              return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<TabBloc>(
                          create: (context) => TabBloc(),
                        ),
                        BlocProvider<FilteredPostsBloc>(
                          create: (context) => FilteredPostsBloc(
                            postsBloc: context.read<PostsBloc>(),
                          ),
                        ),
                        BlocProvider<StatsBloc>(
                          create: (context) => StatsBloc(
                            postsBloc: context.read<PostsBloc>(),
                          ),
                        ),
                      ],
                      child: HomeScreen(),
                    );
                  }
                  if (state is Unauthenticated) {
                    return Center(
                      child: Text('Could not authenticate wiht Firestore'),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            },
            // '/AddPhotoScreen': (context) => AddPhotoScreen(),
            '/addPost': (context) {
              return AddEditScreen();
            }
          },
        ));
  }
}
