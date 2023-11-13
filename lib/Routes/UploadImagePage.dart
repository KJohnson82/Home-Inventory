// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// // models
// // import '../models/hexCode.dart';
//
// // firebase
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
//
// // firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
// firebase_storage.Reference storageRef = storage.ref();
//
//
// class ImageUploadPage extends StatefulWidget {
//   @override
//   _ImageUploadPageState createState() => _ImageUploadPageState();
// }
//
//
// class _ImageUploadPageState extends State<ImageUploadPage> {
//   File? _imageFile;
//   String? _uploadedImageUrl;
//
//   Future<void> _pickImage() async {
//     final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedImage != null) {
//         _imageFile = File(pickedImage.path);
//       }
//     });
//   }
//
//   Future<void> _uploadImage() async {
//     if (_imageFile == null) {
//       return;
//     }
//
//     final storageRef = FirebaseStorage.instance.ref();
//
//     final fileName = 'Image_${DateTime.now().millisecondsSinceEpoch}.jpg';
//
//     final uploadTask = storageRef.child(fileName).putFile(_imageFile!);
//     final snapshot = await uploadTask.whenComplete(() {});
//
//     final downloadUrl = await snapshot.ref.getDownloadURL();
//
//     setState(() {
//       _uploadedImageUrl = downloadUrl;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Color(hexCode('#7A9E9F')),
//         title: Text('Upload Item Image'),
//         leading: IconButton(
//           icon: Icon(Icons.menu),
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           },
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         padding: EdgeInsets.all(16.0), // Added padding
//         child: Column(
//           children: [
//             Container(
//               width: 200,
//               height: 200,
//               color: Colors.grey.withOpacity(0.5), // Placeholder image color
//               child: _uploadedImageUrl != null
//                   ? Image.network(
//                 _uploadedImageUrl!,
//                 width: 200,
//                 height: 200,
//               )
//                   : Icon(
//                 Icons.image, // Placeholder image icon
//                 size: 100,
//                 color: Colors.grey.withOpacity(0.8),
//               ),
//             ),
//             SizedBox(height: 16.0), // Added spacing
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: _pickImage,
//                   child: Text('Pick Image'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFACB98B),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _uploadImage,
//                   child: Text('Upload Image'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFACB98B),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
