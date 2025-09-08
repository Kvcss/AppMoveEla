import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Header rosa com canto inferior-esquerdo arredondado.
/// A logo fica GRANDE e levemente acima da borda inferior,
/// exatamente como no Figma (sobrepondo o início do conteúdo).
class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    this.asset = 'assets/images/logo_m_svg.svg',
    this.forceWhiteLogo = true,
  });

  final String asset;
  final bool forceWhiteLogo;

  bool _isTablet(double w) => w >= 600;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final w = MediaQuery.of(context).size.width;

    // Responsividade: tablet ganha tudo um pouco maior
    final bool tablet = _isTablet(w);
    final double headerHeight = tablet ? 220 : 150;
    final double cornerRadius = tablet ? 100 : 50;

    // A logo é dimensionada por largura máxima + clamp para não passar do bom senso
    final double maxLogoW = tablet ? 560 : 420;
    final double logoW = (w * 0.72).clamp(260, maxLogoW); // grande
    final double bottomOverlap = tablet ? -130 : -84; // fica acima do fim do header

    return SizedBox(
      height: headerHeight,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Fundo rosa com canto arredondado à esquerda
          Container(
            height: headerHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(cornerRadius),
              ),
            ),
          ),

          // Logo centralizada, bem grande, um pouco acima do fim do header
          Positioned(
            bottom: bottomOverlap,
            child: SvgPicture.asset(
              asset,
              width: logoW,
              fit: BoxFit.contain,
              colorFilter: forceWhiteLogo
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
