import 'dart:convert';

import '../data/data.dart';
import 'package:http/http.dart' as http;

class HttpService {
   String baseUrl = "https://676c5ee60e299dd2ddfcaca9.mockapi.io/data";

  Future<List<Person>> getData() async {
    final response = await http.get(Uri.parse(baseUrl));
    try {
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Person.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteData(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    if(response.statusCode != 200) {
        throw Exception('Failed to delete data');
    }
  }
}
