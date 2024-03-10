import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ob/app/routes/ob_routes.dart';
import 'package:ob/ui/extensions/list_extensions.dart';
import 'package:ob/ui/widgets/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'Profile',
      children: [
        SliverToBoxAdapter(
          child: ProfileItemWidget(
            title: 'Space Details',
            icon: Icons.dashboard,
            onTap: () {
              context.push(OBRoutes.spaceDetails);
            },
          ),
        ),
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
      ].withSpaceBetween(height: 20, isSliver: true),
    );
  }
}

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      trailing: Icon(icon),
    );
  }
}
