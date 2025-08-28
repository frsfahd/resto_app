import 'package:flutter/material.dart';
import 'package:resto_app/style/colors.dart';
import 'package:resto_app/style/typography.dart';

class RestoTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: RestoTextStyles.displayLarge,
      displayMedium: RestoTextStyles.displayMedium,
      displaySmall: RestoTextStyles.displaySmall,
      headlineLarge: RestoTextStyles.headlineLarge,
      headlineMedium: RestoTextStyles.headlineMedium,
      headlineSmall: RestoTextStyles.headlineSmall,
      titleLarge: RestoTextStyles.titleLarge,
      titleMedium: RestoTextStyles.titleMedium,
      titleSmall: RestoTextStyles.titleSmall,
      bodyLarge: RestoTextStyles.bodyLargeBold,
      bodyMedium: RestoTextStyles.bodyLargeMedium,
      bodySmall: RestoTextStyles.bodyLargeRegular,
      labelLarge: RestoTextStyles.labelLarge,
      labelMedium: RestoTextStyles.labelMedium,
      labelSmall: RestoTextStyles.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      // actionsPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: RestoColors.green.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: RestoColors.green.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }
}
