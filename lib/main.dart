import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spothole - OpenStreetMap',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _currentLocation = LatLng(20.5937, 78.9629); // Default location
  bool _loading = true;
  final MapController _mapController = MapController();
  Map<String, dynamic> potholeData = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission denied')),
          );
          setState(() => _loading = false);
        }
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      if (mounted) {
        
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
        });
        
        await _loadPotholeData();
        
        setState(() {
          _mapController.move(_currentLocation, 15.0);
          _loading = false;
        });
        
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to get location: $e")),
        );
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _loadPotholeData() async {
    
    try {
      final ref = FirebaseDatabase.instance.ref("potholes");
      final snapshot = await ref.get();
      debugPrint("Raw Firebase snapshot: ${snapshot.value}");

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        setState(() {
          potholeData = data;
        });
        debugPrint("Parsed pothole data: $potholeData");
      } else {
        debugPrint("No pothole data found.");
      }
    } catch (e) {
      debugPrint("Error loading potholes: $e");
    }
  }

  

  double _distanceInMeters(LatLng p1, LatLng p2) {
    final Distance distance = Distance();
    return distance.as(LengthUnit.Meter, p1, p2);
  }

  List<CircleMarker> _getNearbyPotholeCircles() {
    List<CircleMarker> circles = [];

    potholeData.forEach((key, value) {
      if (value["PotHole"] == 1) {
        final potholeLatLng = LatLng(value["latitude"], value["longitude"]);
        final distance = _distanceInMeters(_currentLocation, potholeLatLng);
        if (distance <= 1000000) {  //For Demo very high value of potholes
          circles.add(
            CircleMarker(
              point: potholeLatLng,
              color: Colors.red.withOpacity(0.4),
              borderStrokeWidth: 1,
              borderColor: Colors.red,
              useRadiusInMeter: true,
              radius: 50,
            ),
          );
        }
      }
    });

    return circles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spothole - OpenStreetMap")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation,
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.spothole',
                ),
                CircleLayer(
                  circles: [
                    // 1 km user radius
                    CircleMarker(
                      point: _currentLocation,
                      color: Colors.blue.withOpacity(0.3),
                      borderStrokeWidth: 2,
                      borderColor: Colors.blueAccent,
                      useRadiusInMeter: true,
                      radius: 100,
                    ),
                    // Nearby pothole danger zones
                    ..._getNearbyPotholeCircles(),
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation,
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.location_pin,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getUserLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
