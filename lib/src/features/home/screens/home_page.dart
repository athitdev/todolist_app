import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/themes/app_theme.dart';

import '../models/todolist_model.dart';
import '../providers/home_provider.dart';
import '../services/home_service.dart';
import '../widgets/todolist_tab_widget.dart';
import '../../../constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  int _secondsRemaining = Constants.passcodeCountDown;
  late Timer _timer;
  bool isUnlocked = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          Future.delayed(Duration.zero, () {
            screenLock(
                onUnlocked: () {
                  setState(() {
                    _secondsRemaining = Constants.passcodeCountDown;
                  });
                  _startTimer();
                  HomeServices().navigatePop(context);
                },
                context: context,
                correctString: Constants.password,
                canCancel: false);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    Provider.of<HomeProvider>(context, listen: false)
        .getTasks(status: 'TODO', isFirstLoad: true);
  }

  @override
  Widget build(BuildContext context) {
    HomeTab currentTab = context.watch<HomeProvider>().currentTab;
    List<Tasks> tasks = context.watch<HomeProvider>().tasks;

    return Listener(
      onPointerDown: (_) {
        setState(() {
          _secondsRemaining = Constants.passcodeCountDown;
        });
      },
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 260,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: BoxDecoration(
                        color: AppColors.appMainColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0),
                        )),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: FractionalOffset.topRight,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.appLigthGray),
                              child: Center(
                                child: FaIcon(FontAwesomeIcons.userAstronaut,
                                    color: AppColors.appGray),
                              ),
                            ),
                          ),
                          Text(
                            'Hi! User     ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: AppColors.appDarkGray,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This is just a sample UI.',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: AppColors.appDarkGray,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Open to create your style :D',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: AppColors.appDarkGray,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      decoration: BoxDecoration(
                        color: AppColors.appLigthGray,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            TodolistTabWidget(
                              tabName: 'To-do',
                              tabSelect: currentTab == HomeTab.todo,
                              onTap: () {
                                context
                                    .read<HomeProvider>()
                                    .selectTab(HomeTab.todo);
                                context.read<HomeProvider>().getTasks(
                                    status: 'TODO', isFirstLoad: true);
                              },
                            ),
                            TodolistTabWidget(
                              tabName: 'Doing',
                              tabSelect: currentTab == HomeTab.doing,
                              onTap: () {
                                context
                                    .read<HomeProvider>()
                                    .selectTab(HomeTab.doing);
                                context.read<HomeProvider>().getTasks(
                                    status: 'DOING', isFirstLoad: true);
                              },
                            ),
                            TodolistTabWidget(
                              tabName: 'Done',
                              tabSelect: currentTab == HomeTab.done,
                              onTap: () {
                                context
                                    .read<HomeProvider>()
                                    .selectTab(HomeTab.done);
                                context.read<HomeProvider>().getTasks(
                                    status: 'DONE', isFirstLoad: true);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 9,
                child: tasks.isEmpty &&
                        context.watch<HomeProvider>().loading == false
                    ? Center(
                        child: Text(
                          'No tasks',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColors.appBlack,
                                  fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                        ),
                      )
                    : _createListView(tasks)),
            !isLoading
                ? const SizedBox()
                : Expanded(
                    flex: 1,
                    //child: CircularProgressIndicator(),
                    child: Center(
                      child: Text('Loading...',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: AppColors.appBlack,
                                  fontWeight: FontWeight.w600)),
                    )),
          ],
        ),
      ),
    );
  }

  Widget _createListView(List<Tasks> tasks) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          isLoading = !isLoading;
          Future.delayed(const Duration(milliseconds: 500), () {
            context
                .read<HomeProvider>()
                .getTasks(status: 'TODO', isFirstLoad: false);

            isLoading = !isLoading;
          });
        }
      }
    });

    return GroupedListView<Tasks, String>(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 0, bottom: 48),
      elements: tasks,
      groupBy: (element) => element.createdAtForGroup.toString(),
      groupSeparatorBuilder: (String groupByValue) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        margin: const EdgeInsets.only(top: 32, bottom: 8),
        child: Text(
          groupByValue,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppColors.appBlack, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          maxLines: 1,
        ),
      ),
      itemBuilder: (context, Tasks element) {
        Tasks currentItem = element;
        return SwipeActionCell(
          key: ObjectKey(element.id.toString()),
          trailingActions: <SwipeAction>[
            SwipeAction(
                icon: FaIcon(FontAwesomeIcons.trashCan,
                    color: AppColors.appWhite),
                onTap: (CompletionHandler handler) async {
                  context.read<HomeProvider>().deleteTask(currentItem);
                },
                color: AppColors.appRed),
          ],
          child: Column(
            children: [
              Container(
                height: 65,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.appMainColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element.title.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: AppColors.appBlack,
                                      fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                            ),
                            Text(
                              element.description.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: AppColors.appGray,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
