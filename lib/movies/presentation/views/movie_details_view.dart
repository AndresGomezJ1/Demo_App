import 'package:flutter/material.dart';
import 'package:movie_app/movies/data/models/movie_details_model.dart';

import '../../../core/presentation/components/error_screen.dart';
import '../../../core/presentation/components/loading_indicator.dart';
import '../../../core/resources/app_values.dart';
import '../../../core/utils/functions.dart';
import '../../data/datasource/movies_remote_data_source.dart';
import '../components/details_card.dart';
import '../components/movie_card_details.dart';

class MovieDetailsView extends StatefulWidget {
  final int movieId;

  const MovieDetailsView({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MoviesRemoteDataSourceImpl().getMovieDetails(widget.movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return ErrorScreen(
                onTryAgainPressed: () {
                  setState(() {});
                },
              );
            } else {
              return MovieDetailsWidget(movieDetails: snapshot.data!);
            }
          }

          return const LoadingIndicator();
        });
  }
}

class MovieDetailsWidget extends StatelessWidget {
  const MovieDetailsWidget({
    required this.movieDetails,
    super.key,
  });

  final MovieDetailsModel movieDetails;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailsCard(
            mediaDetails: movieDetails,
            detailsWidget: MovieCardDetails(movieDetails: movieDetails),
          ),
          getOverviewSection(movieDetails.overview),
          const SizedBox(height: AppSize.s8),
        ],
      ),
    );
  }
}
