import 'package:flutter/material.dart';
import 'package:flutter_helper_kit/flutter_helper_kit.dart';

Widget sliverResponsiveDemo(BuildContext context) {
  return CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Text('RSliverPadding + RSliverSizedBox',
              style: TextStyle(fontSize: 16.sp)),
        ),
      ),
      RSliverPadding(
        padding: REdgeInsets.symmetric(horizontal: 16),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, i) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Container(
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('Row $i — ${100.w.toStringAsFixed(0)}w wide box'),
              ),
            ),
            childCount: 4,
          ),
        ),
      ),
      RSliverSizedBox(height: 16.h),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text('verticalSpace + horizontalSpace widgets below'),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              const Text('A'),
              12.horizontalSpace,
              const Text('B'),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Top'),
              8.verticalSpace,
              const Text('Bottom'),
            ],
          ),
        ),
      ),
    ],
  );
}
