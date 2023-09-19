import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todolist_model.dart';
import '../services/home_service.dart';
import '../../../constants/constants.dart';

class HomeProvider with ChangeNotifier {
  HomeTab currentTab = HomeTab.todo;
  String paramTaskStatus = 'TODO';
  int currentOffset = 0;
  int maxPage = 0;
  List<Tasks> _tasks = [];
  List<Tasks> get tasks => _tasks;

  HomeServices homeServices = HomeServices();

  bool loading = false;

  Future<List<Tasks>> getTasks(
      {required String status, required bool isFirstLoad}) async {
    loading = true;
    if (isFirstLoad) {
      _tasks = [];
      maxPage = 0;
      currentOffset = 0;
    }

    if (currentOffset < maxPage || isFirstLoad) {
      final TodolistModel data = await HomeServices.getTasks(
          status: paramTaskStatus, offset: currentOffset, limit: 10);
      maxPage = data.totalPages!;
      currentOffset++;

      for (Tasks task in data.tasks!) {
        final DateTime createDate = DateTime.parse(task.createdAt.toString());
        final localTime = createDate.toLocal();

        String dateGroup =
            '${localTime.day} ${DateFormat.MMMM().format(localTime)} ${localTime.year}';
        task.createdAtForGroup = dateGroup;
      }
      if (isFirstLoad) {
        _tasks = data.tasks!;
      } else {
        _tasks.addAll(data.tasks!);
      }

      loading = false;
    }

    notifyListeners();
    return _tasks;
  }

  void selectTab(HomeTab selectTab) {
    currentTab = selectTab;
    String taskStatus = '';
    switch (selectTab) {
      case HomeTab.todo:
        taskStatus = 'TODO';
        break;
      case HomeTab.doing:
        taskStatus = 'DOING';
        break;
      case HomeTab.done:
        taskStatus = 'DONE';
        break;
      default:
        taskStatus = 'TODO';
    }
    paramTaskStatus = taskStatus;
    notifyListeners();
  }

  void deleteTask(Tasks task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
