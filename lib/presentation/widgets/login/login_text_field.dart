import 'package:flutter/material.dart';

typedef _OnChanged = void Function(String v);
typedef _Void = void Function();

class LoginTextField extends StatelessWidget {
  const LoginTextField._({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.obscureText = false,
    this.onToggleObscure,
    this.trailingLinkText,
    this.onTrailingLinkTap,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
  });

  factory LoginTextField.email({
    Key? key,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required _OnChanged onChanged,
    String? errorText,
  }) {
    return LoginTextField._(
      key: key,
      hint: hint,
      icon: Icons.mail_outline,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      errorText: errorText,
    );
  }

  factory LoginTextField.password({
    Key? key,
    required String hint,
    required bool obscureText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required _OnChanged onChanged,
    required _Void onToggleObscure,
    String? trailingLinkText,
    _Void? onTrailingLinkTap,
    String? errorText,
  }) {
    return LoginTextField._(
      key: key,
      hint: hint,
      icon: Icons.lock_outline,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      obscureText: obscureText,
      onToggleObscure: onToggleObscure,
      trailingLinkText: trailingLinkText,
      onTrailingLinkTap: onTrailingLinkTap,
      textInputAction: TextInputAction.done,
      errorText: errorText,
    );
  }

  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final _OnChanged onChanged;

  final bool obscureText;
  final _Void? onToggleObscure;

  final String? trailingLinkText;
  final _Void? onTrailingLinkTap;

  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.outline.withOpacity(.6), width: 1.4),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.error, width: 1.6),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: errorText != null ? cs.error : cs.primary, width: 1.8),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: onToggleObscure != null
                ? IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: onToggleObscure,
            )
                : null,
            filled: true,
            fillColor: cs.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            enabledBorder: errorText == null ? baseBorder : errorBorder,
            focusedBorder: focusedBorder,
            errorText: errorText,
            errorStyle: TextStyle(color: cs.error, fontSize: 12),
          ),
        ),
        if (trailingLinkText != null) ...[
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onTrailingLinkTap,
              child: Text(
                trailingLinkText!,
                style: TextStyle(
                  color: cs.primary,
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
