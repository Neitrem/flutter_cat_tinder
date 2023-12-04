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
      context.read<AuthenticationCubit>().pageData.mainButtonAction(
            login: widget.inputLoginController.text,
            password: widget.inputPasswordController.text,
          );
      widget.inputLoginController.clear();
      widget.inputPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
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
              height: 30.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ErrorContainer(
                    errorText: context.read<AuthenticationCubit>().error,
                  ),
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
                          context
                              .read<AuthenticationCubit>()
                              .pageData
                              .mainButtonText,
                          style: commonTextStyleLight,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(context
                          .read<AuthenticationCubit>()
                          .pageData
                          .serviceButtonText[0]),
                      TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(0)),
                            splashFactory: NoSplash.splashFactory),
                        onPressed: () =>
                            context.read<AuthenticationCubit>().changePage(),
                        child: Text(
                          context
                              .read<AuthenticationCubit>()
                              .pageData
                              .serviceButtonText[1],
                        ),
                      )
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

class ErrorContainer extends StatelessWidget {
  final String? errorText;
  const ErrorContainer({
    super.key,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    if (context.read<AuthenticationCubit>().error == null) {
      return const SizedBox(
        height: 30.0,
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            width: 1,
            color: lightGrey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.warning,
              color: lightGrey,
            ),
            FittedBox(
              child: Text(errorText!,
                  style: commonTextStyleDark, maxLines: 2, softWrap: false),
            ),
          ],
        ),
      );
    }
  }
}
