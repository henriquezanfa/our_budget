import 'package:flutter/material.dart';
import 'package:ob/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return OBScreen.primary(
      title: 'Home',
      slivers: const [
        SliverToBoxAdapter(child: Text('Home')),
      ],
    );
  }
}
