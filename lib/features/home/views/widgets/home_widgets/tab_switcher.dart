import 'package:flutter/material.dart';
import 'package:todoapp/features/home/views/widgets/home_widgets/tab_button.dart';

class TabSwitcher extends StatelessWidget {
  final int selectedIndex;
  final List<String> labels;
  final ValueChanged<int> onTabSelected;

  const TabSwitcher({
    super.key,
    required this.selectedIndex,
    required this.labels,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(labels.length, (index) {
        return TabButton(
          label: labels[index],
          isSelected: selectedIndex == index,
          onTap: () => onTabSelected(index),
        );
      }),
    );
  }
}
