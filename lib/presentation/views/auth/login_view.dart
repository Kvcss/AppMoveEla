import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/login_viewmodel.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text('MoveEla', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),
              AppTextField(
                label: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                onChanged: vm.onEmailChanged,
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'Senha',
                obscureText: vm.obscure,
                onChanged: vm.onPasswordChanged,
                suffix: IconButton(
                  icon: Icon(vm.obscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: vm.toggleObscure,
                ),
              ),
              const SizedBox(height: 20),
              AppButton(
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
              const Spacer(),
              Text(
                'Ao entrar você concorda com os Termos e a Política de Privacidade.',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}