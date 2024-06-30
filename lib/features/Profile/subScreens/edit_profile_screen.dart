import 'package:ai_chatbot/features/Profile/subScreens/widgets/change_password_form.dart';
import 'package:ai_chatbot/features/Profile/subScreens/widgets/edit_profile_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              children: [
                Expanded(child: EditProfileForm()),
                Expanded(child: ChangePasswordForm()),
              ],
            );
          } else {
            return Column(
              children: [
                EditProfileForm(),
                ChangePasswordForm(),
              ],
            );
          }
        },
      ),
    );
  }
}
