import 'package:flutter/material.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.homepage);
        timer.cancel();
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LoadingAnimationWidget.prograssiveDots(
              color: Colors.blue,
              size: 100,
            ),
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text.rich(
              TextSpan(
                text: 'Make Posts with ',
                style: TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Festival Post Maker',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
