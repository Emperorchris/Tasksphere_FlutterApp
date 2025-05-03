import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasksphere_riverpod/models/login_model.dart';
import 'package:tasksphere_riverpod/models/user_model.dart';
import 'package:tasksphere_riverpod/pages/auth/signup_screen.dart';
import 'package:tasksphere_riverpod/pages/userDashboard/root_screen.dart';
import 'package:tasksphere_riverpod/providers/auth_provider.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _isDialogShowing = false;

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      final authContoller = ref.read(authControllerProvider.notifier);
      await authContoller.login(
        Login(email: _emailController.text, password: _passwordController.text),
      );
      // Clear the text fields after submission
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<User?>>(authControllerProvider, (_, state) {
      if (state.isLoading && !_isDialogShowing) {
        _isDialogShowing = true;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      } else if (_isDialogShowing && !state.isLoading) {
        Navigator.of(context, rootNavigator: true).pop();
        _isDialogShowing = false;
        if (state.hasError) {
          toastification.show(
            context: context,
            type: ToastificationType.error,
            title: Text(
              state.error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
            autoCloseDuration: const Duration(seconds: 5),
          );
        }

        if (!state.hasError && state.hasValue) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            title: const Text('Login successful'),
            autoCloseDuration: const Duration(seconds: 5),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RootScreen()),
          );
        }
        if (state.hasValue) {
          // print("Hello");
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (_) => const HomeScreen()),
          // );
        }
      }
    });

    // final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                elevation: 21,
                shadowColor: const Color.fromARGB(255, 80, 29, 180),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 80, 29, 180),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter your password";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: _showPassword,
                              onChanged: (value) {
                                setState(() {
                                  _showPassword = value ?? false;
                                });
                              },
                            ),
                            const Text('Show password'),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Color.fromARGB(255, 80, 29, 180),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            submitForm();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 80, 29, 180),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
