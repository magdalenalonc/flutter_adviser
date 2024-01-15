import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkResponse(
      onTap: onTap?.call(),
      child: Material(
        elevation: 20.0,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: themeData.colorScheme.secondary,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Text(
              'Get Advice',
              style: themeData.textTheme.displayLarge,
            ),
          ),
        ),
      ),
    );
  }
}
