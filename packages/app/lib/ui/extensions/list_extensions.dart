import 'package:flutter/material.dart';

extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> withSpaceBetween({
    double? width,
    double? height,
    bool isSliver = false,
  }) =>
      [
        for (int i = 0; i < length; i++) ...[
          if (i > 0)
            if (isSliver)
              SliverToBoxAdapter(
                child: SizedBox(
                  width: width,
                  height: height,
                ),
              )
            else
              SizedBox(
                width: width,
                height: height,
              ),
          this[i],
        ],
      ];
}
