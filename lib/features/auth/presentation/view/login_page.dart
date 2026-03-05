import 'package:clean/core/constants/ui_constants.dart';
import 'package:clean/core/di/injection.dart';
import 'package:clean/core/widgets/app_button.dart';
import 'package:clean/core/widgets/app_text_field.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = "/login";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt<AuthBloc>(), child: LoginScreen());
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(UIConstants.screenPaddingHorizontal),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              SizedBox(height: 48),
              Icon(Icons.flutter_dash, size: 120),
              SizedBox(height: 24),
              Text(
                l10n.loginOrSignup,
                textAlign: .center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              AppTextField(style: TextFieldStyle.filled, controller: _emailController, hint: 'Email'),
              SizedBox(height: UIConstants.formFieldSpacing),
              AppTextField(style: TextFieldStyle.filled, controller: _passwordController, hint: 'Password'),
              SizedBox(height: 48),
              AppButton(label: 'Log in',borderRadius: BorderRadius.circular(5), onPressed: () {
                
              },),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
