import 'package:flutter/material.dart';
import 'package:my_app/core/configs/theme/app_colors.dart';

class IswButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isInverted;
  final bool isValid;
  final Color? borderColor;

  const IswButton({
    required this.label,
    required this.onPressed,
    this.isInverted = false,
    this.isValid = false,
    this.borderColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: !isInverted ? AppColors.primary : Colors.white,
        side:
            borderColor == null
                ? (!isValid
                    ? BorderSide.none
                    : BorderSide(color: AppColors.iswBlue, width: 1))
                : BorderSide(color: borderColor ?? AppColors.iswBlue, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        minimumSize: Size(double.infinity, 50),
        disabledBackgroundColor: AppColors.iswLightBlue,
      ),
      child: Text(
        label,
        style: TextStyle(color: !isInverted ? Colors.white : AppColors.primary),
      ),
    );
  }
}
