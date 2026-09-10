import 'package:flutter/material.dart';
import 'package:asan/theme.dart';

class AsanAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String keepLabel;
  final String discardLabel;
  final VoidCallback? onKeepEditing;
  final VoidCallback? onDiscard;

  const AsanAlertDialog({
    super.key,
    this.title = 'Discard unsaved changes?',
    this.message = 'You have changes that won\'t be saved if you close.',
    this.keepLabel = 'Keep Editing',
    this.discardLabel = 'Discard',
    this.onKeepEditing,
    this.onDiscard,
  });

  static Future<bool?> show(
    BuildContext context, {
    String title = 'Discard unsaved changes?',
    String message = 'You have changes that won\'t be saved if you close.',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AsanAlertDialog(
        title: title,
        message: message,
        onKeepEditing: () => Navigator.pop(context, false),
        onDiscard: () => Navigator.pop(context, true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        width: 342,
        height: 142,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AsanColorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: double.infinity,
              height: 46,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AsanTextTheme.bodyMedium.copyWith(
                      height: 22 / 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: AsanTextTheme.labelSmall.copyWith(height: 16 / 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _AlertAction(label: keepLabel, onPressed: onKeepEditing),
                const SizedBox(width: 16),
                _AlertAction(
                  label: discardLabel,
                  color: AsanColorScheme.error,
                  onPressed: onDiscard,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertAction extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onPressed;

  const _AlertAction({
    required this.label,
    required this.onPressed,
    this.color = AsanColorScheme.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
          style: AsanTextTheme.labelSmall.copyWith(
            height: 16 / 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
