import 'package:flutter/material.dart';
import '../../../../themes/app_theme.dart';

class TodolistTabWidget extends StatelessWidget {
  final String tabName;
  final bool tabSelect;
  final void Function() onTap;
  const TodolistTabWidget({
    super.key,
    required this.tabName,
    required this.onTap,
    this.tabSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: tabSelect ? AppColors.appSecColor : AppColors.appTransparent,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Center(
            child: Text(
              tabName,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: tabSelect ? AppColors.appWhite : AppColors.appGray),
            ),
          ),
        ),
      ),
    );
  }
}
