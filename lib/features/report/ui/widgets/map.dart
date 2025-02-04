import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_project/core/helper/extension.dart';
import 'package:graduation_project/core/theming/color.dart';
import 'package:graduation_project/core/theming/style_manager.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3));

    _checkGpsStatus();
  }

  Future<void> _checkGpsStatus() async {
    bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isGpsEnabled) {
      _showGpsDialog();
    } else {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _showGpsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            textDirection: TextDirection.rtl,
            "الوصول الي الموقع",
            style: CairoTextStyles.regular.copyWith(color: ColorsManager.black),
          ),
          content: Text(
            textDirection: TextDirection.rtl,
            'نرجوا السماح بالوصول الي موقعك الحالي عن طريق تشغيل خدمات الموقع',
            style: CairoTextStyles.regular.copyWith(color: ColorsManager.black),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                context.pop();
              },
              child: Text(
                textDirection: TextDirection.rtl,
                'أذهب الي الأعدادات',
                style: CairoTextStyles.regular
                    .copyWith(color: ColorsManager.black),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                textDirection: TextDirection.rtl,
                'خروج',
                style: CairoTextStyles.regular
                    .copyWith(color: ColorsManager.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      _currentLocation = latLng;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: ColorsManager.mainGreen, width: 1.5.w)),
      height: 400.h,
      width: 390.w,
      child: _currentLocation == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainGreen,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: _currentLocation!,
                  initialZoom: 15.0,
                  onTap: (tapPosition, latLng) {
                    _onMapTapped(latLng);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 30.0.w,
                        height: 30.0.h,
                        point: _currentLocation!,
                        child: SvgPicture.asset(
                          "assets/SVGs/home/locationPoint.svg",
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
