import 'package:flutter/material.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'database.dart';
import 'photo_model.dart';

class HomeContent extends StatefulWidget {
  final String enteredUsername;
  final File? profileImage;
  final UserDatabase userdatabase = UserDatabase();

  HomeContent({
    Key? key,
    required this.enteredUsername,
    required this.profileImage,
  }) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.red,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: widget.profileImage != null
                      ? Image.file(
                          widget.profileImage!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/tablogo.png',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome,',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PeachandCream',
                color: Colors.red,
                fontSize: 128,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.enteredUsername,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    ));
  }
}

// class HomeContent extends StatefulWidget {
//   final String enteredUsername;
//   final File? profileImage;
//   final UserDatabase userdatabase = UserDatabase();
//
//   HomeContent({
//     Key? key,
//     required this.enteredUsername,
//     required this.profileImage,
//   }) : super(key: key);
//
//   @override
//   _HomeContentState createState() => _HomeContentState();
// }
//
// class _HomeContentState extends State<HomeContent> {
//   late WeatherModel _weather;
//   final ApiService _apiService = ApiService();
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   void _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     WeatherModel? weather = await _apiService.getWeather(position.latitude, position.longitude);
//
//     if (weather != null) {
//       setState(() {
//         _weather = weather;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 height: 300,
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   children: [
//                     if (_weather != null) ...{
//                       Text('Temperature: ${_weather.temperature.join(', ')}'),
//                       Text('Precipitation: ${_weather.precipitation.join(', ')}'),
//                     } else {
//                       CircularProgressIndicator(),
//                       const SizedBox(height: 8),
//                       Text('Loading weather data...'),
//                     },
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
