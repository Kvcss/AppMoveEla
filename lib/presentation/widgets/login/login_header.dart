import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Header rosa com canto inferior-esquerdo arredondado.
/// A logo é dimensionada pela ALTURA disponível (cabe sempre)
/// e fica `bottom` px acima da borda inferior.
class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    this.height = 180,              // altura do header
    this.radius = 90,
    this.logoHeight,
    this.logoWidthFraction = 0.8,
    this.forceWhite = true,
    this.logoBottomOffset = -100,    // <<< controla a distância até a borda inferior
  });

  final double height;
  final double radius;
  final double? logoHeight;
  final double logoWidthFraction;
  final bool forceWhite;
  final double logoBottomOffset;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final screenW = MediaQuery.of(context).size.width;

    // Se você passar `logoHeight`, usa ele. Senão, calcula pela largura da tela.
    final double logoH = logoHeight ?? screenW * logoWidthFraction;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radius),
              ),
            ),
            clipBehavior: Clip.antiAlias,
          ),

          Positioned(
            bottom: logoBottomOffset, // <<< agora desce mais
            child: SvgPicture.asset(
              'assets/images/logo_m_svg.svg',
              height: logoH,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              colorFilter: forceWhite
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}