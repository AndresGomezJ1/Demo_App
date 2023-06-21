import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/animations/presentation/components/rive_action_button.dart';
import 'package:rive/rive.dart';

import '../../../core/presentation/components/error_screen.dart';
import '../../../core/resources/app_values.dart';

class RiveAnimationCard extends StatefulWidget {
  final String? firstTriggerName;
  final String? secondTriggerName;
  final IconData? iconFirstTrigger;
  final IconData? iconSecondTrigger;

  final String? controllerFirstAction;
  final String? controllerSecondAction;
  final Function()? onTapFirstController;
  final Function()? onTapSecondController;

  final double height;
  final String artboardName;
  final String controllerName;
  final String riveAssetPath;

  const RiveAnimationCard(
      {super.key,
      required this.artboardName,
      required this.controllerName,
      required this.riveAssetPath,
      this.height = AppSize.s300,
      this.controllerFirstAction,
      this.controllerSecondAction,
      this.onTapFirstController,
      this.onTapSecondController,
      this.firstTriggerName,
      this.secondTriggerName,
      this.iconFirstTrigger,
      this.iconSecondTrigger});

  @override
  State<RiveAnimationCard> createState() => _RiveAnimationCardState();
}

class _RiveAnimationCardState extends State<RiveAnimationCard> {
  Artboard? riveArtboard;

  SMIBool? firstControllerAction;
  SMIBool? secondControllerAction;
  SMITrigger? firstTriggerAction;
  SMITrigger? secondTriggerAction;

  @override
  void initState() {
    super.initState();
    rootBundle.load(widget.riveAssetPath).then((data) async {
      try {
        final file = RiveFile.import(data);
        final artboard = file.artboardByName(widget.artboardName);
        var controller = StateMachineController.fromArtboard(
            artboard!, widget.controllerName);
        if (controller != null) {
          artboard.addController(controller);

          if (widget.controllerFirstAction != null) {
            firstControllerAction =
                controller.findSMI(widget.controllerFirstAction!);
            firstControllerAction!.value = true;
          }
          if (widget.controllerSecondAction != null) {
            secondControllerAction =
                controller.findSMI(widget.controllerSecondAction!);
            secondControllerAction!.value = true;
          }
          if (widget.firstTriggerName != null) {
            firstTriggerAction = controller.findSMI(widget.firstTriggerName!);
          }
          if (widget.secondTriggerName != null) {
            secondTriggerAction = controller.findSMI(widget.secondTriggerName!);
          }
        }
        setState(() => riveArtboard = artboard);
      } catch (e) {
        return ErrorScreen(
          onTryAgainPressed: () {
            setState(() {});
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return riveArtboard == null
        ? const SizedBox()
        : Column(
            children: [
              SizedBox(
                height: widget.height,
                child: Rive(
                  fit: BoxFit.fitWidth,
                  artboard: riveArtboard!,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  widget.controllerFirstAction != null
                      ? RiveActionButton(
                          onTapAction: () => setState(
                              () => secondControllerAction!.value = false),
                          icon: Icons.play_arrow,
                        )
                      : const SizedBox(),
                  widget.controllerSecondAction != null
                      ? RiveActionButton(
                          onTapAction: () => setState(
                              () => secondControllerAction!.value = true),
                          icon: Icons.stop,
                        )
                      : const SizedBox(),
                  widget.firstTriggerName != null
                      ? RiveActionButton(
                          onTapAction: () {
                            if (secondControllerAction != null &&
                                secondControllerAction!.value == false) {
                              firstTriggerAction!.value = true;
                            } else if (secondControllerAction == null) {
                              firstTriggerAction!.value = true;
                            }
                          },
                          icon: widget.iconFirstTrigger!,
                        )
                      : const SizedBox(),
                  widget.secondTriggerName != null
                      ? RiveActionButton(
                          onTapAction: () {
                            if (secondControllerAction != null &&
                                secondControllerAction!.value == false) {
                              secondTriggerAction!.value = true;
                            } else if (secondControllerAction == null) {
                              secondTriggerAction!.value = true;
                            }
                          },
                          icon: widget.iconSecondTrigger!,
                        )
                      : const SizedBox()
                ],
              ),
            ],
          );
  }
}
