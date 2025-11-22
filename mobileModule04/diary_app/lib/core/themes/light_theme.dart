import 'package:flutter/material.dart';

class LightTheme {
  // New color scheme based on orange and blue (Vivadoo style)
  static const Color primaryColor =
      Color.fromARGB(255, 11, 111, 66); // Orange for primary actions
  static const Color primaryColorDark =
      Color(0xFFE55A00); // Darker orange for emphasis
  static const Color primaryColorLight =
      Color(0xFFFF8533); // Lighter orange for highlights
  static const Color accentColor = Color.fromARGB(255, 94, 110, 123); // Blue for contrast
  static const Color scaffoldBackgroundColor =
      Color(0xFFF8F9FA); // Clean white background
  static const Color backgroundColor =
      Color.fromARGB(255, 226, 229, 232);
  static const Color errorColor =
      Color(0xFFD32F2F); // Strong red for error messages
  static const Color textColor =
      Color(0xFF333333); // Dark gray for better readability
  static const Color disabledColor =
      Color(0xFFA1A1A1); // Muted silver-gray for disabled elements
  // black color
  static const blackColors = Colors.black;
  // Additional colors for creative accents
  static const Color subtleAccent =
      Color(0xFFFFE8D6); // Light orange shade for subtle dividers/cards
  static const Color accentVariant =
      Color(0xFF1976D2); // Darker blue variant for depth

  // Enhanced text themes with subtle adjustments
  static TextTheme textTheme = const TextTheme(
    titleLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      color: textColor,
      letterSpacing: -0.5,
      height: 1.2,
    ),
    titleMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: textColor,
      letterSpacing: -0.3,
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: textColor,
      letterSpacing: -0.2,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: textColor,
      height: 1.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: textColor,
      height: 1.5,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      color: textColor,
      height: 1.4,
      letterSpacing: 0.2,
    ),
    displayLarge: TextStyle(
      fontSize: 32,
      color: textColor,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      color: textColor,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      color: textColor,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      color: textColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      color: textColor,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      color: textColor,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  );

  // Enhanced button theme with orange primary
  static final ButtonThemeData buttonTheme = ButtonThemeData(
    buttonColor: primaryColor,
    disabledColor: disabledColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    textTheme: ButtonTextTheme.primary,
  );

  // AppBar Theme with orange branding
  static final AppBarTheme appBarTheme = AppBarTheme(
    color: scaffoldBackgroundColor,
    elevation: 0,
    scrolledUnderElevation: 0.5,
    centerTitle: false,
    iconTheme: const IconThemeData(
      color: primaryColor,
      size: 24,
    ),
    actionsIconTheme: const IconThemeData(
      color: primaryColor,
      size: 24,
    ),
    titleTextStyle: const TextStyle(
      color: primaryColor,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
    ),
    titleSpacing: 16,
    shadowColor: primaryColor.withValues(alpha: 0.1),
  );

  // Enhanced input decoration theme
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
          color: primaryColorLight.withValues(alpha: 0.3), width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
          color: primaryColorLight.withValues(alpha: 0.3), width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: primaryColor, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: errorColor, width: 1.5),
    ),
    hintStyle: const TextStyle(
      color: disabledColor,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
    ),
    iconColor: primaryColor,
    prefixIconColor: primaryColor,
    suffixIconColor: accentVariant,
    floatingLabelStyle: TextStyle(
      color: primaryColor.withValues(alpha: 0.9),
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
  );

  // Card Theme for clean look
  static final CardTheme cardTheme = CardTheme(
    color: Colors.white,
    elevation: 1.5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    shadowColor: primaryColorDark.withValues(alpha: 0.08),
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    clipBehavior: Clip.antiAlias,
  );

  // ListTile Theme with orange accents
  static final ListTileThemeData listTileTheme = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    minLeadingWidth: 0,
    minVerticalPadding: 16,
    iconColor: primaryColor,
    textColor: textColor,
    tileColor: Colors.transparent,
    selectedTileColor: primaryColor.withValues(alpha: 0.05),
    horizontalTitleGap: 16,
    dense: false,
  );

  // Divider Theme
  static const DividerThemeData dividerTheme = DividerThemeData(
    color: subtleAccent,
    thickness: 1.5,
    indent: 16,
    endIndent: 16,
    space: 32,
  );

  // Switch Theme with orange/blue colors
  static final SwitchThemeData switchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) {
        return disabledColor;
      }
      if (states.contains(WidgetState.selected)) {
        return primaryColor;
      }
      return Colors.white;
    }),
    trackColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) {
        return disabledColor.withValues(alpha: 0.3);
      }
      if (states.contains(WidgetState.selected)) {
        return primaryColor.withValues(alpha: 0.3);
      }
      return accentVariant.withValues(alpha: 0.3);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {
      return Colors.transparent;
    }),
    thumbIcon: WidgetStateProperty.resolveWith<Icon?>((states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check, size: 12, color: Colors.white);
      }
      return null;
    }),
  );

  // Checkbox theme with orange selection
  static final CheckboxThemeData checkboxTheme = CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.disabled)) {
        return disabledColor;
      }
      if (states.contains(WidgetState.selected)) {
        return primaryColor;
      }
      return Colors.transparent;
    }),
    checkColor: WidgetStateProperty.all(Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    side: BorderSide(
      color: accentVariant,
      width: 1.5,
    ),
  );

  // Sliders with orange theme
  static final SliderThemeData sliderTheme = SliderThemeData(
    activeTrackColor: primaryColor,
    inactiveTrackColor: primaryColor.withValues(alpha: 0.2),
    thumbColor: primaryColor,
    overlayColor: primaryColor.withValues(alpha: 0.2),
    trackHeight: 4,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: 10,
      elevation: 2,
    ),
    overlayShape: const RoundSliderOverlayShape(
      overlayRadius: 18,
    ),
  );

  // Floating Action Button Theme with orange
  static final FloatingActionButtonThemeData fabTheme =
      FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  // Define full ThemeData with orange and blue color scheme
  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      fontFamily: "Blont", // Keep your existing font
      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: textTheme,
      buttonTheme: buttonTheme,
      appBarTheme: appBarTheme,
      inputDecorationTheme: inputDecorationTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Added themes
      cardTheme: cardTheme,
      listTileTheme: listTileTheme,
      dividerTheme: dividerTheme,
      switchTheme: switchTheme,
      checkboxTheme: checkboxTheme,
      sliderTheme: sliderTheme,
      floatingActionButtonTheme: fabTheme,

      // Animation durations for subtle motion
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      // Consistent icon theme with orange
      iconTheme: const IconThemeData(
        color: primaryColor,
        size: 24,
      ),

      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: MaterialColor(primaryColor.value, const {
          50: Color(0xFFFFF3E0), // Very light orange
          100: Color(0xFFFFE0B2), // Light orange
          200: Color(0xFFFFCC80), // Medium-light orange
          300: Color(0xFFFFB74D), // Medium orange
          400: Color(0xFFFFA726), // Medium-dark orange
          500: primaryColor, // Base orange (#FF6600)
          600: Color(0xFFE55A00), // Darker orange
          700: Color(0xFFCC5200), // Very dark orange
          800: Color(0xFFB34700), // Extremely dark orange
          900: Color(0xFF993D00), // Ultra dark orange
        }),
      ).copyWith(
        secondary: accentColor, // Blue
        tertiary: accentVariant, // Darker blue
        surface: Colors.white,
        surfaceContainerHighest: subtleAccent,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    );
  }
}