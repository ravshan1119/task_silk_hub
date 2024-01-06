import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:task_silk_hub/src/data/datasources/local/model/fact_model.dart';
import 'package:task_silk_hub/src/data/datasources/local/model/local_database.dart';

import '../config/router/app_routes.dart';
import '../utils/constant.dart';
import '../utils/loading_dialog.dart';
import 'cubit/cat_fact/cat_fact_cubit.dart';
import 'cubit/cat_fact/cat_fact_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<CatFactCubit>().getCatFact();
    super.initState();
  }

  Future<void> _saveImage(
      BuildContext context, String url, String name, DateTime date) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      // Download image
      showLoading(context: context);
      final http.Response response = await http.get(Uri.parse(url));
      if (context.mounted) {
        hideLoading(context: context);
      }

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      Random random = Random();
      int randomNumber = random.nextInt(999999);

      // Create an image name
      var filename = '${dir.path}/image$randomNumber.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);
      print("file image: ${file.path}");

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);
      print("finalPath: $finalPath");

      LocalDatabase.insertFact(FactModelSql(
          date: date.toString(), name: name, imagePath: file.path));

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Cat Fact"),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        actions: [],
      ),
      body: BlocConsumer<CatFactCubit, CatFactState>(
        listener: (context, state) {
          if (state.status == AppStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
            ));
            print("state error: ${state.error}");
          }
        },
        builder: (context, state) {
          if (state.status == AppStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width - 50,
                child: CachedNetworkImage(
                  imageUrl: "https://cataas.com/cat",
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Name: ${state.catFactModel.text}"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                    "Date: ${DateFormat.yMMMd().format(state.catFactModel.updatedAt)}"),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      context.read<CatFactCubit>().getCatFact();
                    });
                  },
                  child: const Icon(Icons.refresh),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  // Call the method we just created
                  onPressed: () => _saveImage(context, "https://cataas.com/cat",
                      state.catFactModel.text, state.catFactModel.updatedAt),
                  child: const Icon(Icons.save),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.history);
        },
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Icon(Icons.history),
        ),
      ),
    );
  }
}
