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
    print(list.length);
  }

  @override
  void initState() {
    fetchData();
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
      body: ListView(
        children: [
          ...List.generate(
              list.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    border: Border(top: BorderSide(color: Colors.grey), bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: ListTile(
                      title: Text(list[index].name,style: const TextStyle(color: Colors.black),),
                      subtitle: Text(
                        list[index].date,
                        style: const TextStyle(color: Colors.black),
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
