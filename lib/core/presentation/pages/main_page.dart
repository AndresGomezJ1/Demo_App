import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../resources/app_routes.dart';
import '../../resources/app_strings.dart';
import '../../resources/app_values.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          final String location = GoRouterState.of(context).location;
          if (!location.startsWith(moviesPath)) {
            _onItemTapped(0, context);
          }
          return true;
        },
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: AppStrings.movies,
            icon: Icon(
              Icons.movie_creation_rounded,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.maps,
            icon: Icon(
              Icons.location_on,
              size: AppSize.s20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppStrings.animation,
            icon: Icon(
              Icons.animation,
              size: AppSize.s20,
            ),
          )
        ],
        currentIndex: _getSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith(moviesPath)) {
      return 0;
    }
    if (location.startsWith(googleMapsPath)) {
      return 1;
    }
    if (location.startsWith(riveAnimationPath)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.goNamed(moviesRoute);
        break;
      case 1:
        context.goNamed(googleMapsRoute);
        break;
      case 2:
        context.goNamed(riveAnimationRoute);
        break;
    }
  }
}
