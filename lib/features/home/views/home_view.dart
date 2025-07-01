import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/features/home/data/cubit/tab_switch_cubit.dart';
import 'package:todoapp/features/home/views/completed_view.dart';
import 'package:todoapp/features/home/views/pending_view.dart';
import 'package:todoapp/features/home/views/widgets/home_widgets/home_app_bar.dart';
import 'package:todoapp/features/home/views/widgets/home_widgets/tab_switcher.dart';
import 'package:todoapp/features/home/views/widgets/home_widgets/task_tabs_view.dart';
import 'package:todoapp/features/home/views/widgets/home_widgets/add_task_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final List<String> _labels = const ['Pending', 'Completed'];
  final List<Widget> _views = const [PendingView(), CompletedView()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabSwitchCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xff1d2630),
        appBar: const HomeAppBar(),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TabSwitchCubit, int>(
                builder: (context, tabIndex) {
                  return Column(
                    children: [
                      TabSwitcher(
                        selectedIndex: tabIndex,
                        labels: _labels,
                        onTabSelected:
                            (index) =>
                                context.read<TabSwitchCubit>().switchTab(index),
                      ),
                      const SizedBox(height: 20),
                      TaskTabsView(selectedIndex: tabIndex, views: _views),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: const AddTaskButton(),
      ),
    );
  }
}
