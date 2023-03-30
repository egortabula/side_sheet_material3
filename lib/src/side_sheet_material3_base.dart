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
/// The [addActions] boolean value determines if the side sheet should display
/// the action buttons or not. By default, it is set to true.
///
/// The [addDivider] boolean value determines if the side sheet should display
/// a divider between the body and action buttons or not. By default, it is set to true.
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
  bool addActions = true,
  bool addDivider = true,
  String confirmActionTitle = 'Save',
  String cancelActionTitle = 'Cancel',
  void Function()? confirmActionOnPressed,
  void Function()? cancelActionOnPressed,
}) async {
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Theme.of(context).colorScheme.scrim.withOpacity(0.3),
    barrierLabel: 'Material 3 side sheet',
    pageBuilder: ((context, animation, secondaryAnimation) {
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
        ),
      );
    }),
  );
}

class SideSheetMaterial3 extends StatelessWidget {
  final String header;
  final Widget body;
  final bool addBackIconButton;
  final bool addActions;
  final bool addDivider;
  final String confirmActionTitle;
  final String cancelActionTitle;
  final void Function()? confirmActionOnPressed;
  final void Function()? cancelActionOnPressed;
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
      borderRadius: const BorderRadius.horizontal(
        left: Radius.circular(28),
      ),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 256,
          maxWidth: 400,
          minHeight: size.height,
          maxHeight: size.height,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                addBackIconButton ? 16 : 24,
                16,
                16,
                16,
              ),
              child: _buildHeader(textTheme, context),
            ),
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
    return Row(
      children: [
        Visibility(
          visible: addBackIconButton,
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ),
        Text(
          header,
          style: textTheme.titleSmall,
        ),
        const Flexible(
          fit: FlexFit.tight,
          child: SizedBox(width: 12),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ],
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
                  if (cancelActionOnPressed == null) {
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
