import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/animations/presentation/rive_animation_view.dart';
import 'package:movie_app/maps/presentation/google_maps_view.dart';

import '../../movies/presentation/views/movie_details_view.dart';
import '../../movies/presentation/views/movies_view.dart';
import '../presentation/pages/main_page.dart';
import 'app_routes.dart';

class AppRouter {
  GoRouter router = GoRouter(
    initialLocation: moviesPath,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            name: moviesRoute,
            path: moviesPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MoviesView(),
            ),
            routes: [
              GoRoute(
                name: movieDetailsRoute,
                path: movieDetailsPath,
                pageBuilder: (context, state) => CupertinoPage(
                  child: MovieDetailsView(
                    movieId: int.parse(state.params['movieId']!),
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            name: googleMapsRoute,
            path: googleMapsPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: GoogleMapView(),
            ),
          ),
          GoRoute(
            name: riveAnimationRoute,
            path: riveAnimationPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: RiveAnimationView(),
            ),
          )
        ],
      )
    ],
  );
}
