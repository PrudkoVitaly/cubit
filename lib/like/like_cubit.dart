import 'package:bloc/bloc.dart';

class LikeCubit extends Cubit<bool> {
  LikeCubit(): super(false);

  void like() => emit(!state);
}