import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' show cos, sqrt, asin;

//import 'main.dart';

class NavigationScreen extends StatefulWidget {
  final double lat;
  final double lng;
  NavigationScreen(this.lat, this.lng);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  LatLng curLocation = const LatLng(23.0525, 72.5667);
  StreamSubscription<loc.LocationData>? locationSubscription;
  LocationData? _currentLocations;

  Location locations = Location();
  bool check = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavigation();
    addMarker();
    // _getCurrentLocation();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }
  // _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;

  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   LocationData currentLocation = await location.getLocation();
  //   setState(() {
  //     _currentLocations = currentLocation;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sourcePosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  polylines: Set<Polyline>.of(polylines.values),
                  initialCameraPosition: CameraPosition(
                    target: curLocation,
                    zoom: 16,
                  ),
                  markers: {sourcePosition!, destinationPosition!},
                  onTap: (latLng) {
                    if (kDebugMode) {
                      print(latLng);
                    }
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                  top: 30,
                  left: 15,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(builder: (context) => MyApp()),
                      //     (route) => false);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.navigation_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            setState(() {
                              check = false;
                            });
                            _navigateToDestination(
                                destinationPosition!.position.latitude,
                                destinationPosition!.position.longitude);
                            // await launchUrl(Uri.parse(
                            //     'google.navigation:q=${widget.lat}, ${widget.lng}&key=AIzaSyA96nHRuX9rPNMPZ_oNhMynl-4O0zwJAEY'));
                          },
                        ),
                      ),
                    )),
                Positioned(
                    bottom: 80,
                    right: 10,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: Center(
                        child: GestureDetector(
                          child: Icon(
                            Icons.location_pin,
                            color: Colors.white,
                          ),
                          // Image.network(
                          //   'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Google_Maps_Logo_2020.svg/2275px-Google_Maps_Logo_2020.svg.png',fit: BoxFit.contain,
                          // ),
                          onTap: () async {
                            setState(() {
                              check = false;
                            });
                            // _navigateToDestination(
                            //     destinationPosition!.position.latitude,
                            //     destinationPosition!.position.longitude);
                            await launchUrl(Uri.parse(
                                'google.navigation:q=${widget.lat}, ${widget.lng}&key=AIzaSyA96nHRuX9rPNMPZ_oNhMynl-4O0zwJAEY'));
                          },
                        ),
                      ),
                    ))
              ],
            ),
    );
  }

  getNavigation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      curLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
        check
            ? controller
                ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(
                    currentLocation.latitude!, currentLocation.longitude!),
                zoom: 12.5,
              )))
            :  controller!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 17.5,
        )),
      );
        if (mounted) {
          controller
              ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            curLocation =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);
            sourcePosition = Marker(
              markerId: MarkerId(currentLocation.toString()),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(
                  title:
                      '${double.parse((getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(20)))} km'),
              onTap: () {
                print('market tapped');
              },
            );
          });
          getDirections(LatLng(widget.lat, widget.lng));
        }
      });
    }
  }

  getDirections(LatLng dst) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    try {
      log('1');
      log(curLocation.latitude.toString(), name: 'latitude');
      log(curLocation.longitude.toString(), name: 'longtitude');
      log(dst.latitude.toString(), name: 'dstlatitude');
      log(dst.longitude.toString(), name: 'dtlogtude');
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          'AIzaSyA96nHRuX9rPNMPZ_oNhMynl-4O0zwJAEY',
          PointLatLng(curLocation.latitude, curLocation.longitude),
          PointLatLng(dst.latitude, dst.longitude),
          travelMode: TravelMode.driving);
      log('2');
      if (result.points.isNotEmpty) {
        log('3');
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          points.add({'lat': point.latitude, 'lng': point.longitude});
        });
        log('4');
      } else {
        log('5');
        if (kDebugMode) {
          print(result.errorMessage);
        }
      }
      log('6');
      addPolyLine(polylineCoordinates);
    } catch (e) {
      log(e.toString());
    }
    log('7');
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double getDistance(LatLng destposition) {
    return calculateDistance(curLocation.latitude, curLocation.longitude,
        destposition.latitude, destposition.longitude);
  }

  addMarker() {
    setState(() {
      sourcePosition = Marker(
        markerId: const MarkerId('source'),
        position: curLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );
      destinationPosition = Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(widget.lat, widget.lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });
  }

  Future<void> _navigateToDestination(
      double destinationLat, double destinationLng) async {
    final GoogleMapController? controller = await _controller.future;
    _currentPosition = await location.getLocation();
    String apiKey =
        'AIzaSyA96nHRuX9rPNMPZ_oNhMynl-4O0zwJAEY'; // Replace with your Google Maps API key
    String origin = '${curLocation.latitude},${curLocation.longitude}';
    String destination = '$destinationLat,$destinationLng';
    String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';

    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<LatLng> points = <LatLng>[];
      jsonData['routes'][0]['legs'][0]['steps'].forEach((dynamic step) {
        points.add(LatLng(
            step['start_location']['lat'], step['start_location']['lng']));
        points.add(
            LatLng(step['end_location']['lat'], step['end_location']['lng']));
      });

      setState(() {
        destinationPosition = Marker(
            markerId: MarkerId('destination'),
            position: LatLng(destinationLat, destinationLng));
      });

      controller!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
          zoom: 17.5,
        )),
      );

      // showDialog(
      //   context: context,
      //   builder: (_) {
      //     return AlertDialog(
      //       title: Text('Directions'),
      //       content: Text('Navigate from current location to the destination!'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text('Close'),
      //         ),
      //       ],
      //     );
      //   },
      // );
    } else {
      print('Failed to fetch directions');
    }
  }
}
