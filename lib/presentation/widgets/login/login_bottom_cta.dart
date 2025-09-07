import 'package:flutter/material.dart';

class LoginBottomCta extends StatelessWidget {
  const LoginBottomCta({super.key, required this.text, required this.action, this.onActionTap});
  final String text;
  final String action;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(.7),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: onActionTap,
          child: Text(
            action,
            style: TextStyle(
              color: cs.primary,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: cs.primary,
              decorationThickness: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
