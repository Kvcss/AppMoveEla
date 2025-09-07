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

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    final padding = MediaQuery.of(context).size.width >= 420 ? 28.0 : 20.0;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const LoginHeader(),

                    // Conteúdo
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 8),
                          const LoginGreeting(
                            title: 'Seja bem-vinda!',
                            subtitle: 'Entre para continuar',
                          ),
                          const SizedBox(height: 18),

                          // Email
                          LoginTextField.email(
                            hint: 'Email',
                            onChanged: vm.onEmailChanged,
                          ),
                          const SizedBox(height: 12),

                          // Senha (+ “Esqueci minha senha” no canto direito)
                          LoginTextField.password(
                            hint: 'Password',
                            obscureText: vm.obscure,
                            onChanged: vm.onPasswordChanged,
                            onToggleObscure: vm.toggleObscure,
                            trailingLinkText: 'Esqueci minha senha',
                            onTrailingLinkTap: () {
                              // TODO: navegar para recuperação de senha
                            },
                          ),

                          const SizedBox(height: 22),

                          // Botão Entrar
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

                          const SizedBox(height: 22),

                          const LoginOrDivider(),

                          const SizedBox(height: 14),

                          // Google
                          LoginGoogleButton(
                            text: 'Entrar com o google',
                            onPressed: () {
                              // TODO: vm.signInWithGoogle()
                            },
                          ),

                          const SizedBox(height: 24),

                          // CTA inferior
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
