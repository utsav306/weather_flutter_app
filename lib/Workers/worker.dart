import 'package:http/http.dart';
import 'dart:convert';

class Worker {
  String location = "";
  String tempMax = "";
  String tempMin = "";
  String humidity = "";
  String windSpeed = ""; // Change to double
  String desc = "";
  String icon = "";
  Worker({this.location = ""}) {
    location = this.location;
  }

  Future<void> getData() async {
    try {
      Uri url = Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=ee717e06d63b82962d3b93febae6bb43");

      Response response = await get(url);

      Map data = jsonDecode(response.body);

      // Access 'main' directly since it's an object, not an array
      Map mainData = data['main'];

      // Explicitly cast values to double
      double temp_max = mainData['temp_max'].toDouble()-273.15;
      double temp_min = mainData['temp_min'].toDouble();
      double Humidity = mainData['humidity'].toDouble();

      // Access 'weather' array and get description from the first element
      List<dynamic> weatherData = data['weather'];
      String desci = "";
      if (weatherData.isNotEmpty) {
        // Assuming you want to get the description from the first element
        desci = weatherData[0]['description'];
        icon = weatherData[0]['icon'];
      }

      // Access 'wind' directly since it's an object, not an array
      Map windData = data['wind'];
      double wind_speed = windData['speed'].toDouble()/0.2777778;

      //Assigning

      tempMax = temp_max.toString();
      tempMin = temp_min.toString();
      humidity = Humidity.toString();
      desc = desci.toString();
      windSpeed = wind_speed.toString();
      icon = icon.toString();
    } catch (e) {
      tempMax = "NA";
      tempMin = "NA";
      humidity = "NA";
      desc = "NA";
      windSpeed = "NA";
      icon = "03n";
    }
  }
}

void main() async {
  Worker instance = Worker(location: "haldia");
  await instance.getData();
  print(instance.tempMax);
}
