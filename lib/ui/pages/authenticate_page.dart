import 'package:cinder/features/authentication/authentication_cubit.dart';
import 'package:cinder/ui/components/input_container.dart';
import 'package:cinder/ui/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthenticatePage extends StatefulWidget {
  AuthenticatePage({super.key});

  final inputLoginController = TextEditingController();
  final inputPasswordController = TextEditingController();

  @override
  State<AuthenticatePage> createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  void enter() {
    if (widget.inputLoginController.text.isNotEmpty ||
        widget.inputPasswordController.text.isNotEmpty) {
      context.read<AuthenticationCubit>().currentPage == PageType.login
          ? context.read<AuthenticationCubit>().login(
                widget.inputLoginController.text,
                widget.inputPasswordController.text,
              )
          : context.read<AuthenticationCubit>().register(
                widget.inputLoginController.text,
                widget.inputPasswordController.text,
              );
      widget.inputLoginController.clear();
      widget.inputPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<AuthenticationCubit>().currentPage);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/CinderLogo.png',
              scale: 3,
            ),
            const SizedBox(
              height: 60.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InputContainer(
                    hintText: "Login",
                    inputController: widget.inputLoginController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputContainer(
                    hintText: "Password",
                    inputController: widget.inputPasswordController,
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Material(
                    elevation: 1,
                    child: Container(
                      width: 200.0,
                      height: 40.0,
                      decoration: const BoxDecoration(
                          gradient: primaryColorGragient,
                          borderRadius: borderRadius),
                      child: TextButton(
                        onPressed: enter,
                        style: primaryButtonStyle,
                        child: Text(
                          context.read<AuthenticationCubit>().currentPage ==
                                  PageType.login
                              ? "Enter"
                              : "Register",
                          style: commonTextStyleLight,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(context.read<AuthenticationCubit>().currentPage ==
                              PageType.login
                          ? "New user?"
                          : "Already have account?"),
                      TextButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(0)),
                              splashFactory: NoSplash.splashFactory),
                          onPressed: () =>
                              context.read<AuthenticationCubit>().currentPage ==
                                      PageType.login
                                  ? context
                                      .read<AuthenticationCubit>()
                                      .changePage(PageType.register)
                                  : context
                                      .read<AuthenticationCubit>()
                                      .changePage(PageType.login),
                          child: Text(
                              context.read<AuthenticationCubit>().currentPage ==
                                      PageType.login
                                  ? "Sign Up!"
                                  : "Log in!"))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
