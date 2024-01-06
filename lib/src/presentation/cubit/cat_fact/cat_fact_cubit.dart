import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/datasources/remote/app_repository.dart';
import '../../../domain/model/cat_fact_model.dart';
import '../../../utils/constant.dart';
import 'cat_fact_state.dart';

class CatFactCubit extends Cubit<CatFactState> {
  final AppRepository repository;

  CatFactCubit({required this.repository}) : super(CatFactState.initial());

  Future<void> getCatFact() async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final CatFactModel catFactModel = await repository.getCatFact();
      print("banners ${catFactModel.text}");
      emit(state.copyWith(
        status: AppStatus.loaded,
        catFactModel: catFactModel,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AppStatus.error,
        error: e.toString(),
      ));
    }
    emit(state.copyWith(status: AppStatus.initial));
  }
}
