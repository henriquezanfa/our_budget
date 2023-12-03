import 'package:flutter/material.dart';

class OBScreen extends StatelessWidget {
  factory OBScreen.primary({
    List<Widget>? slivers,
    String? title,
    List<Widget>? actions,
    SliverAppBar? appBar,
  }) {
    return OBScreen._(
      title: title,
      actions: actions,
      slivers: slivers,
      appBar: appBar,
    );
  }

  const OBScreen._({
    this.slivers,
    this.title,
    this.actions,
    this.appBar,
  }) : assert(title != null || appBar != null, 'title or appBar must be set');
  final String? title;
  final List<Widget>? actions;
  final List<Widget>? slivers;
  final SliverAppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            appBar ??
                SliverAppBar(
                  title: Text(title!),
                  actions: actions,
                  centerTitle: false,
                  floating: true,
                  snap: true,
                ),
            // add padding in all slivers
            if (slivers != null)
              ...slivers!.map(
                (sliver) => SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: sliver,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
