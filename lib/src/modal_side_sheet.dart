import 'package:flutter/material.dart';

class ModalSideSheet extends StatelessWidget {
  const ModalSideSheet({
    super.key,
    required this.headline,
    required this.content,
    required this.bottomActions,
    required this.onClosePressed,
    this.containerWidth = _defaultWidth,
  }) : assert(containerWidth >= _minWidth && containerWidth <= _maxWidth,
            'SideSheet width must be between $_minWidth and $_maxWidth');

  final String headline;
  final Widget content;
  final List<Widget>? bottomActions;
  final double containerWidth;
  final VoidCallback onClosePressed;

  static const double _defaultWidth = 320;
  static const double _minWidth = 256;
  static const double _maxWidth = 400;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      child: SizedBox(
        width: containerWidth,
        child: Column(
          children: [
            _buildTopElements(
              context,
              colorScheme,
              textTheme,
              onClosePressed: onClosePressed,
            ),
            Expanded(child: content),
            if (bottomActions != null) _buildBottomActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopElements(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme, {
    required VoidCallback onClosePressed,
  }) {
    final padding = EdgeInsets.fromLTRB(24, 12, 12, 16);

    return Padding(
      padding: padding,
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
          CloseButton(
            onPressed: onClosePressed,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Column(
      children: [
        Divider(height: 1),
        Padding(
          padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [...bottomActions!],
          ),
        ),
      ],
    );
  }
}
