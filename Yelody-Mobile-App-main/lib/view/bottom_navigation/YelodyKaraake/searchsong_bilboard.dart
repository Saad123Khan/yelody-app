import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yelody_app/models/charts/chart_list_res.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/res/colors/app_color.dart';

class SearchSongChartBillBaordWidget extends StatelessWidget {
  const SearchSongChartBillBaordWidget({
    super.key,
    required this.chartData,
    required this.onChartCardTap,
  });

  final ChartData chartData;
  final VoidCallback onChartCardTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChartCardTap,
      child: Stack(
        children: [
          Container(
            // height: 120.h,
            // width: 120.h,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
              image: chartData.image != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          NetworkStrings.imageURL + chartData.image!))
                  : null,
              border: Border.all(color: Colors.transparent),
            ),
          ),
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
              color: AppColor.blackColor.withOpacity(.4),
              borderRadius: BorderRadius.circular(12),
            ),
          )),
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    chartData.name ?? '',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
