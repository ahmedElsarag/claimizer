import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

import '../res/colors.dart';

class DefaultFlutterMap extends StatefulWidget {
  const DefaultFlutterMap({Key key, this.lat, this.lng, this.zoom, this.title})
      : super(key: key);
  final double lat;
  final double lng;
  final double zoom;
  final String title;

  @override
  _DefaultFlutterMapState createState() => _DefaultFlutterMapState();
}

class _DefaultFlutterMapState extends State<DefaultFlutterMap> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      width: double.maxFinite,
      height: 25.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.sp),
        child: FlutterMap(
          nonRotatedChildren: [
            PositionedDirectional(
              end: 2.w,
              bottom: 1.h,
              child: Text(
                "© CheckIN",
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: MColors.font_color,
                    fontWeight: FontWeight.w600,
                    fontSize: 6.sp),
              ),
            ),
          ],
          options: MapOptions(
            interactiveFlags: InteractiveFlag.pinchZoom ,
            center: LatLng(widget.lat, widget.lng),
            zoom: widget.zoom??4,
          ),
          layers: [
            TileLayerOptions(
              backgroundColor: MColors.primary_color,
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 30.w,
                  height: 8.h,
                  point: LatLng(widget.lat, widget.lng),
                  builder: (ctx) => Container(
                    child: Column(
                      children: [
                        Container(
                            /*height: 2.5.h,*/
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius: BorderRadius.circular(6)),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                widget.title,
                                style: TextStyle(fontSize: 6.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        Icon(
                          Icons.location_pin,
                          color: MColors.primary_color,
                          size: 15.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
