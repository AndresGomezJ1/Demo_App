import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_routes.dart';
import '../../../core/resources/app_values.dart';
import '../../data/models/movie_model.dart';
import 'image_with_shimmer.dart';

class SectionListViewCard extends StatelessWidget {
  final MovieModel movie;

  const SectionListViewCard({
    required this.movie,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: AppSize.s120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              context.pushNamed(
                movieDetailsRoute,
                params: {'movieId': movie.tmdbID.toString()},
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s8),
              child: ImageWithShimmer(
                imageUrl: movie.posterUrl,
                width: double.infinity,
                height: AppSize.s175,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_rate_rounded,
                    color: AppColors.ratingIconColor,
                    size: AppSize.s18,
                  ),
                  Text(
                    '${movie.voteAverage}/10',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
