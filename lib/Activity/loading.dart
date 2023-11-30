import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mausam/Workers/worker.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String max_temp = "";
  String min_temp = "";
  String hum = "";
  String air_speed = "";
  String des = "";
  String main = "";
  String Iconss = "";
  String city = "Kolkata";
  void startApp(String city) async {
    Worker instance = Worker(location: city);
    await instance.getData();

    max_temp = instance.tempMax;
    min_temp = instance.tempMin;
    hum = instance.humidity;
    air_speed = instance.windSpeed;
    des = instance.desc;
    Iconss = instance.icon;
    print(Iconss);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "max_temp_value": max_temp,
        "min_temp_value": min_temp,
        "hum_value": hum,
        "air_speed_value": air_speed,
        "des_value": des,
        "humidity": hum,
        "Icon": Iconss,
        "city_value": city
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;

    if (search != null && search.isNotEmpty) {
      city = search['searchText'];
    } else {
      city = "kolkata";
    }

    startApp(city);

    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/mlogo.png",
                height: 240,
                width: 240,
              ),
              Text(
                "Mausam App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Made by Utsav",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              SpinKitWave(
                color: Colors.white,
                size: 50.0,
              ),
            ]),
      ),
      backgroundColor: Colors.blue[300],
    );
  }
}
