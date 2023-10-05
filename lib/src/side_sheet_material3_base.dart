import 'package:flutter/material.dart';

/// Displays a Material Design 3 side sheet as a general dialog.
///
/// The [header] is a required string for the title of the side sheet.
///
/// The [body] is a required widget for the content of the side sheet.
///
/// The [barrierDismissible] boolean value determines if the dialog can be dismissed
/// by tapping outside of it or not. By default, it is set to false.
///
/// The [addBackIconButton] boolean value determines if the side sheet should
/// display a back button to close the dialog. By default, it is set to false.
///
/// The [addCloseIconButton] boolean value determines if the side sheet should
/// display a close button to close the dialog. By default, it is set to `true`.
///
/// The [addActions] boolean value determines if the side sheet should display
/// the action buttons or not. By default, it is set to `true`.
///
/// The [addDivider] boolean value determines if the side sheet should display
/// a divider between the body and action buttons or not. By default, it is set to `true`.
///
/// The [confirmActionTitle] is a string value for the text of the confirm action button.
/// By default, it is set to 'Save'.
///
/// The [cancelActionTitle] is a string value for the text of the cancel action button.
/// By default, it is set to 'Cancel'.
///
/// The [confirmActionOnPressed] is a function that will be called when the confirm action button
/// is pressed. By default, it is set to null.
///
/// The [cancelActionOnPressed] is a function that will be called when the cancel action button
/// is pressed. By default, it is set to null.
///
/// The [onClose] is a function that will be called when the close action button
/// is pressed. By default, it will call `Navigator.pop(context)`.
///
/// The [onDismiss] is a function that will be called when you dismiss side sheet
/// By default, it is set to null`.
///
/// The [closeButtonTooltip] is a string value for the text of the close button tooltip.
/// By default, it is set to 'Close'.
///
/// The [backButtonTooltip] is a string value for the text of the back button tooltip.
/// By default, it is set to 'Back'.
///
/// Example:
/// ```
/// await showSideSheet(
///   context: context,
///   header: 'Edit Profile',
///   body: ProfileEditForm(),
///   addBackIconButton: true,
///   addActions: true,
///   addDivider: true,
///   confirmActionTitle: 'Save',
///   cancelActionTitle: 'Cancel',
///   confirmActionOnPressed: () {
///     // Do something
///   },
///   cancelActionOnPressed: () {
///     // Do something
///   },
/// );
/// ```
Future<void> showModalSideSheet(
  BuildContext context, {
  required Widget body,
  required String header,
  bool barrierDismissible = false,
  bool addBackIconButton = false,
  bool addCloseIconButton = true,
  bool addActions = true,
  bool addDivider = true,
  String confirmActionTitle = 'Save',
  String cancelActionTitle = 'Cancel',
  String? closeButtonTooltip = 'Close',
  String? backButtonTooltip = 'Back',
  void Function()? confirmActionOnPressed,
  void Function()? cancelActionOnPressed,
  void Function()? onDismiss,
  void Function()? onClose,
  Duration? transitionDuration,
}) async {
  await showGeneralDialog(
    context: context,
    transitionDuration: transitionDuration ?? Duration(milliseconds: 500),
    barrierDismissible: barrierDismissible,
    barrierColor: Theme.of(context).colorScheme.scrim.withOpacity(0.3),
    barrierLabel: 'Material 3 side sheet',
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(
          animation,
        ),
        child: child,
      );
    },
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.centerRight,
        child: SideSheetMaterial3(
          header: header,
          body: body,
          addBackIconButton: addBackIconButton,
          addActions: addActions,
          addDivider: addDivider,
          confirmActionOnPressed: confirmActionOnPressed,
          cancelActionOnPressed: cancelActionOnPressed,
          confirmActionTitle: confirmActionTitle,
          cancelActionTitle: cancelActionTitle,
          closeButtonTooltip: closeButtonTooltip,
          backButtonTooltip: backButtonTooltip,
          addCloseIconButton: addCloseIconButton,
          onClose: onClose,
        ),
      );
    },
  ).then(
    (value) {
      if (!barrierDismissible) return;
      if (onDismiss != null) {
        onDismiss();
      }
    },
  );
}

class SideSheetMaterial3 extends StatelessWidget {
  final String header;
  final Widget body;
  final bool addBackIconButton;
  final bool addCloseIconButton;
  final bool addActions;
  final bool addDivider;
  final String confirmActionTitle;
  final String cancelActionTitle;
  final String? closeButtonTooltip;
  final String? backButtonTooltip;

  final void Function()? confirmActionOnPressed;
  final void Function()? cancelActionOnPressed;
  final void Function()? onClose;
  const SideSheetMaterial3({
    super.key,
    required this.header,
    required this.body,
    required this.addBackIconButton,
    required this.addActions,
    required this.addDivider,
    required this.cancelActionOnPressed,
    required this.confirmActionOnPressed,
    required this.cancelActionTitle,
    required this.confirmActionTitle,
    required this.closeButtonTooltip,
    required this.backButtonTooltip,
    required this.addCloseIconButton,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Material(
      elevation: 1,
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(28)),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 256,
          maxWidth: size.width <= 600 ? size.width : 400,
          minHeight: size.height,
          maxHeight: size.height,
        ),
        child: Column(
          children: [
            _buildHeader(textTheme, context),
            Expanded(
              child: body,
            ),
            Visibility(
              visible: addActions,
              child: _buildFooter(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
    TextTheme textTheme,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.fromLTRB(addBackIconButton ? 16 : 24, 16, 16, 16),
      child: Row(
        children: [
          Visibility(
            visible: addBackIconButton,
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () {
                  if (onClose == null) {
                    Navigator.pop(context);
                  } else {
                    onClose!();
                  }
                },
                tooltip: backButtonTooltip,
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          Text(
            header,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleSmall,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(width: addCloseIconButton ? 12 : 8),
          ),
          Visibility(
            visible: addCloseIconButton,
            child: IconButton(
              onPressed: () {
                if (onClose == null) {
                  Navigator.pop(context);
                } else {
                  onClose!();
                }
              },
              tooltip: closeButtonTooltip,
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: addDivider,
          child: const Divider(
            indent: 24,
            endIndent: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 16, 24, 24),
          child: Row(
            children: [
              FilledButton(
                onPressed: confirmActionOnPressed,
                child: Text(confirmActionTitle),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  if (confirmActionOnPressed == null) {
                    Navigator.pop(context);
                  } else {
                    cancelActionOnPressed!();
                  }
                },
                child: Text(cancelActionTitle),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
