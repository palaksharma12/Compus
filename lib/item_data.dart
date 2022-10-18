import 'package:flutter/material.dart';

class ItemData extends StatefulWidget {
  final itemdesc;
  const ItemData({Key? key, required this.itemdesc}) : super(key: key);

  @override
  _ItemDataState createState() => _ItemDataState();
}

class _ItemDataState extends State<ItemData> {

  @override
  void initState() {
    print('---------------------------------------------------------');
    print(widget.itemdesc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Image(
                  image: NetworkImage('${widget.itemdesc['image']}'),
                )
            ),
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child:
                        DataContainer(120, widget.itemdesc['title'],25.0,FontWeight.w800,Colors.black),
                      ),
                      DataContainer(30, widget.itemdesc['category'],20.0,FontWeight.w600, Colors.black87),
                      DataContainer(30,'\$ '+ widget.itemdesc['price'].toString(),25,FontWeight.w800,Colors.black),
                      DataContainer(130, widget.itemdesc['description'],15,FontWeight.w500,Colors.black54),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: Row(
                          children: [
                            Icon(Icons.star_half_outlined),
                            DataContainer(50, widget.itemdesc['rating']['rate'].toString()+
                                ' Rating   |   '+ widget.itemdesc['rating']['count'].toString()+' Sold',15, FontWeight.w500,Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            )

          ],
        ),
      ),
    );
  }

  Padding DataContainer(double height_container, var desc, double font,var weight, var col) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Container(
        height: height_container,
        child: Center(child: Text('${desc}', style: TextStyle( fontSize: font, fontWeight: weight, color: col),
          textAlign: TextAlign.center,)),
      ),
    );
  }
}
