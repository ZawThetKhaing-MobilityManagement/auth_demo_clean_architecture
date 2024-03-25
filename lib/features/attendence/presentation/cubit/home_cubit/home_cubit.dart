import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewCubit extends Cubit<int> {
  HomeViewCubit() : super(0);

  int homeViewIndex = 0;

  void switchView(int index) => emit(index);
}
