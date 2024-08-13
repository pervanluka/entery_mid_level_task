import 'package:entery_mid_level_task/shared/app_colors.dart';
import 'package:entery_mid_level_task/shared/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _lightFillColor = Colors.black;

  static const Color _lightFocusColor = Colors.black12;
  static const Color _darkFocusColor = Colors.white12;

  static ThemeData lightThemeData = _themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = _themeData(darkColorScheme, _darkFocusColor);

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
          fontWeight: _bold,
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
              fontWeight: AppTheme._regular,
            ),
          )),
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
              fontWeight: _bold,
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
    secondary: AppColors.primaryColor,
    surface: const Color(0xFFFAFBFB),
    error: AppColors.red,
    onPrimary: _lightFillColor,
    onSecondary: const Color(0xFF322942),
    onSurface: const Color.fromARGB(38, 36, 30, 48),
    onError: _lightFillColor,
    brightness: Brightness.light,
    shadow: AppColors.primaryColor.withOpacity(0.1),
  );

  static ColorScheme darkColorScheme = ColorScheme(
    primary: DarkAppColors.primary300,
    secondary: DarkAppColors.primary300,
    surface: DarkAppColors.offWhite,
    error: DarkAppColors.red,
    onPrimary: DarkAppColors.black,
    onSecondary: DarkAppColors.primaryText1,
    onSurface: DarkAppColors.primaryText1,
    onError: DarkAppColors.white,
    brightness: Brightness.dark,
    shadow: DarkAppColors.primary300.withOpacity(0.1),
  );

  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: GoogleFonts.gloriaHallelujah(
        fontSize: Sizes.TEXT_SIZE_96,
        color: colorScheme.onSurface,
        fontWeight: _bold,
        fontStyle: FontStyle.normal,
      ),
      displayMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_60,
        color: colorScheme.onSurface,
        fontWeight: _bold,
        fontStyle: FontStyle.normal,
      ),
      displaySmall: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_48,
        color: colorScheme.onSurface,
        fontWeight: _bold,
        fontStyle: FontStyle.normal,
      ),
      headlineLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_34,
        color: colorScheme.onSurface,
        fontWeight: _bold,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_24,
        color: colorScheme.onSurface,
        fontWeight: _bold,
        fontStyle: FontStyle.normal,
      ),
      headlineSmall: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_20,
        color: colorScheme.onSurface,
        fontWeight: _bold,
        fontStyle: FontStyle.normal,
      ),
      titleLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_18,
        color: colorScheme.onSurface,
        fontWeight: _bold,
        fontStyle: FontStyle.normal,
      ),
      titleMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_14,
        color: colorScheme.onSurface,
        fontWeight: _bold,
        fontStyle: FontStyle.normal,
      ),
      bodyLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_16,
        color: colorScheme.onSurface,
        fontWeight: _regular,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_14,
        color: colorScheme.onSurface,
        fontWeight: _light,
        fontStyle: FontStyle.normal,
      ),
      labelLarge: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_16,
        color: colorScheme.onSurface,
        fontStyle: FontStyle.normal,
        fontWeight: _regular,
      ),
      labelMedium: GoogleFonts.lato(
        fontSize: Sizes.TEXT_SIZE_12,
        color: colorScheme.onSurface,
        fontWeight: _regular,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  static const _bold = FontWeight.w700;
  static const _regular = FontWeight.w400;
  static const _light = FontWeight.w300;
}
