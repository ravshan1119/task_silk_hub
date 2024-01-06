import 'package:flutter/material.dart';
import 'package:task_silk_hub/src/data/datasources/local/model/local_database.dart';

import '../data/datasources/local/model/fact_model.dart';

class HistoryFact extends StatefulWidget {
  const HistoryFact({super.key});

  @override
  State<HistoryFact> createState() => _HistoryFactState();
}

class _HistoryFactState extends State<HistoryFact> {
  List<FactModelSql> list = [];

  fetchData() async {
    list = await LocalDatabase.getAllContacts();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          ...List.generate(
              list.length,
              (index) => ListTile(
                  title: Text(list[index].name),
                  leading: Image.asset(list[index].imagePath),
                  subtitle: Text(
                    list[index].date,
                  )))
        ],
      ),
    );
  }
}
