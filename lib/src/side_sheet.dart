import 'package:flutter/material.dart';

class SideSheet extends StatelessWidget {
  const SideSheet({
    super.key,
    required this.headline,
    required this.content,
    required this.bottomActions,
    this.containerWidth = _defaultWidth,
  }) : assert(containerWidth >= _minWidth && containerWidth <= _maxWidth,
            'SideSheet width must be between $_minWidth and $_maxWidth');

  final String headline;
  final Widget content;
  final List<Widget>? bottomActions;
  final double containerWidth;

  static const double _defaultWidth = 320;
  static const double _minWidth = 256;
  static const double _maxWidth = 400;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: containerWidth,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(
              left: BorderSide(
                color: colorScheme.outline,
                width: 1,
              ),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 12, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      headline,
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.close))
                ],
              ),
            ),
            Expanded(child: content),
            if (bottomActions != null)
              Column(
                children: [
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [...bottomActions!],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
