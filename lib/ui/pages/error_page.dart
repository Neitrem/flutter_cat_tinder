import 'package:cinder/ui/styles/styles.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Function fromFunction;
  final Map<Symbol, dynamic>? namedArguments;
  final String errorText;

  const ErrorPage({
    super.key,
    required this.fromFunction,
    required this.errorText,
    this.namedArguments,
  });

  void doJob() {
    Function.apply(fromFunction, [], namedArguments);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Error!!!",
            style: errorTitleTextStyle,
          ),
          Text(
            errorText,
            style: commonTextStyleDark,
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextButton(
            onPressed: doJob,
            child: const Column(
              children: <Widget>[
                Icon(
                  Icons.repeat,
                  size: 40,
                ),
                Text(
                  "Retry",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
