// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:app/components/subtitle.dart';
import 'package:app/pages/profile.dart';
import 'package:app/utils/bored.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/hive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../components/app_button.dart';
import 'package:app/utils/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();

  void showActivity() async {
    final res = await Bored.getActivity();
    Toast().showToast(res, duration: 3);
  }

  void onAppButtonPressed() async {
    if (nameController.text.isEmpty) {
      Toast().showToast("Name can't be empty");
      return;
    }
    if (nameController.text.length < 3) {
      Toast().showToast("Name must be at least 3 characters long");
      return;
    }

    String result = await AppUtils.welcomeMessage(nameController.text);
    Toast().showToast(result);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(profileName: nameController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Subtitle(showActivity: showActivity, subtitleText: "Feel bored"),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Hi ! Who are you ',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 40,
                      ),
                    ),
                    TextSpan(
                      text: "?",
                      style: const TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 40,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showActivity();
                        },
                    ),
                  ],
                ),
              ),
              Subtitle(showActivity: showActivity, subtitleText: "Click me !"),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  controller: nameController,
                  cursorColor: Colors.grey,
                  cursorRadius: const Radius.circular(8),
                  decoration: const InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryLight),
                      ),
                      labelText: 'Enter your name',
                      hoverColor: Colors.white),
                ),
              ),
              const SizedBox(height: 80),
              AppButton(
                title: 'Open my profile !',
                onPressed: onAppButtonPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
