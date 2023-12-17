import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'main.dart';

class ImageUploadPage extends StatefulWidget {
  final Function(File?) onImageSelected; // Callback function

  const ImageUploadPage({Key? key, required this.onImageSelected})
      : super(key: key);

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? _selectedImage;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      widget.onImageSelected(_selectedImage); // Notify the parent widget
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColorOldLace,
      appBar: AppBar(
        backgroundColor: customColorFireBrick,
        title: Text('Image Upload',
            style: TextStyle(
                color: customColorOldLace,
                fontFamily: 'PeachandCream',
                fontSize: 64)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
            const Text('Upload a picture to update profile picture'),
            const SizedBox(height: 25),
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 200,
                    height: 200,
                    color: Colors.white,
                    child: Icon(
                      Icons.image,
                      size: 80,
                      color: customColorFireBrick,
                    ),
                  ),
            const SizedBox(height: 25),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _getImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: customColorFireBrick,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
