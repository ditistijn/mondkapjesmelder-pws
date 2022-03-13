import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mondkapjesmelder/logic/admin/greeting.dart';
import 'package:responsive_table/responsive_table.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  late List<DatatableHeader> _headers;

  List<int> _perPages = [10, 20, 50, 100];
  int _total = 100;
  int? _currentPerPage = 10;
  List<bool>? _expanded;
  String? _searchKey = "id";

  List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];
  // ignore: unused_field
  String _selectableKey = "id";

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  bool _showSelect = true;
  var random = new Random();

  List<Map<String, dynamic>> _generateData({int n: 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = [];
    var i = 1;
    print(i);
    // ignore: unused_local_variable
    for (var data in source) {
      temps.add({
        "studentId": i,
        "name": "Product $i",
        "reporter": "gemeld door $i",
        "class": "h$i\tf",
      });
      i++;
    }
    return temps;
  }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage!, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      _sourceOriginal.clear();
      _sourceOriginal.addAll(_generateData(n: random.nextInt(10000)));
      _sourceFiltered = _sourceOriginal;
      _total = _sourceFiltered.length;
      _source = _sourceFiltered.getRange(0, _currentPerPage!).toList();
      setState(() => _isLoading = false);
    });
  }

  void initState() {
    // TODO: implement initState
    _headers = [
      DatatableHeader(
          text: "Student ID",
          value: "studentId",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Naam",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          //editable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Reported by",
          value: "reporter",
          show: true,
          sortable: true,
          textAlign: TextAlign.center),
      DatatableHeader(
          text: "Aantal keer gemeld",
          value: "reported",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
    ];

    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Text(
              '${greetingMessage()}, \$user',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Card(
              child: Column(
                children: [
                  ResponsiveDatatable(
                    title: Text('Meest recente meldingen'),
                    headers: _headers,
                    source: _source,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
