import 'package:dio/dio.dart';

import '../../../domain/model/cat_fact_model.dart';
import 'api_service.dart';

class AppRepository {
  AppRepository({required this.apiService});

  final ApiService apiService;

  Future<CatFactModel> getCatFact() async {
    final client = ApiService(
      Dio(
        BaseOptions(contentType: "application/json"),
      ),
    );

    try {
      print("apprepository");
      final response = await apiService.getCatFact();
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
