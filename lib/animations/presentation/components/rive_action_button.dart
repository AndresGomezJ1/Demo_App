import 'package:flutter/material.dart';
import 'package:movie_app/core/resources/app_colors.dart';

import '../../../core/resources/app_values.dart';

class RiveActionButton extends StatelessWidget {
  final Function() onTapAction;
  final IconData icon;

  const RiveActionButton({
    super.key,
    required this.onTapAction,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: AppColors.primary, // Button color
        child: InkWell(
          splashColor: AppColors.secondary, // Splash color
          onTap: onTapAction,
          child: SizedBox(
              width: AppSize.s56, height: AppSize.s56, child: Icon(icon)),
        ),
      ),
    );
  }
}
