import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/ui/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'Profile',
      children: [
        SliverToBoxAdapter(
          child: OBElevatedButton(
            text: 'Logout',
            onPressed: () {
              FirebaseAuth.instance.signOut().then((_) {
                context.go(OBRoutes.root);
              });
            },
          ),
        ),
      ],
    );
  }
}
