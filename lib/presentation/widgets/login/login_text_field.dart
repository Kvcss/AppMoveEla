import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField._({
    required this.hint,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged,
    this.onToggleObscure,
    this.trailingLinkText,
    this.onTrailingLinkTap,
  });

  final String hint;
  final IconData? prefixIcon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  // apenas para password
  final VoidCallback? onToggleObscure;
  final String? trailingLinkText;
  final VoidCallback? onTrailingLinkTap;

  factory LoginTextField.email({
    required String hint,
    ValueChanged<String>? onChanged,
  }) {
    return LoginTextField._(
      hint: hint,
      prefixIcon: Icons.mail_outline_rounded,
      obscureText: false,
      onChanged: onChanged,
    );
  }

  factory LoginTextField.password({
    required String hint,
    bool obscureText = true,
    ValueChanged<String>? onChanged,
    VoidCallback? onToggleObscure,
    String? trailingLinkText,
    VoidCallback? onTrailingLinkTap,
  }) {
    return LoginTextField._(
      hint: hint,
      prefixIcon: Icons.lock_outline_rounded,
      obscureText: obscureText,
      onChanged: onChanged,
      onToggleObscure: onToggleObscure,
      trailingLinkText: trailingLinkText,
      onTrailingLinkTap: onTrailingLinkTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: cs.onSurface.withOpacity(.35), width: 1.2),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: obscureText ? TextInputType.visiblePassword : TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(prefixIcon, color: cs.onSurface.withOpacity(.85)),
            suffixIcon: onToggleObscure == null
                ? null
                : IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: onToggleObscure,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            enabledBorder: baseBorder,
            focusedBorder: baseBorder.copyWith(
              borderSide: BorderSide(color: cs.primary, width: 1.6),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.8),
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
