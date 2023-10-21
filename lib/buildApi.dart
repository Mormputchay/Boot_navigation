import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuilderApiScreen extends StatefulWidget {
  const BuilderApiScreen({super.key});
  @override
  State<BuilderApiScreen> createState() => _BuilderApiScreenState();
}

class _BuilderApiScreenState extends State<BuilderApiScreen> {
  Future<List> getApi() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Build Api",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getApi(),
        builder: (context, snanshot) {
          if (snanshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          return ListView.builder(
              //itemCount: snanshot.data!.length,
              itemCount: snanshot.data != null ? snanshot.data!.length : 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white24,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.black26,
                              offset: Offset(2, 4))
                        ]),
                    width: media.width,
                    height: 170,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BuildData(
                            title: " userId : ",
                            subtitle:
                                snanshot.data![index]["userId"].toString(),
                          ),
                          const SizedBox(height: 7),
                          BuildData(
                            title: " id : ",
                            subtitle: snanshot.data![index]["id"].toString(),
                          ),
                          const SizedBox(height: 7),
                          BuildData(
                            title: " Title : ",
                            subtitle: snanshot.data![index]["title"].toString(),
                          ),
                          const SizedBox(height: 7),
                          BuildData(
                            title: " Body : ",
                            subtitle: snanshot.data![index]["body"].toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class BuildData extends StatelessWidget {
  final String title;
  final String subtitle;
  const BuildData({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
