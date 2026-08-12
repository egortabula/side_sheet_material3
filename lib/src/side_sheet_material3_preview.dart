import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'side_sheet_material3_base.dart';

PreviewThemeData sideSheetPreviewTheme() {
  return PreviewThemeData(
    materialLight: ThemeData.light(useMaterial3: true),
    materialDark: ThemeData.dark(useMaterial3: true),
  );
}

@Preview(
  name: 'Modal side sheet',
  group: 'Side sheet',
  size: Size(412, 915),
  theme: sideSheetPreviewTheme,
)
WidgetBuilder modalSideSheetPreview() {
  return (context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: const _PreviewSideSheetHome(
        header: 'Graduación de Inés',
        body: _GraduationSideSheetBody(),
        addBackIconButton: true,
      ),
    );
  };
}

@Preview(
  name: 'Minimal',
  group: 'Side sheet',
  size: Size(412, 915),
  theme: sideSheetPreviewTheme,
)
WidgetBuilder minimalSideSheetPreview() {
  return (context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: const _PreviewSideSheetHome(
        header: 'Side sheet',
        body: SizedBox.shrink(),
      ),
    );
  };
}

@Preview(
  name: 'Tablet with content',
  group: 'Side sheet',
  size: Size(1024, 768),
  theme: sideSheetPreviewTheme,
)
WidgetBuilder tabletSideSheetPreview() {
  return (context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: const _PreviewSideSheetHome(
        header: 'Graduación de Inés',
        body: _GraduationSideSheetBody(),
        addBackIconButton: true,
      ),
    );
  };
}

class _PreviewSideSheetHome extends StatefulWidget {
  final String header;
  final Widget body;
  final bool addBackIconButton;

  const _PreviewSideSheetHome({
    required this.header,
    required this.body,
    this.addBackIconButton = false,
  });

  @override
  State<_PreviewSideSheetHome> createState() => _PreviewSideSheetHomeState();
}

class _PreviewSideSheetHomeState extends State<_PreviewSideSheetHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _openSideSheet();
    });
  }

  void _openSideSheet() {
    showModalSideSheet(
      context,
      header: widget.header,
      body: widget.body,
      addBackIconButton: widget.addBackIconButton,
      addActions: false,
      useRootNavigator: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: _openSideSheet,
          child: const Text('Open'),
        ),
      ),
    );
  }
}

class _GraduationSideSheetBody extends StatelessWidget {
  const _GraduationSideSheetBody();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      children: [
        const Row(
          children: [
            Expanded(
              child: _SideSheetAction(
                icon: Icons.share_outlined,
                label: 'Share',
              ),
            ),
            Expanded(
              child: _SideSheetAction(icon: Icons.add, label: 'Add to'),
            ),
            Expanded(
              child: _SideSheetAction(
                icon: Icons.delete_outline,
                label: 'Trash',
              ),
            ),
            Expanded(
              child: _SideSheetAction(
                icon: Icons.archive_outlined,
                label: 'Archive',
              ),
            ),
          ],
        ),
        const Divider(height: 48),
        Text('Send', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 24),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _Recipient(
                initials: 'AO',
                name: 'Alejandro Ortega',
                color: Color(0xffd8a47f),
              ),
            ),
            Expanded(
              child: _Recipient(
                initials: 'O',
                name: 'Oli Ortega',
                color: Color(0xffb98b6b),
              ),
            ),
            Expanded(
              child: _Recipient(
                initials: 'CV',
                name: 'Carmen Villanueva',
                color: Color(0xff9aabb3),
              ),
            ),
            Expanded(
              child: _Recipient(
                initials: 'AR',
                name: 'Ana Russo',
                color: Color(0xffd69b9a),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SideSheetAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SideSheetAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(icon, size: 24), const SizedBox(height: 8), Text(label)],
    );
  }
}

class _Recipient extends StatelessWidget {
  final String initials;
  final String name;
  final Color color;

  const _Recipient({
    required this.initials,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 34, backgroundColor: color, child: Text(initials)),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
