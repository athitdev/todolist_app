import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/src/constants/constants.dart';
import 'package:todolist_app/src/features/home/models/todolist_model.dart';
import 'package:todolist_app/src/features/home/providers/home_provider.dart';
import 'package:todolist_app/src/features/home/services/home_service.dart';

void main() {
  group('HomePage Services', () {
    test('check getTasks return list', () async {
      final TodolistModel data =
          await HomeServices.getTasks(status: 'TODO', offset: 0, limit: 10);
      expect(data, []);
    });
  });

  group('HomePage Tab', () {
    test('check getTasks return list', () async {
      // Provider<HomeProvider>.selectTab(HomeTab.doing);

      //expect(data, []);
    });
  });
}
