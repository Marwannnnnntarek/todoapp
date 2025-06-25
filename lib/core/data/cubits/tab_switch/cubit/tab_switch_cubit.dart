import 'package:flutter_bloc/flutter_bloc.dart';

class TabSwitchCubit extends Cubit<int> {
  TabSwitchCubit() : super(0);

  void switchTab(int index) => emit(index);
}
