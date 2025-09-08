import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/login_viewmodel.dart';
import '../../widgets/login/login_header.dart';
import '../../widgets/login/login_greeting.dart';
import '../../widgets/login/login_text_field.dart';
import '../../widgets/login/login_primary_button.dart';
import '../../widgets/login/login_or_divider.dart';
import '../../widgets/login/login_google_button.dart';
import '../../widgets/login/login_bottom_cta.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  bool _isTablet(BoxConstraints c) => c.maxWidth >= 600;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();

    return Scaffold(
      // NUNCA force branco aqui, deixa o tema aplicar (light/dark)
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = MediaQuery.of(context).size;
            final h = size.height;
            final bool tablet = _isTablet(constraints);

            // padding lateral proporcional com limites
            final double sidePadding = tablet
                ? (constraints.maxWidth * 0.08).clamp(32, 64).toDouble()
                : 20.0;

            // limitar largura do formulário pra não “esticar” no tablet
            final double contentMaxWidth = tablet ? 640 : 520;

            // espaçamentos responsivos (percentual da altura, com clamp pra não exagerar)
            final double gapSm  = (h * .012).clamp(8.0, 14.0);   // ~10–12 px
            final double gapMd  = (h * .02 ).clamp(14.0, 24.0);  // ~16–22 px
            final double gapLg  = (h * .04 ).clamp(22.0, 36.0);  // ~24–34 px
            final double gapXL  = (h * .08 ).clamp(32.0, 72.0);  // ~40–70 px

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // HEADER com logo grande sobreposta
                    const LoginHeader(),

                    // CONTEÚDO CENTRALIZADO E COM LARGURA MÁXIMA
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sidePadding),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: contentMaxWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: gapXL),

                              const LoginGreeting(
                                title: 'Seja bem-vinda!',
                                subtitle: 'Entre para continuar',
                              ),

                              SizedBox(height: gapLg),

                              // Email
                              LoginTextField.email(
                                hint: 'Email',
                                onChanged: vm.onEmailChanged,
                              ),

                              SizedBox(height: gapSm),

                              LoginTextField.password(
                                hint: 'Password',
                                obscureText: vm.obscure,
                                onChanged: vm.onPasswordChanged,
                                onToggleObscure: vm.toggleObscure,
                                trailingLinkText: 'Esqueci minha senha',
                                onTrailingLinkTap: () {
                                  // TODO: recuperar senha
                                },
                              ),

                              SizedBox(height: gapLg),

                              LoginPrimaryButton(
                                text: vm.loading ? 'Entrando…' : 'Entrar',
                                onPressed: vm.loading
                                    ? null
                                    : () async {
                                  try {
                                    await vm.submit(context);
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    }
                                  }
                                },
                              ),

                              SizedBox(height: gapMd),

                              const LoginOrDivider(),

                              SizedBox(height: gapSm),

                              // Google
                              const LoginGoogleButton(
                                text: 'Entrar com o google',
                              ),

                              SizedBox(height: gapXL),

                              LoginBottomCta(
                                text: 'Se ainda não possui uma conta',
                                action: 'Cadastre-se',
                                onActionTap: () {
                                  // TODO: navegar para /signup
                                },
                              ),

                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
