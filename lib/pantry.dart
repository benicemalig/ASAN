import 'package:flutter/material.dart';

import 'package:asan/theme.dart';
import 'package:asan/widgets/app_bar.dart';
import 'package:asan/widgets/full_screen_dialog_header.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  void _showAddPantryItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          child: Scaffold(
            appBar: const FullScreenDialogHeader(
              screenTitle: 'Add Pantry Item',
            ),
            body: Padding(
              padding: const EdgeInsets.all(
                AsanSpacing.lg,
              ),
              child: Text(
                'Add a pantry item',
                style: AsanTextTheme.bodyMedium,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AsanAppBar(
        screenTitle: 'Pantry',
        icon: Icons.add_rounded,
        onIconPressed: () {
          _showAddPantryItemDialog(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          AsanSpacing.lg,
        ),
        child: Text(
          'Your pantry items',
          style: AsanTextTheme.bodyMedium,
        ),
      ),
    );
  }
}
