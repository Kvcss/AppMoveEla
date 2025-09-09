import 'package:flutter/material.dart';

import '../../../shared/theme/moveela_colors.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // No dark, inputs são brancos => usar ícones/texto escuros
    final Color fieldTextColor = isDark ? const Color(0xFF2D2D33) : cs.onBackground;
    final Color iconColor = isDark ? const Color(0xFF6E5D72) : cs.onSurface.withOpacity(.85);

    // Sem borda no dark (Figma), leve borda no light (vem do tema)
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(
        color: isDark ? Colors.transparent : cs.onSurface.withOpacity(.35),
        width: isDark ? 0 : 1.2,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          style: TextStyle(color: fieldTextColor, fontWeight: FontWeight.w500),
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: obscureText ? TextInputType.visiblePassword : TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(prefixIcon, color: iconColor),
            suffixIcon: onToggleObscure == null
                ? null
                : IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off, color: iconColor),
              onPressed: onToggleObscure,
            ),
            filled: true, // a cor vem do tema (branco no dark)
            enabledBorder: baseBorder,
            focusedBorder: baseBorder.copyWith(
              borderSide: BorderSide(
                color: isDark ? MoveElaColors.primary : cs.primary,
                width: 1.6,
              ),
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
                '${trailingLinkText!}!',
                style: TextStyle(
                  color: cs.onBackground,
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.2,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
