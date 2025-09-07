import 'package:flutter/material.dart';

class LoginOrDivider extends StatelessWidget {
  const LoginOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(child: Container(height: 1.2, color: cs.primary.withOpacity(.55))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('OU', style: TextStyle(color: cs.primary, fontWeight: FontWeight.w600)),
        ),
        Expanded(child: Container(height: 1.2, color: cs.primary.withOpacity(.55))),
      ],
    );
  }
}
