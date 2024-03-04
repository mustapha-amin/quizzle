import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizzle/shared/game_button.dart';
import 'package:quizzle/utils/avatar_url_gen.dart';
import 'package:sizer/sizer.dart';

class AvatarSetup extends ConsumerStatefulWidget {
  const AvatarSetup({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AvatarSetupState();
}

class _AvatarSetupState extends ConsumerState<AvatarSetup> {
  List<String> urls = generateAvatarUrl();
  String? selectedAvatar;
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CircleAvatar(
            child: selectedAvatar != null
                ? Image.asset(selectedAvatar!)
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
            controller: userNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Username",
            ),
          ),
          GameButton(
            label: "Save profile",
            callback: () {},
            height: 10.h,
            width: 100.w,
            buttonColor: Colors.blue,
            labelColor: Colors.white,
            labelFontSize: 30,
          ),
        ],
      ),
    );
  }
}
