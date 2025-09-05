import 'package:flutter/material.dart';
import '../../themes/app_theme.dart';

class IconTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;

  const IconTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}
