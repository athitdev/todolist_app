import 'dart:convert';

import 'package:todolist_app/src/constants/constants.dart';
import '../models/todolist_model.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class HomeServices {
  Future<TodolistModel> getTasks(
      {required String status, required int offset, required int limit}) async {
    TodolistModel data = TodolistModel();
    try {
      final response = await http.get(
        Uri.parse(
            '${Constants.baseAPI}/todo-list?offset=$offset&limit=$limit&sortBy=createdAt&isAsc=true&status=$status'),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        data = TodolistModel.fromJson(item);
      } else {
        dev.log('getTasks api error');
      }
    } catch (e) {
      dev.log('getTasks : ${e.toString()}');
    }
    return data;
  }
}
