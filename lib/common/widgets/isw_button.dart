import 'package:flutter/material.dart';
import 'package:my_app/core/configs/theme/app_colors.dart';

class IswButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isInverted;

  const IswButton({
    required this.label,
    required this.onPressed,
    this.isInverted = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: !isInverted ? AppColors.primary : Colors.white,
        side: BorderSide(color: AppColors.iswBlue, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      child: Text(
        label,
        style: TextStyle(color: !isInverted ? Colors.white : AppColors.primary),
      ),
    );
  }
}
