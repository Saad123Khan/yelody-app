import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yelody_app/models/songs/song_model.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

class ReorderableEditingList extends StatefulWidget {
  const ReorderableEditingList({super.key, required this.songs});
  final List<SongData> songs;

  @override
  State<ReorderableEditingList> createState() => _ReorderableEditingListState();
}

class _ReorderableEditingListState extends State<ReorderableEditingList> {
  // final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);
    final Color draggableItemColor = colorScheme.secondary;

    final homeController = Get.find<HomeController>();

    Widget proxyDecorator(
        Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double elevation = lerpDouble(0, 6, animValue)!;
          return Material(
            elevation: elevation,
            color: draggableItemColor,
            shadowColor: draggableItemColor,
            child: child,
          );
        },
        child: child,
      );
    }

    return ReorderableListView(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      children: <Widget>[
        for (int index = 0; index < widget.songs.length; index += 1)
          GestureDetector(
            key: Key('$index'),
            onTap: () {
              if (homeController.editedSelected.contains(widget.songs[index])) {
                homeController.editedSelected.remove(widget.songs[index]);
              } else {
                homeController.editedSelected.add(widget.songs[index]);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: homeController.editedSelected
                          .contains(widget.songs[index])
                      ?    Colors.white.withOpacity(0.05999999865889549)
                      : null),
              child: Row(
                // tileColor: widget.songs[index].isOdd ? oddItemColor : evenItemColor,
                // title: Text('Item ${widget.songs[index].name}'),
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: ShapeDecoration(
                      // color: const Color.fromARGB(255, 53, 53, 53),
                      color: Colors.white.withOpacity(0.10000000149011612),
                      image:
                          //  DecorationImage(
                          //   image:

                          //       // AssetImage("assets/images/divide.png"),
                          //       AssetImage(songImage),
                          //   fit: BoxFit.fill,
                          // ),
                          DecorationImage(
                        image: ExtendedNetworkImageProvider(
                            NetworkStrings.imageURL +
                                widget.songs[index].imageFile!),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          // 'Shape of you',
                          widget.songs[index].name ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          children: [
                            Text(
                              // 'Funk . ED Sheeran',
                              '${widget.songs[index].genre ?? ' '}',
                              style: TextStyle(
                                color: const Color(0xFF6C6D76),
                                fontSize: 14.sp,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              height: 3,
                              width: 3,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade800),
                            ),
                            Text(
                              // 'Funk . ED Sheeran',
                              '${widget.songs[index].artistName ?? ' '}',
                              style: TextStyle(
                                color: const Color(0xFF6C6D76),
                                fontSize: 14.sp,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ReorderableDragStartListener(
                    key: ValueKey<String>(widget.songs[index].songId!),
                    index: index,
                    child: Image.asset(
                      'assets/icons/drag_handle.png',
                      scale: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = widget.songs.removeAt(oldIndex);
          widget.songs.insert(newIndex, item);
        });
      },
    );
  }
}
