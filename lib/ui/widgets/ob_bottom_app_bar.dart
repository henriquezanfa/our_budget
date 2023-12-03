import 'package:flutter/material.dart';

const _kHorizontalMargin = 0;
const _kAnimationDuration = Duration(milliseconds: 100);
const _kIndicatorHeight = 4.0;
const _kIndicatorWidth = 20.0;
const _childSize = 36.0;

class OBBottomAppBar extends StatefulWidget {
  const OBBottomAppBar({
    required this.items,
    required this.onTabPress,
    this.currentIndex = 0,
    super.key,
  });
  final int currentIndex;
  final List<Widget> items;
  final ValueChanged<int> onTabPress;

  @override
  State<OBBottomAppBar> createState() => _OBBottomAppBarState();
}

class _OBBottomAppBarState extends State<OBBottomAppBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void onTabPress(int index) {
    widget.onTabPress(index);
    if (widget.currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;

    final childWidth = (width - 2 * _kHorizontalMargin) / widget.items.length;
    final indicatorCenter = childWidth / 2;
    final leftPosition =
        (_currentIndex * childWidth) + indicatorCenter - (20 / 2);

    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.primary.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              duration: _kAnimationDuration,
              curve: Curves.easeInOut,
              top: 6,
              left: leftPosition,
              child: AnimatedContainer(
                duration: _kAnimationDuration,
                height: _kIndicatorHeight,
                width: _kIndicatorWidth,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(widget.items.length, (index) {
                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onTabPress(index),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SizedBox(
                        height: _childSize,
                        width: _childSize,
                        child: Theme(
                          data: theme.copyWith(
                            iconTheme: theme.iconTheme.copyWith(
                              color: widget.currentIndex == index
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.primary.withOpacity(0.4),
                              size: 28,
                            ),
                          ),
                          child: widget.items[index],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
