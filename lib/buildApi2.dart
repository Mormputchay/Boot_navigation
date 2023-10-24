import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BuildAPI2Screen extends StatefulWidget {
  const BuildAPI2Screen({super.key});
  @override
  State<BuildAPI2Screen> createState() => _BuildAPI2ScreenState();
}

class _BuildAPI2ScreenState extends State<BuildAPI2Screen> {
  Future<List> getApi() async {
    var url = Uri.parse("https://fakestoreapi.com/products");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    log('data: $data');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Build API"),
        centerTitle: true,
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
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GridView.builder(
                  //itemCount: snanshot.data!.length,
                  itemCount: snanshot.data != null ? snanshot.data!.length : 0,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 300,
                      mainAxisExtent: 295),
                  itemBuilder: (context, index) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 3,
                                    color: Colors.grey,
                                    offset: Offset(0, 0)),
                              ]),
                          child: Column(
                            children: [
                              const SizedBox(height: 13),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  snanshot.data![index]['image'].toString(),
                                  fit: BoxFit.contain,
                                  height: media.width * 0.3,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        snanshot.data![index]['title']
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        snanshot.data![index]['description']
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        snanshot.data![index]['category']
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.orangeAccent,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "\$${snanshot.data![index]['price']}"
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontSize: 21,
                                            color: Colors.pinkAccent,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          );
        },
      ),
    );
  }
}
