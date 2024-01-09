import 'package:flutter/material.dart';
import 'package:flutter_adviser/2_application/core/services/theme_service.dart';
import 'package:flutter_adviser/2_application/pages/advice/widgets/advice_field.dart';
import 'package:flutter_adviser/2_application/pages/advice/widgets/custom_button.dart';
import 'package:flutter_adviser/2_application/pages/advice/widgets/error_message.dart';
import 'package:provider/provider.dart';

class AdvicePage extends StatelessWidget {
  const AdvicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adviser',
          style: themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) =>
                Provider.of<ThemeService>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: ErrorMessage(message: 'ups, something went wrong!'),
                // AdviceField(advice: 'example advice - your day will be good!'),
                /*CircularProgressIndicator(
                  color: themeData.colorScheme.secondary,
                ),*/
                /*Text(
                  'Your advice is waiting for you!',
                  style: themeData.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ),*/
              ),
            ),
            SizedBox(
              height: 200.0,
              child: Center(
                child: CustomButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
