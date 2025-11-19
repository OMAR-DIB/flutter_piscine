import 'package:flutter/material.dart';
import 'package:weather_app/core/themes/light_theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double? width;
  final Widget? leading;
  final Widget? trailing;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = LightTheme.primaryColor,
    this.textColor = LightTheme.scaffoldBackgroundColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.elevation = 2.0,
    this.leading,
    this.width,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // new property name - primary replaced
          foregroundColor: textColor,
          padding: padding,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 8),
            ],
            Text(label, style: TextStyle(color: textColor)),
            if (trailing != null) ...[
              const SizedBox(width: 8),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
