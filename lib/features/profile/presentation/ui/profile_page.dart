import 'package:ob/ui/widgets/ob_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'Profile',
    );
  }
}
