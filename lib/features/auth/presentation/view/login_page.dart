import 'package:clean/core/constants/ui_constants.dart';
import 'package:clean/core/di/injection.dart';
import 'package:clean/core/ui/app_snackbar.dart';
import 'package:clean/core/validation/validators.dart';
import 'package:clean/core/widgets/app_button.dart';
import 'package:clean/core/widgets/app_text_field.dart';
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean/features/dashboard/presentation/view/dashboard_page.dart';
import 'package:clean/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: "emilys");
  final _passwordController = TextEditingController(text: "emilyspass");

  @override
  void initState() {
    super.initState();
    _onFieldChanged(username: _emailController.text, password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(UIConstants.screenPaddingHorizontal),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// Bloc Listener
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      success: (loginResponse) {
                        AppSnackbar.show(
                          context,
                          'Welcome back, ${loginResponse.firstName ?? loginResponse.username}!',
                          type: SnackbarType.success,
                        );
                        // Navigate to dashboard and clear navigation stack
                        context.go(DashboardPage.routeName);
                      },
                      failure: (message) {
                        AppSnackbar.show(
                          context,
                          message,
                          type: SnackbarType.error,
                        );
                      },
                    );
                  },
                  child: const SizedBox.shrink(),
                ),
                const SizedBox(height: 48),
                const Icon(Icons.flutter_dash, size: 120),
                const SizedBox(height: 24),
                Text(
                  l10n.loginOrSignup,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  style: TextFieldStyle.filled,
                  controller: _emailController,
                  hint: 'Username',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) => _onFieldChanged(username: value),
                  validator: Validators.username,
                ),
                const SizedBox(height: UIConstants.formFieldSpacing),
                AppTextField(
                  style: TextFieldStyle.filled,
                  controller: _passwordController,
                  hint: 'Password',
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  validator: Validators.password,
                  onChanged: (value) => _onFieldChanged(password: value),
                  onSubmitted: (_) => _handleLogin(),
                ),
                const SizedBox(height: 48),
                BlocSelector<AuthBloc, AuthState, bool>(
                  selector: (state) => state.maybeWhen(orElse: () => false, validate: (isFormValid) => isFormValid),
                  builder: (context, isValidForm) => BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return AppButton(
                        label: l10n.login,
                        borderRadius: BorderRadius.circular(5),
                        isDisabled: !isValidForm,
                        isLoading: state is Loading,
                        onPressed: _handleLogin,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFieldChanged({String? username, String? password}) {
    context.read<AuthBloc>().add(AuthEvent.validate(username: username, password: _passwordController.text));
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(AuthEvent.login(username: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
