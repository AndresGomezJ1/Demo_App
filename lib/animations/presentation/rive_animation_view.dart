import 'package:flutter/material.dart';
import 'package:movie_app/animations/presentation/components/rive_animation_card.dart';

import '../../core/resources/app_values.dart';

class RiveAnimationView extends StatefulWidget {
  const RiveAnimationView({Key? key}) : super(key: key);

  @override
  State<RiveAnimationView> createState() => _RiveAnimationViewState();
}

class _RiveAnimationViewState extends State<RiveAnimationView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Spacer(),
          RiveAnimationCard(
              height: AppSize.s300,
              artboardName: 'New Artboard',
              controllerName: 'State Machine 1',
              controllerFirstAction: 'start',
              controllerSecondAction: 'Out',
              firstTriggerName: 'Jump',
              iconFirstTrigger: Icons.arrow_upward,
              riveAssetPath: 'assets/riveAssets/223-931-android-fun.riv'),
          Spacer(),
          RiveAnimationCard(
              height: AppSize.s300,
              artboardName: 'New Artboard',
              controllerName: 'State Machine 1',
              firstTriggerName: 'In',
              secondTriggerName: 'Hit',
              iconFirstTrigger: Icons.play_arrow,
              iconSecondTrigger: Icons.stop,
              riveAssetPath: 'assets/riveAssets/zombie_character.riv'),
          Spacer(),
        ],
      ),
    );
  }
}
