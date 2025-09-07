import 'package:flutter/material.dart';

class LoginPrimaryButton extends StatelessWidget {
  const LoginPrimaryButton({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: FilledButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}
