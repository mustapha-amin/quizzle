import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/features/auth/controllers/user_data_controller.dart.dart';
import 'package:quizzle/features/game%20mode/views/game_mode.dart';
import 'package:quizzle/features/quiz/views/quiz_categories.dart';
import 'package:quizzle/shared/game_button.dart';
import 'package:quizzle/utils/avatar_url_gen.dart';
import 'package:quizzle/utils/dialog.dart';
import 'package:quizzle/utils/extensions.dart';
import 'package:sizer/sizer.dart';

class AvatarSetup extends ConsumerStatefulWidget {
  const AvatarSetup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarSetupState();
}

class _AvatarSetupState extends ConsumerState<AvatarSetup> {
  List<String> urls = generateAvatarUrl();
  String? selectedAvatar;
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataControllerProvider, (previous, next) {
      if (next == Status.data) {
        context.push(const QuizCategories());
      } else if (next == Status.error) {
        showCustomDialog(
          context: context,
          title: "Error",
          message: "An error occured",
        );
      }
    });
    return Scaffold(
      body: Column(
        children: [
          CircleAvatar(
            child: selectedAvatar != null
                ? Image.network(selectedAvatar!)
                : const ColoredBox(color: Colors.grey),
          ),
          Wrap(
            children: [
              ...urls.map(
                (url) => InkWell(
                  onTap: () {
                    setState(() {
                      selectedAvatar = url;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          url,
                          loadingBuilder: (context, _, __) {
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                      if (selectedAvatar == url)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Username",
            ),
          ),
          GameButton(
            label: "Save profile",
            callback: () async {
              await ref.read(userDataControllerProvider.notifier).saveUserData(
                    usernameController.text.trim(),
                    selectedAvatar!,
                  );
            },
            buttonColor: Colors.blue,
            labelColor: Colors.white,
            labelFontSize: 30,
          ),
        ],
      ),
    );
  }
}
