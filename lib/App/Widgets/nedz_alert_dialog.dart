import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neds/App/Utilities/Constants/AppColors.dart';

class NedzAlertDialog extends StatelessWidget {
  final Widget AlertIcon;
  final String description;
  final Widget? button;

  const NedzAlertDialog({
    Key? key,
    required this.AlertIcon,
    required this.description,
    this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Get.width / 1.5,
        width: Get.width / 1.5,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Material(
                child: InkWell(
                    onTap: Navigator.of(context).pop,
                    child: const Icon(
                      Icons.cancel_rounded,
                      color: AppColors.primary,
                    )),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AlertIcon,
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline5!.copyWith(height: 1.7),
                  ),
                  button != null
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 16.0,
                            ),
                            button!,
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
