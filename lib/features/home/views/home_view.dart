import 'package:flutter/material.dart';
import 'package:todoapp/features/home/views/completed_view.dart';
import 'package:todoapp/features/home/views/pending_view.dart';
import 'package:todoapp/features/home/views/widgets/show_task_dialog.dart';
import 'package:todoapp/features/home/views/widgets/signout_button.dart';
import 'package:todoapp/features/home/views/widgets/tab_switcher.dart';
import 'package:todoapp/features/home/views/widgets/task_tabs_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _buttonIndex = 0;
  final List<String> _buttonLabels = ['Pending', 'Completed'];
  final List<Widget> _views = [const PendingView(), const CompletedView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1d2630),
      appBar: AppBar(
        backgroundColor: const Color(0xff1d2630),
        foregroundColor: Colors.white,
        title: const Text('Todo App'),
        actions: const [SignOutButton()],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          TabSwitcher(
            selectedIndex: _buttonIndex,
            labels: _buttonLabels,
            onTabSelected: (index) {
              setState(() {
                _buttonIndex = index;
              });
            },
          ),
          const SizedBox(height: 20),
          TaskTabsView(selectedIndex: _buttonIndex, views: _views),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showDialog(
              context: context,
              builder: (context) => const ShowTaskDialog(),
            ),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
