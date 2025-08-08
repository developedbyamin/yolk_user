import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yolla/core/config/constants/app_colors.dart';

class BottomAppBarItem extends StatelessWidget {
  final String vectorPath;
  final int selectedIndex;
  final int currentIndex;
  final String labelText;
  final VoidCallback onTap;
  const BottomAppBarItem({
    super.key,
    required this.vectorPath,
    required this.selectedIndex,
    required this.currentIndex,
    required this.onTap,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        onTap: onTap,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                vectorPath,
                colorFilter: ColorFilter.mode(
                  selectedIndex == currentIndex ? AppColors.primaryColor : AppColors.grayColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                labelText,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: selectedIndex == currentIndex ? AppColors.primaryColor : AppColors.grayColor,
                  fontWeight: selectedIndex == currentIndex ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
