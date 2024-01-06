import 'package:equatable/equatable.dart';

import '../../../domain/model/cat_fact_model.dart';
import '../../../utils/constant.dart';
class CatFactState extends Equatable {
  final AppStatus status;
  final CatFactModel catFactModel;
  final String error;

  const CatFactState(
      {required this.status, required this.catFactModel, required this.error});

  factory CatFactState.initial() {
    return CatFactState(
        status: AppStatus.initial,
        catFactModel: CatFactModel(
            id: "",
            v: 0,
            text: "",
            updatedAt: DateTime.now(),
            deleted: false,
            source: "",
            sentCount: 0),
        error: "");
  }

  @override
  List<Object?> get props => [status, catFactModel, error];

  @override
  bool get stringify => true;

  CatFactState copyWith({
    AppStatus? status,
    CatFactModel? catFactModel,
    String? error,
  }) {
    return CatFactState(
      status: status ?? this.status,
      catFactModel: catFactModel ?? this.catFactModel,
      error: error ?? this.error,
    );
  }
}
