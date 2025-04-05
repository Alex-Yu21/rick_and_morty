import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkTheme = false;

  ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightSurface,
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      error: AppColors.lightError,
      tertiary: AppColors.lightTertiary,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(foregroundColor: AppColors.lightPrimary),
    ),
    useMaterial3: true,
  );

  void changeTheme() {
    isDarkTheme = !isDarkTheme;

    theme =
        isDarkTheme
            ? ThemeData(
              scaffoldBackgroundColor: AppColors.darkSurface,
              colorScheme: const ColorScheme.dark(
                primary: AppColors.darkPrimary,
                secondary: AppColors.darkSecondary,
                surface: AppColors.darkSurface,
                onSurface: AppColors.darkOnSurface,
                error: AppColors.darkError,
                tertiary: AppColors.darkTertiary,
              ),
              iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.darkPrimary,
                ),
              ),
              useMaterial3: true,
            )
            : ThemeData(
              scaffoldBackgroundColor: AppColors.lightSurface,
              colorScheme: const ColorScheme.light(
                primary: AppColors.lightPrimary,
                secondary: AppColors.lightSecondary,
                surface: AppColors.lightSurface,
                onSurface: AppColors.lightOnSurface,
                error: AppColors.lightError,
                tertiary: AppColors.lightTertiary,
              ),
              iconButtonTheme: IconButtonThemeData(
                style: IconButton.styleFrom(
                  foregroundColor: AppColors.lightPrimary,
                ),
              ),
              useMaterial3: true,
            );

    notifyListeners();
  }
}
