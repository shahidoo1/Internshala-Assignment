import 'dart:convert';
import 'package:flutter_intershala_application/models/intership.dart';
import 'package:http/http.dart' as http;

Future<List<Internship>> fetchInternships() async {
  final response = await http
      .get(Uri.parse('https://internshala.com/flutter_hiring/search'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data); // Inspect the JSON structure
    final internshipsJson = data['internships_meta'] as Map<String, dynamic>;
    return internshipsJson.values
        .map((json) => Internship.fromJson(json))
        .toList();
  } else {
    throw Exception('Failed to load internships');
  }
}
