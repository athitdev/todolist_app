// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swipe_action_cell/core/cell.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:grouped_list/grouped_list.dart';

// import '../../../../themes/app_theme.dart';
// import '../models/todolist_model.dart';
// import '../providers/home_provider.dart';

// class TaskListVieWidget extends StatefulWidget {
//   const TaskListVieWidget({super.key});

//   @override
//   State<TaskListVieWidget> createState() => _TaskListVieWidgetState();
// }

// class _TaskListVieWidgetState extends State<TaskListVieWidget> {
//   @override
//   Widget build(BuildContext context) {
//     _scrollController.addListener(() {
//       if (_scrollController.position.maxScrollExtent ==
//           _scrollController.position.pixels) {
//         if (!isLoading) {
//           isLoading = !isLoading;
//           Future.delayed(const Duration(milliseconds: 500), () {
//             context
//                 .read<HomeProvider>()
//                 .getTasks(status: 'TODO', isFirstLoad: false);

//             isLoading = !isLoading;
//           });
//         }
//       }
//     });
//     return GroupedListView<Tasks, String>(
//       controller: _scrollController,
//       padding: const EdgeInsets.only(top: 0, bottom: 48),
//       elements: tasks,
//       groupBy: (element) => element.createdAtForGroup.toString(),
//       groupSeparatorBuilder: (String groupByValue) => Container(
//         padding: const EdgeInsets.symmetric(horizontal: 32),
//         margin: const EdgeInsets.only(top: 32, bottom: 8),
//         child: Text(
//           groupByValue,
//           style: Theme.of(context)
//               .textTheme
//               .bodyLarge!
//               .copyWith(color: AppColors.appBlack, fontWeight: FontWeight.w600),
//           overflow: TextOverflow.ellipsis,
//           softWrap: false,
//           maxLines: 1,
//         ),
//       ),
//       itemBuilder: (context, Tasks element) {
//         Tasks currentItem = element;
//         return SwipeActionCell(
//           key: ObjectKey(element.id.toString()),
//           trailingActions: <SwipeAction>[
//             SwipeAction(
//                 icon: FaIcon(FontAwesomeIcons.trashCan,
//                     color: AppColors.appWhite),
//                 onTap: (CompletionHandler handler) async {
//                   context.read<HomeProvider>().deleteTask(currentItem);
//                 },
//                 color: AppColors.appRed),
//           ],
//           child: Column(
//             children: [
//               Container(
//                 height: 65,
//                 padding: const EdgeInsets.symmetric(horizontal: 32),
//                 child: Center(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                               color: AppColors.appMainColor,
//                               borderRadius:
//                                   const BorderRadius.all(Radius.circular(8.0))),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         flex: 6,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               element.title.toString(),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge!
//                                   .copyWith(
//                                       color: AppColors.appBlack,
//                                       fontWeight: FontWeight.w600),
//                               overflow: TextOverflow.ellipsis,
//                               softWrap: false,
//                               maxLines: 1,
//                             ),
//                             Text(
//                               element.description.toString(),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodySmall!
//                                   .copyWith(
//                                     color: AppColors.appGray,
//                                   ),
//                               overflow: TextOverflow.ellipsis,
//                               softWrap: false,
//                               maxLines: 2,
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // Widget _createListView(List<Tasks> tasks) {
//   //   _scrollController.addListener(() {
//   //     if (_scrollController.position.maxScrollExtent ==
//   //         _scrollController.position.pixels) {
//   //       if (!isLoading) {
//   //         isLoading = !isLoading;
//   //         Future.delayed(const Duration(milliseconds: 500), () {
//   //           context
//   //               .read<HomeProvider>()
//   //               .getTasks(status: 'TODO', isFirstLoad: false);

//   //           isLoading = !isLoading;
//   //         });
//   //       }
//   //     }
//   //   });

//   //   return GroupedListView<Tasks, String>(
//   //     controller: _scrollController,
//   //     padding: const EdgeInsets.only(top: 0, bottom: 48),
//   //     elements: tasks,
//   //     groupBy: (element) => element.createdAtForGroup.toString(),
//   //     groupSeparatorBuilder: (String groupByValue) => Container(
//   //       padding: const EdgeInsets.symmetric(horizontal: 32),
//   //       margin: const EdgeInsets.only(top: 32, bottom: 8),
//   //       child: Text(
//   //         groupByValue,
//   //         style: Theme.of(context)
//   //             .textTheme
//   //             .bodyLarge!
//   //             .copyWith(color: AppColors.appBlack, fontWeight: FontWeight.w600),
//   //         overflow: TextOverflow.ellipsis,
//   //         softWrap: false,
//   //         maxLines: 1,
//   //       ),
//   //     ),
//   //     itemBuilder: (context, Tasks element) {
//   //       Tasks currentItem = element;
//   //       return SwipeActionCell(
//   //         key: ObjectKey(element.id.toString()),
//   //         trailingActions: <SwipeAction>[
//   //           SwipeAction(
//   //               icon: FaIcon(FontAwesomeIcons.trashCan,
//   //                   color: AppColors.appWhite),
//   //               onTap: (CompletionHandler handler) async {
//   //                 context.read<HomeProvider>().deleteTask(currentItem);
//   //               },
//   //               color: AppColors.appRed),
//   //         ],
//   //         child: Column(
//   //           children: [
//   //             Container(
//   //               height: 65,
//   //               padding: const EdgeInsets.symmetric(horizontal: 32),
//   //               child: Center(
//   //                 child: Row(
//   //                   crossAxisAlignment: CrossAxisAlignment.center,
//   //                   children: [
//   //                     Expanded(
//   //                       flex: 1,
//   //                       child: Container(
//   //                         width: 50,
//   //                         height: 50,
//   //                         decoration: BoxDecoration(
//   //                             color: AppColors.appMainColor,
//   //                             borderRadius:
//   //                                 const BorderRadius.all(Radius.circular(8.0))),
//   //                       ),
//   //                     ),
//   //                     const SizedBox(width: 8),
//   //                     Expanded(
//   //                       flex: 6,
//   //                       child: Column(
//   //                         mainAxisAlignment: MainAxisAlignment.center,
//   //                         crossAxisAlignment: CrossAxisAlignment.start,
//   //                         children: [
//   //                           Text(
//   //                             element.title.toString(),
//   //                             style: Theme.of(context)
//   //                                 .textTheme
//   //                                 .bodyLarge!
//   //                                 .copyWith(
//   //                                     color: AppColors.appBlack,
//   //                                     fontWeight: FontWeight.w600),
//   //                             overflow: TextOverflow.ellipsis,
//   //                             softWrap: false,
//   //                             maxLines: 1,
//   //                           ),
//   //                           Text(
//   //                             element.description.toString(),
//   //                             style: Theme.of(context)
//   //                                 .textTheme
//   //                                 .bodySmall!
//   //                                 .copyWith(
//   //                                   color: AppColors.appGray,
//   //                                 ),
//   //                             overflow: TextOverflow.ellipsis,
//   //                             softWrap: false,
//   //                             maxLines: 2,
//   //                           ),
//   //                         ],
//   //                       ),
//   //                     )
//   //                   ],
//   //                 ),
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
// }
