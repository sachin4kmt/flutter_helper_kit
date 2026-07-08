import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget screenUtilDemo(BuildContext context) {
  return ListView(
    padding: EdgeInsets.all(16.w),
    children: [
      Text('Responsive sizing demo', style: TextStyle(fontSize: 18.sp)),
      SizedBox(height: 12.h),
      Container(
        width: 200.w,
        height: 80.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text('200.w × 80.h', style: TextStyle(fontSize: 14.sp)),
      ),
      SizedBox(height: 16.h),
      RPadding(
        padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text('RPadding + REdgeInsets', style: TextStyle(fontSize: 14.sp)),
      ),
      RSizedBox(height: 8.h),
      Text('Screen: ${1.sw.toStringAsFixed(0)}w × ${1.sh.toStringAsFixed(0)}h'),
    ],
  );
}
