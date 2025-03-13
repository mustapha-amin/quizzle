import 'package:flutter/services.dart';
import 'package:quizzle/features/quiz/views/quiz_categories.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/features/auth/views/auth_screen.dart';
import 'package:quizzle/firebase_options.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/typedefs.dart';
import 'core/providers.dart';
import 'dart:developer';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'features/game mode/views/game_mode.dart';

FutureVoid main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
 SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(onStateChange: (state) {
      log(state.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    return Sizer(
      builder: (context, _, __) {
        return ShadApp.material(
          debugShowCheckedModeBanner: false,
          theme: ShadThemeData(
              colorScheme: ShadColorScheme.fromName('green'),
              brightness: Brightness.light),
          home: firebaseAuth.currentUser == null
              ? const AuthScreen()
              : const QuizCategories(),
        );
      },
    );
  }
}
