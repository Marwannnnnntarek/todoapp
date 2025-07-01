import 'package:flutter/material.dart';

class TaskTabsView extends StatelessWidget {
  final int selectedIndex;
  final List<Widget> views;

  const TaskTabsView({
    super.key,
    required this.selectedIndex,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: views[selectedIndex],
      ),
    );
  }
}
