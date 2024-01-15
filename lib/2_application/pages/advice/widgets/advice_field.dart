import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  const AdviceField({super.key, required this.advice});

  final String advice;
  static String emptyAdvice = 'What should I do with an empty advice?';

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Material(
      elevation: 20.0,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: themeData.colorScheme.onPrimary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Text(
            advice.isNotEmpty ? '''" $advice "''' : emptyAdvice,
            style: themeData.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
