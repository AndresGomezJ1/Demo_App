import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/movies/data/models/movie_model.dart';
import 'package:movie_app/movies/presentation/components/slider_card_image.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_constants.dart';
import '../../../core/resources/app_routes.dart';
import '../../../core/resources/app_values.dart';

class SliderCard extends StatelessWidget {
  const SliderCard({
    super.key,
    required this.movie,
    required this.itemIndex,
  });

  final MovieModel movie;
  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          movieDetailsRoute,
          params: {'movieId': movie.tmdbID.toString()},
        );
      },
      child: SafeArea(
        child: Stack(
          children: [
            SliderCardImage(imageUrl: movie.backdropUrl),
            Padding(
              padding: const EdgeInsets.only(
                right: AppPadding.p16,
                left: AppPadding.p16,
                bottom: AppPadding.p10,
              ),
              child: SizedBox(
                height: size.height * 0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      style: textTheme.titleMedium,
                    ),
                    Text(
                      movie.releaseDate,
                      style: textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          AppConstants.carouselSliderItemsCount,
                              (indexDot) {
                            return Container(
                              margin:
                              const EdgeInsets.only(right: AppMargin.m10),
                              width: indexDot == itemIndex
                                  ? AppSize.s30
                                  : AppSize.s6,
                              height: AppSize.s6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppSize.s6),
                                color: indexDot == itemIndex
                                    ? AppColors.primary
                                    : AppColors.inactiveColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
