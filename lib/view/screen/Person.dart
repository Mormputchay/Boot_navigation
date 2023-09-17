import 'package:flutter/material.dart';

import '../../comment_widget/utils.dart';

class PersonView extends StatefulWidget {
  const PersonView({super.key});
  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  late UniqueKey keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  static const double radius = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text("Expansion Tile"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                  side: const BorderSide(color: Colors.black, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () => isExpanded ? shrinkTile() : expandTile(),
                          child: buildImage()),
                      buildText(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildImage() => Image.network(
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Power_Rangers_Samurai.jpg/640px-Power_Rangers_Samurai.jpg",
        fit: BoxFit.cover,
        height: 390,
        width: double.maxFinite,
      );
  Widget buildText(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
          title: const Text(
            '👩 Sarah Pepperstone',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          children: const [
            Text(
              "Power Rangers is an entertainment and merchandising franchise built around a "
              "live-action superhero television series, based on the Japanese tokusatsu "
              "franchise Super Sentai. Produced first by Saban Entertainment, second "
              "by BVS Entertainment, later by Saban Brands, and today by SCG Power"
              "Rangers LLC and its parent company, Hasbro, the Power Rangers television "
              "series takes much of its footage from the Super Sentai television series,"
              " produced by Toei Company.[1] The first Power Rangers entry, Mighty "
              "Morphin Power Rangers, debuted on August 28, 1993, and helped "
              "launch the Fox Kids programming block of the 1990s, during which "
              "it catapulted into popular culture along with a line of action "
              "figures and other toys by Bandai.[2] By 2001, the media "
              "franchise had generated over 6 billion in toy sales.[3]Despite initial "
              "criticism that its action violence targeted child audiences, the "
              "franchise has been commercially successful. As of 2022, Power Rangers "
              "consists of 29 television seasons of 21 different themed series and "
              "three theatrical films released in 1995, 1997, and 2017.In 2010, Haim Saban,"
              " creator of the series, regained ownership of the franchise. It was previously "
              "owned for eight years by The Walt Disney Company. In 2018, "
              "Hasbro was named the new master toy licensee. Shortly afterwards, "
              "Saban Brands and Hasbro announced that the latter would acquire the franchise "
              "and the rest of the former's entertainment assets in a"
              " 522 million deal, with the first products from Hasbro becoming "
              "available in early 2019",
              style: TextStyle(fontSize: 18, height: 1.4),
            ),
          ],
          onExpansionChanged: (isExpanded) => Utils.showSnackBar(
            context,
            text: isExpanded ? 'Expand Tile' : 'Shrink Tile',
            color: isExpanded ? Colors.green : Colors.red,
          ),
        ),
      );
}
