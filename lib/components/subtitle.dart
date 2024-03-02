import 'package:app/utils/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final String subtitleText;
  final VoidCallback showActivity;

  const Subtitle({
    super.key,
    required this.showActivity,
    required this.subtitleText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Transform(
          transform: Matrix4.rotationZ(-0.1),
          child: RichText(
              text: TextSpan(
            text: subtitleText,
            style: const TextStyle(color: AppColors.primaryLight, fontSize: 20),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showActivity();
              },
          )),
        ),
      ),
    );
  }
}
