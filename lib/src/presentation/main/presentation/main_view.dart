import 'package:flutter/material.dart';
import 'package:yolla/src/presentation/main/presentation/widgets/yolla_bottom_app_bar.dart';

class MainView extends StatefulWidget {
  final Widget child;
  const MainView({super.key, required this.child});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(children: [widget.child]),
      bottomNavigationBar: YollaBottomAppBar(selectedIndex: selectedIndex, onTap: _onItemTapped),
    );
  }
}
