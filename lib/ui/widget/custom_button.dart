import 'package:emi_solution/ui/common/custom_text.dart';
import 'package:emi_solution/ui/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final bool autoSize;
  final bool fullWidth;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.padding,
    this.borderRadius,
    this.width,
    this.height,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.autoSize = true,
    this.fullWidth = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColors = _getButtonColors(theme);

    final defaultPadding = EdgeInsets.symmetric(
      vertical: 16.h,
      horizontal: 24.w,
    );

    final effectivePadding = padding ?? defaultPadding;
    final effectiveBorderRadius = borderRadius ?? 8.r;

    double? buttonWidth;
    if (fullWidth) {
      buttonWidth = double.infinity;
    } else if (width != null) {
      buttonWidth = width!.w;
    } else if (!autoSize) {
      buttonWidth = _calculateAutoWidth(text);
    }

    return SizedBox(
      width: buttonWidth,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth?.w ?? (fullWidth ? double.infinity : 0),
          maxWidth:
              maxWidth?.w ?? (fullWidth ? double.infinity : double.infinity),
          minHeight: minHeight?.h ?? 48.h,
          maxHeight: maxHeight?.h ?? 56.h,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColors.backgroundColor,
            foregroundColor: buttonColors.foregroundColor,
            padding: effectivePadding,
            minimumSize: Size(
              minWidth?.w ?? 0,
              minHeight?.h ?? 48.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(effectiveBorderRadius),
              side: buttonColors.borderColor != null
                  ? BorderSide(color: buttonColors.borderColor!)
                  : BorderSide.none,
            ),
            elevation: 2,
            shadowColor: Colors.black.withOpacity(0.2),
          ),
          onPressed: isLoading ? null : _handlePressed,
          child: isLoading
              ? SizedBox(
                  width: 25.w,
                  height: 25.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: buttonColors.foregroundColor,
                  ),
                )
              : Text(
                  text,
                  style: AppFonts.semiBold(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ),
      ),
    );
  }

  double _calculateAutoWidth(String text) {
    final baseWidth = text.length * 12.0.w;
    return baseWidth.clamp(80.w, 300.w);
  }

  void _handlePressed() {
    try {
      if (onPressed != null) {
        onPressed!();
        _showSuccessFeedback();
      }
    } catch (e) {
      _showErrorFeedback(e.toString());
    }
  }

  void _showSuccessFeedback() {
    switch (type) {
      case ButtonType.primary:
        //CustomSnackBar.showSuccess('Action completed successfully!');
        break;
      case ButtonType.secondary:
        break;
      case ButtonType.danger:
        //CustomSnackBar.showSuccess('Operation completed!');
        break;
    }
  }

  void _showErrorFeedback(String error) {
    switch (type) {
      case ButtonType.primary:
      case ButtonType.danger:
        AppSnackBar.showError('Error: $error');
        break;
      case ButtonType.secondary:
        AppSnackBar.showWarning('Warning: $error');
        break;
    }
  }

  _ButtonColors _getButtonColors(ThemeData theme) {
    return _ButtonColors(
      backgroundColor: backgroundColor ?? _defaultBackgroundColor(theme),
      foregroundColor: foregroundColor ?? _defaultForegroundColor(theme),
      borderColor: borderColor ?? _defaultBorderColor(theme),
    );
  }

  Color _defaultBackgroundColor(ThemeData theme) {
    switch (type) {
      case ButtonType.primary:
        return theme.primaryColor;
      case ButtonType.secondary:
        return Colors.transparent;
      case ButtonType.danger:
        return Colors.red.shade600;
    }
  }

  Color _defaultForegroundColor(ThemeData theme) {
    switch (type) {
      case ButtonType.primary:
      case ButtonType.danger:
        return Colors.white;
      case ButtonType.secondary:
        return theme.primaryColor;
    }
  }

  Color? _defaultBorderColor(ThemeData theme) {
    if (type == ButtonType.secondary) {
      return theme.primaryColor;
    }
    return null;
  }
}

class _ButtonColors {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  _ButtonColors({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
  });
}

enum ButtonType {
  primary,
  secondary,
  danger,
}
