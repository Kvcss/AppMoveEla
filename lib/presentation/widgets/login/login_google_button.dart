import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Botão Google com ÍCONE MAIOR à esquerda e TEXTO CENTRALIZADO.
/// O Stack garante centralização real do texto sem ser deslocado pelo ícone.
class LoginGoogleButton extends StatelessWidget {
  const LoginGoogleButton({
    super.key,
    required this.text,
    this.onPressed,
    this.iconSize = 24,
  });

  final String text;
  final VoidCallback? onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: cs.onSurface.withOpacity(.35), width: 1.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 16), // espaço lateral
          foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            // TEXTO centralizado de verdade
            Center(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),

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
