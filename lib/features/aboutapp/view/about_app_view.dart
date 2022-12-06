import 'package:butcity/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("عن التطبيق"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsManager.logo),
              const Text(
                'هذا التطبيق خاص بمدينتي يمكنك اضافه او الاطلاع علي الشكاوي شكرا لتعونك لجعل مدينتي جميله ونظيفه ومتطوره',
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
