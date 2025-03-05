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
  final Function(LatLng)? onLocationSelected;

  MapScreen({this.onLocationSelected});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
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
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _showGpsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 1,
          backgroundColor: ColorsManager.greenWhite,
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
      currentLocation = latLng;
    });

    if (widget.onLocationSelected != null) {
      widget.onLocationSelected!(latLng);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: ColorsManager.mainGreen, width: 1.5.w)),
      height: 400.h,
      width: 390.w,
      child: currentLocation == null
          ? Center(
              child: CircularProgressIndicator(
                color: ColorsManager.mainGreen,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: currentLocation!,
                  initialZoom: 20.0,
                  onTap: (tapPosition, latLng) {
                    _onMapTapped(latLng);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 30.0.w,
                        height: 30.0.h,
                        point: currentLocation!,
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
