import 'dart:convert';

import '../data/data.dart';
import 'package:http/http.dart' as http;

String baseUrl = "https://676c5ee60e299dd2ddfcaca9.mockapi.io/data";

class HttpService {
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
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  static Future<Person> createPerson(Person person) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(person.toJson()),
    );
    try {
      if (response.statusCode == 201) {
        return Person.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Person> updatePerson(String id, Person person) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(person.toJson()),
    );
    try {
      if (response.statusCode == 200) {
        return Person.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
