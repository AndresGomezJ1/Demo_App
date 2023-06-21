import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movie_app/core/resources/app_constants.dart';
import 'package:movie_app/core/resources/app_strings.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    setState(() {
      _markers.clear();
      var marker = const Marker(
        markerId: MarkerId(AppStrings.markTitle),
        position: LatLng(AppConstants.markLatitude, AppConstants.markLongitude),
        infoWindow: InfoWindow(
          title: AppStrings.markTitle,
          snippet: AppStrings.markDescription,
        ),
      );
      _markers[AppStrings.markTitle] = marker;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(AppConstants.markLatitude, AppConstants.markLongitude),
          zoom: AppConstants.mapStartZoom,
        ),
        markers: _markers.values.toSet(),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        compassEnabled: true,
        mapType: MapType.satellite,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
