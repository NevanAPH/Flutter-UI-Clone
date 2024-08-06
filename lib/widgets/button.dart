import 'package:flutter/material.dart';

// Import utilities
import '/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool loading;
  final Widget child;

  const PrimaryButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColor.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: ThemeColor.primary.withOpacity(0.6),
          disabledForegroundColor: Colors.white.withOpacity(0.6),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          minimumSize: const Size(double.infinity, 0),
        ),
        child: loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : child);
  }
}
