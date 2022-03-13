import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class BackendService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {'name': query + index.toString(), 'klas': Random().nextInt(100)};
    });
  }
}

class SearchService {
  final _firestore = FirebaseFirestore.instance;

  Future<List> getStudents(String suggestion) async {
    var doc = await _firestore.collection('students').get();

    final allStudents = doc.docs.map((doc) => doc.data()).toList();
    return allStudents;
  }
}

class CitiesService {
  static final List<String> cities = [
    'Henk de steen',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List.empty();
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
