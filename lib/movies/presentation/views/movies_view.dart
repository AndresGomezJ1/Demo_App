import 'package:flutter/material.dart';

import 'package:movie_app/movies/data/datasource/movies_remote_data_source.dart';
import 'package:movie_app/movies/data/models/movie_model.dart';

import '../../../core/presentation/components/error_screen.dart';
import '../../../core/presentation/components/loading_indicator.dart';
import '../../../core/resources/app_strings.dart';
import '../../../core/resources/app_values.dart';
import '../components/custom_slider.dart';
import '../components/section_header.dart';
import '../components/section_listview.dart';
import '../components/section_listview_card.dart';
import '../components/slider_card.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({super.key});

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MoviesRemoteDataSourceImpl().getMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return ErrorScreen(
                onTryAgainPressed: () {
                  setState(() {});
                },
              );
            } else {
              return MoviesWidget(
                nowPlayingMovies: snapshot.data![0],
                popularMovies: snapshot.data![1],
                topRatedMovies: snapshot.data![2],
              );
            }
          }

          return const LoadingIndicator();
        });
  }
}

class MoviesWidget extends StatelessWidget {
  final List<MovieModel> nowPlayingMovies;
  final List<MovieModel> popularMovies;
  final List<MovieModel> topRatedMovies;

  const MoviesWidget({
    super.key,
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSlider(
            itemBuilder: (context, itemIndex, _) {
              return SliderCard(
                movie: nowPlayingMovies[itemIndex],
                itemIndex: itemIndex,
              );
            },
          ),
          const SectionHeader(title: AppStrings.popularMovies),
          SectionListView(
            height: AppSize.s240,
            itemCount: popularMovies.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(movie: popularMovies[index]);
            },
          ),
          const SectionHeader(title: AppStrings.topRatedMovies),
          SectionListView(
            height: AppSize.s240,
            itemCount: topRatedMovies.length,
            itemBuilder: (context, index) {
              return SectionListViewCard(movie: topRatedMovies[index]);
            },
          ),
        ],
      ),
    );
  }
}
