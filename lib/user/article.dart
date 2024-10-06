import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro2/services/firebaseFunctions.dart';

class article extends StatefulWidget {
  article({super.key});

  @override
  State<article> createState() => _articleState();
}

class _articleState extends State<article> {
  late Future<List<Map<String, dynamic>>> _articles;
  @override
  void initState() {
    super.initState();
    _articles = fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Educational Tips',
          style: GoogleFonts.publicSans(
              fontWeight: FontWeight.bold, fontSize: size.height * 0.04),
        ),
        toolbarHeight: size.height * 0.15,
        backgroundColor: const Color.fromARGB(255, 31, 160, 143),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var article = snapshot.data![index];

                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Column(
                        children: [
                          Text(
                            article['title'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.07,
                                fontWeight: FontWeight.bold),
                          ),
                          Image.network(
                            article['imageUrl'],
                            width: size.width * 0.6,
                          ),
                          Text(
                            article['description'],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 0.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
