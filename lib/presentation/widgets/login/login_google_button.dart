import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginGoogleButton extends StatelessWidget {
  const LoginGoogleButton({
    super.key,
    required this.text,
    this.onPressed,
    this.iconSize = 50,
  });

  final String text;
  final VoidCallback? onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    const Color googleBgDark = Colors.white;
    const Color googleBorderDark = Color(0xFFE4E1E6);
    const Color googleTextDark = Color(0xFF3C3C43);

    return SizedBox(
      height: 52,
      child: OutlinedButton(
        // Mantém o botão habilitado mesmo sem ação real (troque depois)
        onPressed: onPressed ?? () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: isDark ? googleBgDark : theme.colorScheme.surface,
          side: isDark
              ? const BorderSide(color: googleBorderDark, width: 1.2)
              : BorderSide(
            color: theme.colorScheme.onSurface.withOpacity(.35),
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          foregroundColor: isDark ? googleTextDark : theme.textTheme.bodyLarge?.color,
          minimumSize: const Size.fromHeight(52),
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            // Texto realmente centralizado
            Center(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            // Ícone à esquerda
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                'assets/images/logo_google.svg',
                width: iconSize,
                height: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
