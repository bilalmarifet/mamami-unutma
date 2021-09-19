import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamami_unutma/src/blocs/filtered_posts/filtered_posts.dart';
import 'package:mamami_unutma/src/blocs/filtered_posts/filtered_posts_bloc.dart';
import 'package:mamami_unutma/src/blocs/filtered_posts/filtered_posts_state.dart';
import 'package:mamami_unutma/src/models/models.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key, this.visible = false}) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    final defaulStyle = Theme.of(context).textTheme.bodyText2;
    final activeStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: Theme.of(context).accentColor);

    return BlocBuilder<FilteredPostsBloc, FilteredPostsState>(
      builder: (context, state) {
        final button = _Button(
          onSelected: (filter) {
            context.read<FilteredPostsBloc>().add(UpdateFilter(filter));
          },
          activeFilter: state is FilteredPostsLoaded
              ? state.activeFilter
              : VisibilityFilter.all,
          activeStyle: activeStyle,
          defaultStyle: defaulStyle,
        );
        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: Duration(microseconds: 150),
          child: visible ? button : IgnorePointer(child: button),
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.onSelected,
    required this.activeFilter,
    required this.activeStyle,
    required this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle? activeStyle;
  final TextStyle? defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      tooltip: 'Filter Posts',
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.all,
          child: Text(
            'Show All',
            style: activeFilter == VisibilityFilter.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.active,
          child: Text(
            'Show Active',
            style: activeFilter == VisibilityFilter.active
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          value: VisibilityFilter.completed,
          child: Text(
            'Show Active',
            style: activeFilter == VisibilityFilter.completed
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
