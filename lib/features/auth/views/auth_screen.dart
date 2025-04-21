import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzle/core/image_paths.dart';
import 'package:quizzle/features/auth/controllers/auth_controllers.dart';
import 'package:quizzle/features/quiz/views/quiz_categories.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:sizer/sizer.dart';

import '../../game mode/views/game_mode.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Quizzle",
                style: kTextStyle(
                  50,
                  color: Colors.black,
                  isBold: true,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                ImagePaths.logo,
                width: 50.w,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 70.w,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    try {
                      ref
                          .read(authControllerNotifierProvider.notifier)
                          .signInGoogle(context, ref);
                    } catch (e) {
                      log(e.toString());
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImagePaths.google,
                        width: 8.w,
                      ),
                      Text(
                        "Sign in with google",
                        style:
                            kTextStyle(18, isBold: true, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(authControllerNotifierProvider.notifier)
                      .signInAnon();
                 
                },
                child: Text(
                  "Continue as guest",
                  style: kTextStyle(
                    15,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ).centralize(),
          Center(
            child: switch (
                ref.watch(authControllerNotifierProvider).isLoading) {
              true => SpinKitChasingDots(
                  color: Theme.of(context).primaryColor,
                  duration: const Duration(milliseconds: 800),
                ),
              _ => const SizedBox()
            },
          )
        ],
      ),
    );
  }
}
