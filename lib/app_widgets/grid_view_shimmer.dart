import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class GridViewShimmer extends StatelessWidget {
  GridViewShimmer({this.numberOfShimmer});
  final int numberOfShimmer;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            height: 100.h,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 27.h,
                crossAxisCount: 2,
                crossAxisSpacing: 1.h,
              ),
              itemCount: numberOfShimmer ?? 8,
              itemBuilder: (_, __) => Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12))),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: double.infinity,
                              height: 1.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)))),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0)),
                          Container(
                              width: double.infinity,
                              height: 1.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)))),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0)),
                          Container(
                              width: 10.w,
                              height: 1.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
