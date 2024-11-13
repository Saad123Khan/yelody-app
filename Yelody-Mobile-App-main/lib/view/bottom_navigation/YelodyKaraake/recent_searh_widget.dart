import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yelody_app/res/colors/app_color.dart';
import 'package:yelody_app/res/fonts/app_fonts.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

class RecentSearchesWidget extends StatefulWidget {
  const RecentSearchesWidget(
      {super.key, required this.controller, required this.focusNode});
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  _RecentSearchesWidgetState createState() => _RecentSearchesWidgetState();
}

class _RecentSearchesWidgetState extends State<RecentSearchesWidget> {
  late Future<List<String>> recentSearchesFuture;

  @override
  void initState() {
    super.initState();
    recentSearchesFuture = loadRecentSearches();
  }

  Future<List<String>> loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recentSearches') ?? [];
  }

  Future<void> saveRecentSearches(List<String> searches) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('recentSearches', searches);
  }

  Future<void> clearRecentSearches() async {
    await saveRecentSearches([]);
    setState(() {
      recentSearchesFuture = Future.value([]);
    });
  }

  Future<void> deleteSearch(List<String> searches, int index) async {
    searches.removeAt(index);
    await saveRecentSearches(searches);
    setState(() {
      recentSearchesFuture = Future.value(searches);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 18,
                fontFamily: AppFonts.Urbanist,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: clearRecentSearches,
              child: const Text(
                'Clear All',
                style: TextStyle(
                  fontFamily: AppFonts.Urbanist,
                  color: AppColor.primaryColor, // Change the color as needed
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 1,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          color: Colors.grey.withOpacity(0.5),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder<List<String>>(
            future: recentSearchesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text(
                  'No recent searches.',
                  style: TextStyle(
                    fontFamily: AppFonts.Urbanist,
                  ),
                ));
              }
              List<String> recentSearches = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                // padding: EdgeInsets.zero,
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Get.find<HomeController>().searchInBottomSheet.value =
                          true;

                      widget.controller.text = recentSearches[index];
                      widget.focusNode.requestFocus();
                    },
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      recentSearches[index],
                      style: const TextStyle(
                        fontFamily: AppFonts.Urbanist,
                      ),
                    ),
                    trailing: InkWell(
                      // padding: EdgeInsets.zero,
                      child: const Icon(
                        Icons.close,
                        color: AppColor.whiteColor,
                      ),
                      onTap: () => deleteSearch(recentSearches, index),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
