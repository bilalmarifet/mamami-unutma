import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/blocs.dart';
import 'package:mamami_unutma/src/screens/add_photo_screen.dart';
import 'package:mamami_unutma/src/widgets/widgets.dart';
import 'package:post_repository/post_repository.dart';

typedef OnSaveCallback = Function(String content, String? task);

class AddEditScreen extends StatefulWidget {
  final bool? isEditing;
  final Post? post;
  final String? photoPath;
  AddEditScreen({Key? key, this.isEditing, this.post, this.photoPath})
      : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _task;
  String? _content;

  bool get isEditing => widget.isEditing ?? false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final photoPath = args.photo;
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      if (state is PostsGetPhotoLocation) {
        context.read<PostsBloc>().add(
              AddPost(Post(_content!, _task!,
                  id: '123',
                  activeDuration: 123,
                  lat: 123,
                  long: 123,
                  startedTime: '123123',
                  photoPath: state.photoPath)),
            );
        TabSelector.bottomNavigationKey.currentState!.setPage(0);
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(
            isEditing ? 'Edit Post' : 'Add Post',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: isEditing ? widget.post?.content : '',
                  autofocus: !isEditing,
                  style: textTheme.headline5,
                  decoration: InputDecoration(
                    hintText: 'Başlık',
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (value) => _content = value,
                ),
                TextFormField(
                  initialValue: isEditing ? widget.post?.content : '',
                  maxLines: 10,
                  style: textTheme.subtitle1,
                  decoration: InputDecoration(
                    hintText: 'Açıklama',
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter some additional text';
                    }
                  },
                  onSaved: (value) => _task = value,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: isEditing ? 'Save Changes' : 'Add Post',
          child: Icon(isEditing ? Icons.check : Icons.add),
          onPressed: () {
            final currentState = _formKey.currentState;
            if (currentState != null && currentState.validate()) {
              currentState.save();
              final content = _content;
              if (content != null) {
                context.read<PostsBloc>().add(AddPhotoToPost(photoPath));
              }
            }
          },
        ),
      );
    });
  }
}
