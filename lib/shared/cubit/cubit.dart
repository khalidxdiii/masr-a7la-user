import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masr_a7la/shared/cubit/states.dart';

import '../../modules/camera/camera.dart';
import '../../modules/report state/report_state.dart';
import '../../modules/report state/user_reports_state_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = const [
    CameraScreen(),
    ReportStateScreen(),
  ];

  List<String> titles = [
    'الصفحه الرئيسيه',
    'حاله التقرير',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }
}
