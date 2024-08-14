import 'package:entery_mid_level_task/shared/app_colors.dart';
import 'package:entery_mid_level_task/shared/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightThemeData = _themeData(lightColorScheme, AppColors.grey70);
  static ThemeData darkThemeData = _themeData(darkColorScheme, DarkAppColors.grey70);

  static ThemeData _themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme(colorScheme),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      hintColor: colorScheme.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      focusColor: focusColor,
      shadowColor: colorScheme.shadow,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        titleTextStyle: GoogleFonts.lato(
          fontSize: Sizes.TEXT_SIZE_20,
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onPrimary,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.primary,
        indicatorColor: colorScheme.onPrimary.withOpacity(0.15),
        labelTextStyle: WidgetStateTextStyle.resolveWith(
          (states) => TextStyle(
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onPrimary,
        unselectedItemColor: colorScheme.onSurface,
        elevation: 8,
        selectedLabelStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
        selectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.pressed)) {
                return colorScheme.primary.withOpacity(0.8);
              } else if (states.contains(WidgetState.disabled)) {
                return colorScheme.onSurface.withOpacity(0.12);
              }
              return colorScheme.primary;
            },
          ),
          foregroundColor: WidgetStateProperty.all<Color>(colorScheme.onPrimary),
          textStyle: WidgetStateProperty.all<TextStyle>(
            GoogleFonts.lato(
              fontSize: Sizes.TEXT_SIZE_16,
              fontWeight: FontWeight.bold,
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: Sizes.PADDING_16, vertical: Sizes.PADDING_8),
          ),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.RADIUS_8),
            ),
          ),
          elevation: WidgetStateProperty.all<double>(4),
        ),
      ),
    );
  }

  static ColorScheme lightColorScheme = ColorScheme(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    surface: AppColors.accentColor,
    error: AppColors.red,
    onPrimary: AppColors.black,
    onSecondary: const Color.fromARGB(255, 60, 60, 60),
    onSurface: const Color.fromARGB(255, 60, 60, 60),
    onError: AppColors.black,
    brightness: Brightness.light,
    shadow: AppColors.primaryColor.withOpacity(0.1),
  );

  static ColorScheme darkColorScheme = ColorScheme(
    primary: DarkAppColors.primary300,
    secondary: DarkAppColors.secondaryColor,
    surface: DarkAppColors.accentColor,
    error: DarkAppColors.red,
    onPrimary: DarkAppColors.black,
    onSecondary: DarkAppColors.primaryText1,
    onSurface: DarkAppColors.primaryText2,
    onError: DarkAppColors.white,
    brightness: Brightness.dark,
    shadow: DarkAppColors.primary300.withOpacity(0.1),
  );

  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: GoogleFonts.gloriaHallelujah(
        fontSize: Sizes.TEXT_SIZE_96,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_60,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_48,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_34,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_24,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_20,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_18,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_14,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_16,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_14,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w300,
      ),
      labelLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_16,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_12,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
