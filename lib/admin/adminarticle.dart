import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro2/services/firebaseFunctions.dart';

class adminarticle extends StatefulWidget {
  adminarticle({
    super.key,
  });

  @override
  State<adminarticle> createState() => _adminarticleState();
}

class _adminarticleState extends State<adminarticle> {
  List<String> selectedArticles = [];
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  File? image;
  final picker = ImagePicker();

  Future<List<DocumentSnapshot>> getArticles() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('articles')
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs;
  }

  void deleteSelectedArticles() async {
    for (String id in selectedArticles) {
      await FirebaseFirestore.instance.collection('articles').doc(id).delete();
    }
    setState(() {
      selectedArticles.clear();
    });
  }

  Future getImageGallery() async {
    final PickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (PickedFile != null) {
        image = File(PickedFile.path);
        //widget.imgUrl = null;
      } else {
        print("No Image picked");
      }
    });
  }

  Future<void> submitArticle() async {
    String? imageUrl = await uploadImage(image!);
    await addArticle(
        titlecontroller.text, descriptioncontroller.text, imageUrl!);
    titlecontroller.text = '';
    descriptioncontroller.text = '';
    setState(() {
      image = null;
    });

    showUploadSuccessDialog(context);
  }

  void showUploadSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 31, 160, 143),
          title: const Text(
            "Upload Successful",
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            "Your Article has been uploaded successfully.",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(13),
                  width: size.width,
                  height: size.height * 0.14,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Color.fromARGB(255, 31, 160, 143),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Add Articles",
                          style: GoogleFonts.publicSans(
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.04)),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    children: [
                      TextField(
                        maxLength: 100,
                        controller: titlecontroller,
                        style: TextStyle(
                            color: Colors.black, fontSize: size.height * 0.02),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 31, 160, 143),
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 10, style: BorderStyle.solid)),
                          counterText: '',
                          hintText: "Add Title",
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      TextField(
                        maxLines: 5,
                        maxLength: 1000,
                        controller: descriptioncontroller,
                        style: TextStyle(
                            color: Colors.black, fontSize: size.height * 0.02),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 31, 160, 143),
                              style: BorderStyle.solid,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  width: 10, style: BorderStyle.solid)),
                          counterText: '',
                          hintText: "Add Description",
                          hintStyle: const TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      InkWell(
                          onTap: () {
                            getImageGallery();
                          },
                          child: Container(
                              width: size.width,
                              height: size.height * 0.14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                              ),
                              child: image != null
                                  ? Image.file(image!.absolute,
                                      fit: BoxFit.cover)
                                  : const Center(
                                      child: Icon(
                                        Icons.add_photo_alternate,
                                        size: 50,
                                        color: Colors.black,
                                      ),
                                    )))
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  width: size.width * 0.95,
                  height: size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      submitArticle();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow),
                    child: Text(
                      "Update Articles",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ),
                ),
                FutureBuilder<List<DocumentSnapshot>>(
                  future: getArticles(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No articles found'));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var article = snapshot.data![index];
                                return ListTile(
                                  title: Text(
                                    article['title'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                  leading: Checkbox(
                                    checkColor: Colors.white,
                                    activeColor:
                                        Color.fromARGB(255, 31, 160, 143),
                                    value:
                                        selectedArticles.contains(article.id),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          selectedArticles.add(article.id);
                                        } else {
                                          selectedArticles.remove(article.id);
                                        }
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              width: size.width * 0.95,
                              height: size.height * 0.06,
                              child: ElevatedButton(
                                onPressed: () {
                                  deleteSelectedArticles();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: Text(
                                  "Delete Articles",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.04,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
