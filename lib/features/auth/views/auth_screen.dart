import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quizzle/core/image_paths.dart';
import 'package:quizzle/features/auth/controllers/auth_controllers.dart';
import 'package:quizzle/features/home/views/home.dart';
import 'package:quizzle/utils/dialog.dart';
import 'package:quizzle/utils/textstyle.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Image.asset(
                ImagePaths.logo,
                width: 60.w,
              ),
              TextButton(
                onPressed: () {
                  ref.watch(authControllerNotifierProvider).when(
                    data: (data) {
                      isLoading.value = false;
                      debugPrint(data.toString());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
                    },
                    error: (error, _) {
                      isLoading.value = false;
                      showCustomDialog(
                        context: context,
                        title: "Error",
                        message: error.toString(),
                      );
                    },
                    loading: () {
                      isLoading.value = true;
                    },
                  );
                },
                child: Text(
                  "Continue as guest",
                  style: kTextStyle(15),
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, loading, _) {
              if (loading) {
                return Center(
                  child: SpinKitChasingDots(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
