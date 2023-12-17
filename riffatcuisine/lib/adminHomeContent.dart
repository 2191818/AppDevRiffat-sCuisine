import 'package:flutter/material.dart';
import 'dart:io';

class AdminHomeContent extends StatelessWidget {
  final String enteredUsername;
  final File? profileImage;

  const AdminHomeContent({
    Key? key,
    required this.enteredUsername,
    required this.profileImage, required int userId,
  }) : super(key: key);

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
                    child: profileImage != null
                        ? Image.file(
                      profileImage!,
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
                enteredUsername,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // FutureBuilder<Position>(
              //   future: _getUserLocation(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       if (snapshot.hasData) {
              //         final position = snapshot.data!;
              //         return Container(
              //           padding: const EdgeInsets.all(10),
              //           decoration: BoxDecoration(
              //             color: Colors.grey[200],
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //           child: Column(
              //             children: [
              //               const Text(
              //                 'Your Current Location:',
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 16,
              //                 ),
              //               ),
              //               const SizedBox(height: 5),
              //               Text(
              //                 'Latitude: ${position.latitude}',
              //                 style: const TextStyle(fontSize: 14),
              //               ),
              //               Text(
              //                 'Longitude: ${position.longitude}',
              //                 style: const TextStyle(fontSize: 14),
              //               ),
              //             ],
              //           ),
              //         );
              //       } else if (snapshot.hasError) {
              //         return const Text('Error fetching location');
              //       }
              //     }
              //     return const CircularProgressIndicator();
              //   },
              // ),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     _getUserLocation(); // Request location when button is pressed
              //   },
              //   child: const Text('Get Location'),
              // ),
            ],
          ),
        ],
      ),
    );
  }

// Future<Position> _getUserLocation() async {
//   var status = await Permission.location.request();
//   if (status == PermissionStatus.granted) {
//     return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//   } else {
//     throw Exception('Location permission denied');
//   }
// }
}

