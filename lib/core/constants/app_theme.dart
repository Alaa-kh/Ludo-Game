import 'package:flutter_application_2/core/constants/app_packages.dart';

class AppTheme {
  static ThemeData myTheme = ThemeData(
    splashColor: null,
    primarySwatch: null,
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontSize: AppSize.size50, color: AppColors.whiteColor, height: 1.5),
    ),
  );
}
