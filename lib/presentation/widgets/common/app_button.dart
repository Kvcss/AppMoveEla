import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.text, this.onPressed});
  final String text;
  final VoidCallback? onPressed;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}