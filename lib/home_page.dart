import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practice_adfd/entities/place_entity.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Future<List<Place>> fetchData () async {
    String url = "https://localhost:8081/place/get-all";
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body) as List;
        return data.map((e) => Place.valueFromJson(e)).toList();
      }
    }catch(e){
      print(e);
    }
    return [];
  }
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      margin: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(margin: EdgeInsets.all(10),
            child: Row(children: [
              Expanded(flex: 1,
                  child: Column(children: [
                    Container(width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pinkAccent,),
                      child: Center(
                        child: Image.asset("images/ico_hotel.png"),),),
                    Text("Hotels", style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300))
                  ],)),
              SizedBox(width: 10,),
              Expanded(flex: 1,
                  child: Column(children: [
                    Container(width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pinkAccent,),
                      child: Center(
                        child: Image.asset("images/ico_plane.png"),),),
                    Text("Flights", style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300))
                  ],)),
              SizedBox(width: 10,),
              Expanded(flex: 1,
                  child: Column(children: [
                    Container(width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.pinkAccent,),
                      child: Center(
                        child: Image.asset("images/ico_hotel_plane.png"),),),
                    Text("All", style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300),)
                  ],)),
            ],),),
          Text("Popular Destinations",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          FutureBuilder<List<Place>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text("Error loading data");
              } else if (snapshot.hasData) {
                List<Place> places = snapshot.data!;
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: places.map((Place item) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item.image??""),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name??"",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${item.star}",
                                      style: TextStyle(fontSize: 14, color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Text("No data");
              }
            },
          )
        ],
      ),
    );
  }
}
