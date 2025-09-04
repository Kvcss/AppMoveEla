import 'package:flutter/material.dart';


class AppTextField extends StatelessWidget {
  const AppTextField({super.key, this.label, this.obscureText = false, this.suffix, this.keyboardType, this.onChanged});
  final String? label;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;


  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}