import 'package:flutter/material.dart';
import 'package:compus/functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'item_data.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  void fetchData(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      setState(() {
        dataFetched = true;
      });
    }
  }

  @override
  void initState() {
    fetchData(url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.15,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Center(
                          child: Text('Compus',
                              style: TextStyle(
                                  fontSize: 35.0,
                                  letterSpacing: 2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700))),
                    ),
                    Container(
                      height: 20,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.005,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery
                              .of(context)
                              .size
                              .width * 0.20,
                          vertical: 10.0),
                    ),
                    Icon(
                      Icons.search,
                      size: 40,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xff000000),
                                  border: Border.all(
                                      color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50.0))),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 10.0,
                                  horizontal: 20.0),
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text('All', style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                          onTap: () {}),
                      Navlinks("Clothes"),
                      Navlinks("Shoes"),
                      Navlinks("Bags"),
                      Navlinks("Electric"),
                    ],
                  ),
                ),
              ),
              dataFetched
                  ? GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 7.5 / 10.0,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    ItemData(
                                      itemdesc: data[index],
                                    )
                            ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${data[index]['image']}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text('${data[index]['category']}',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            letterSpacing: 1.5,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700)),

                                    Row(
                                      children: [
                                        Icon(Icons.star_half_outlined),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              '${data[index]['rating']['rate']}',
                                              style: TextStyle(fontSize: 15.0)),
                                        ),
                                        Container(
                                          height: 20,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.005,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 10.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        Container(
                                          height: 20,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.20,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15),
                                            color: Color(0xffbfbfbf),
                                          ),
                                          child: Center(
                                              child: Text(
                                                  "${data[index]['rating']['count']} sold",
                                                  style: TextStyle(
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                      FontWeight.bold))),
                                        )
                                      ],
                                    ),
                                    Text('\$${data[index]['price']}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            letterSpacing: 1.5,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ));
                  })
                  : CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector Navlinks(String name) {
    return GestureDetector(
        child: Container(
            decoration: BoxDecoration(
                border:
                Border.all(color: Colors.black, width: 2),
                borderRadius:
                BorderRadius.all(Radius.circular(50.0))),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 20.0),
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('${name}',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold))),
        onTap: () {}
    );
  }
}
