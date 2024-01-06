import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../domain/model/cat_fact_model.dart';

part 'api_service.g.dart';

class Apis {
  static const String baseUrl = "https://cat-fact.herokuapp.com";
  static const String facts = "/facts/random";
}

@RestApi(baseUrl: Apis.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET(Apis.facts)
  Future<CatFactModel> getCatFact();
}
