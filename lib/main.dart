import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_silk_hub/src/config/router/app_routes.dart';
import 'package:task_silk_hub/src/data/datasources/local/model/local_database.dart';
import 'package:task_silk_hub/src/data/datasources/remote/api_service.dart';
import 'package:task_silk_hub/src/data/datasources/remote/app_repository.dart';
import 'package:task_silk_hub/src/presentation/cubit/cat_fact/cat_fact_cubit.dart';
import 'package:task_silk_hub/src/presentation/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppRepository repository = AppRepository(apiService: ApiService(Dio()));

    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => CatFactCubit(repository: repository)),
    ], child: const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      home: HomePage(),
    );
  }
}
