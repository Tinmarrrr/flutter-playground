import 'package:app/components/app_button.dart';
import 'package:app/utils/waters.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/hive.dart';
import 'package:app/utils/toast.dart';

class Profile extends StatefulWidget {
  final String profileName;

  const Profile({
    Key? key,
    required this.profileName,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Waters waters = Waters();
  String favoriteWater = '';

  @override
  void initState() {
    super.initState();
    updateFavoriteWater();
  }

  void updateFavoriteWater() async {
    String result =
        await AppUtils.getFavoriteSparklingWater(widget.profileName);
    setState(() {
      favoriteWater = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, ${widget.profileName} !'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    FutureBuilder<String>(
                      future: AppUtils.getFavoriteSparklingWater(
                          widget.profileName),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          final updatedFavoriteWater = snapshot.data ?? "";
                          return Column(
                            children: [
                              Text(
                                updatedFavoriteWater.isEmpty
                                    ? 'You have not set your favorite sparkling water yet !\n\nYou should choose one !'
                                    : 'Your favorite sparkling water is $updatedFavoriteWater !\n\nYou can try another one !',
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    for (var waterBrand in waters.sparklingWater.keys)
                      AppButton(
                        title: waters.sparklingWater[waterBrand]!["name"],
                        image: waters.sparklingWater[waterBrand]!["image"],
                        description:
                            'From: ${waters.sparklingWater[waterBrand]!["from"]}',
                        onPressed: () async {
                          await AppUtils.setFavoriteSparklingWater(
                              widget.profileName,
                              waters.sparklingWater[waterBrand]!["name"]);
                          updateFavoriteWater();
                          Toast().showToast(
                              "Your favorite sparkling water is now ${waters.sparklingWater[waterBrand]!["name"]} !");
                        },
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
