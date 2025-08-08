import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yolla/core/config/constants/app_colors.dart';
import 'package:yolla/core/config/constants/app_vectors.dart';
import 'package:yolla/core/extensions/localization_extension.dart';
import 'package:yolla/core/router/routes.dart';
import 'bottom_app_bar_item.dart';

class YollaBottomAppBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const YollaBottomAppBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  State<YollaBottomAppBar> createState() => _YollaBottomAppBarState();
}

class _YollaBottomAppBarState extends State<YollaBottomAppBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {'vectorPath': AppVectors.qrIcon, 'labelText': context.localizations.qr, 'route': Routes.qrView},
      {'vectorPath': AppVectors.saleIcon, 'labelText': context.localizations.sale, 'route': Routes.saleView},
      {'vectorPath': AppVectors.historyIcon, 'labelText': context.localizations.history, 'route': Routes.historyView},
      {'vectorPath': AppVectors.settingsIcon, 'labelText': context.localizations.profile, 'route': Routes.profileView},
    ];

    return BottomAppBar(
      padding: const EdgeInsets.symmetric(vertical: 4),
      shadowColor: Colors.black,
      elevation: 30,
      height: 60,
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          items.length,
          (index) => BottomAppBarItem(
            vectorPath: items[index]['vectorPath'] as String,
            selectedIndex: _selectedIndex,
            currentIndex: index,
            onTap: () {
              _onItemTapped(index);
              context.go(items[index]['route'] as String);
            },
            labelText: items[index]['labelText'] as String,
          ),
        ),
      ),
    );
  }
}
