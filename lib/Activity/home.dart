import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
  
}

class _HomeState extends State<Home> {
  
TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }
  String temp = "";
  String air = "";
  String des = "";
  String hum = "";
  String getcity = "";
  @override
  Widget build(BuildContext context) {
    // Check if arguments is null before accessing its properties
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;

    if (info != null) {
     
     temp =  ((info['max_temp_value']).toString());
     air = ((info['air_speed_value']).toString());
    if(temp == "NA")
      {
        print("NA");
      }
    else
      {
        temp =  ((info['max_temp_value']).toString()).substring(0,4);
        air = ((info['air_speed_value']).toString()).substring(0,4);
      }

      
      print("Temperature: $temp");

      String icon = info['Icon'] as String? ??
          ""; // Assuming the key is 'Icon' instead of 'icon'
      print("Icon: $icon");

      getcity = info['city_value'] as String? ?? "";
      print("City: $getcity");

      hum = info['hum_value'] as String? ?? "";
      print("Humidity: $hum");

      
      print("Air Speed: $air");

      des = info['des_value'] as String? ?? "";
      print("Description: $des");
    } else {
      print("Info is null");
      // Handle the case when 'info' is null
    }

    var city_name = ["Mumbai", "Delhi", "Chennai", "Dhar", "Indore", "London"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(0),
      //   child: AppBar(
      //     backgroundColor: Colors.blue,
      //   )
      // ),

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: GradientAppBar(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue, Colors.lightBlueAccent])),
            child: Column(
              children: [
                Container(
                  //Search Wala Container

                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                           if((searchController.text).replaceAll(" ", "") == "")
                            {
                              print("Blank search");
                            }else{
                            Navigator.pushReplacementNamed(context, "/loading",arguments: {
                              "searchText" : searchController.text,
                            });
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                          margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search $city"),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          padding: EdgeInsets.all(26),
                          child: Row(children: [
                            Image.network(
                                "https://openweathermap.org/img/wn/10d@2x.png"),
                            Column(
                              children: [
                                Text(
                                  "$des",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "in $getcity",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ])),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(fontSize: 90),
                                ),
                                Text(
                                  "C",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(26),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Icon(WeatherIcons.wind)],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$air",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("km/hr")
                          ],
                        ),
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        padding: EdgeInsets.all(26),
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [ Icon(WeatherIcons.day_sunny)],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$hum",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("Percent")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made By Utsav"),
                      Text("Data Provided By Openweathermap.org")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
