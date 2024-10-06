// ignore: file_names
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

Future<String?> uploadImage(File image) async {
  try {
    String fileName = basename(image.path);
    print("File name: $fileName");

    Reference storageRef =
        FirebaseStorage.instance.ref().child('articles/$fileName');
    UploadTask uploadTask = storageRef.putFile(image);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    }, onError: (e) {
      print("Upload error: $e");
    });

    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    print("Image uploaded successfully. Download URL: $downloadUrl");

    return downloadUrl;
  } catch (e) {
    print("Failed to upload image: $e");
    return null;
  }
}

Future<void> addArticle(
    String title, String description, String imageUrl) async {
  await firestore.collection('articles').add({
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'timestamp': FieldValue.serverTimestamp(),
  });
}

Future<List<Map<String, dynamic>>> fetchArticles() async {
  QuerySnapshot querySnapshot = await firestore.collection('articles').get();
  return querySnapshot.docs
      .map((doc) => doc.data() as Map<String, dynamic>)
      .toList();
}
