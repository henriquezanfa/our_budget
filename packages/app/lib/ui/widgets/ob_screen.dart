import 'package:flutter/material.dart';

enum OBScreenType {
  primary,
  secondary,
}

class OBScreen extends StatelessWidget {
  factory OBScreen.primary({
    List<Widget>? children,
    String? title,
    List<Widget>? actions,
    SliverAppBar? appBar,
    VoidCallback? onRefresh,
  }) {
    return OBScreen._(
      title: title,
      actions: actions,
      appBar: appBar,
      onRefresh: onRefresh,
      children: children,
    );
  }

  factory OBScreen.secondary({
    List<Widget>? children,
    String? title,
    List<Widget>? actions,
    SliverAppBar? appBar,
    VoidCallback? onRefresh,
    Widget? bottomWidget,
    bool? resizeToAvoidBottomInset,
  }) {
    return OBScreen._(
      title: title,
      actions: actions,
      appBar: appBar,
      onRefresh: onRefresh,
      type: OBScreenType.secondary,
      bottomWidget: bottomWidget,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      children: children,
    );
  }

  const OBScreen._({
    this.children,
    this.title,
    this.actions,
    this.appBar,
    this.onRefresh,
    this.bottomWidget,
    this.type = OBScreenType.primary,
    this.resizeToAvoidBottomInset,
  }) : assert(title != null || appBar != null, 'title or appBar must be set');
  final String? title;
  final List<Widget>? actions;
  final List<Widget>? children;
  final SliverAppBar? appBar;
  final VoidCallback? onRefresh;
  final OBScreenType type;
  final Widget? bottomWidget;
  final bool? resizeToAvoidBottomInset;

  Widget _buildChild() {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        if (children != null)
          const SliverPadding(padding: EdgeInsets.only(top: 16)),
        // add padding in all slivers
        if (children != null)
          ...children!.map(
            (sliver) => SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: sliver,
            ),
          ),
      ],
    );
  }

  Widget _buildAppBar() {
    if (appBar != null) {
      return appBar!;
    }

    if (type == OBScreenType.secondary) {
      return SliverAppBar(
        title: Text(title!),
        actions: actions,
        floating: true,
        snap: true,
      );
    }

    return SliverAppBar(
      title: Text(title!),
      actions: actions,
      centerTitle: false,
      floating: true,
      snap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = _buildChild();

    final bottomWidget = this.bottomWidget != null
        ? SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16) +
                  const EdgeInsets.only(bottom: 16),
              child: this.bottomWidget,
            ),
          )
        : null;

    if (onRefresh != null) {
      const appBarHeight = 30.0;
      const edgeOffset = kToolbarHeight + appBarHeight;
      return Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: RefreshIndicator.adaptive(
          edgeOffset: edgeOffset,
          onRefresh: () async {
            onRefresh!();
            // ignore: inference_failure_on_instance_creation
            await Future.delayed(const Duration(seconds: 1));
          },
          child: SafeArea(
            child: child,
          ),
        ),
        bottomNavigationBar: bottomWidget,
      );
    }

    return Scaffold(
      body: SafeArea(child: child),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomWidget,
    );
  }
}
